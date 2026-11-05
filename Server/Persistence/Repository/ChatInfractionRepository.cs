using System;
using System.Data.SqlClient;

using Application.Models;
using Application.Ports;
using Domain;
using Persistence.Entities;

namespace Persistence.Repository
{
    /// <summary>Commits per-account moderation decisions with SQL transaction locks and replay protection.</summary>
    public sealed class ChatInfractionRepository : IChatInfractionRepository
    {
        private const string SelectAccountStateSql =
            "SELECT AccumulatedChatInfractionPoints, ThreateningChatMessageCount, PreviousTemporaryChatBanCount, " +
            "IsChatAccountPermanentlyBanned, ChatAccountBanEndsAtUtc FROM dbo.ChatModerationAccount " +
            "WHERE AccountUserId=@accountUserId";
        private const string UpdateAccountStateSql =
            "UPDATE dbo.ChatModerationAccount SET AccumulatedChatInfractionPoints=@accumulatedChatInfractionPoints, " +
            "ThreateningChatMessageCount=@threateningChatMessageCount, " +
            "PreviousTemporaryChatBanCount=@previousTemporaryChatBanCount, " +
            "IsChatAccountPermanentlyBanned=@isChatAccountPermanentlyBanned, " +
            "ChatAccountBanEndsAtUtc=@chatAccountBanEndsAtUtc WHERE AccountUserId=@accountUserId";
        private const string AcquireAccountLockSql =
            "DECLARE @lockResult int; EXEC @lockResult=sys.sp_getapplock @Resource=@accountLockResource, " +
            "@LockMode='Exclusive', @LockOwner='Transaction', @LockTimeout=5000; " +
            "IF @lockResult < 0 THROW 51000, 'Unable to acquire account moderation lock.', 1;";

        private readonly IChatModerationLogger _chatModerationLogger;

        public ChatInfractionRepository(IChatModerationLogger chatModerationLogger)
        {
            _chatModerationLogger = chatModerationLogger;
        }

        public ChatAccountInfractionState GetAccountInfractionState(int accountUserId)
        {
            ChatAccountInfractionState accountInfractionState;
            try
            {
                using (SqlConnection moderationConnection = ModerationDatabaseConnection.Open())
                {
                    accountInfractionState = ReadAccountState(moderationConnection, null, accountUserId);
                }
            }
            catch (SqlException ex)
            {
                _chatModerationLogger.RecordPersistenceFailure(nameof(GetAccountInfractionState), ex);
                throw;
            }

            return accountInfractionState;
        }

        public ChatInfractionRecord RecordChatMessageInfraction(ChatInfractionSubmission chatInfractionSubmission)
        {
            ChatInfractionRecord recordedChatInfraction;
            try
            {
                using (SqlConnection moderationConnection = ModerationDatabaseConnection.Open())
                using (SqlTransaction moderationTransaction = moderationConnection.BeginTransaction())
                {
                    AcquireAccountLock(moderationTransaction, chatInfractionSubmission.AccountUserId);
                    recordedChatInfraction = RecordUnderAccountLock(moderationTransaction, chatInfractionSubmission);
                    moderationTransaction.Commit();
                }
            }
            catch (SqlException ex)
            {
                _chatModerationLogger.RecordPersistenceFailure(nameof(RecordChatMessageInfraction), ex);
                throw;
            }
            catch (InvalidOperationException ex)
            {
                _chatModerationLogger.RecordPersistenceFailure(nameof(RecordChatMessageInfraction), ex);
                throw;
            }

            return recordedChatInfraction;
        }

        private static ChatInfractionRecord RecordUnderAccountLock(SqlTransaction moderationTransaction,
            ChatInfractionSubmission chatInfractionSubmission)
        {
            EnsureAccountStateExists(moderationTransaction, chatInfractionSubmission.AccountUserId);
            ChatAccountInfractionState accountInfractionState = ReadAccountState(
                moderationTransaction.Connection, moderationTransaction, chatInfractionSubmission.AccountUserId);
            DateTime evaluatedAtUtc = ReadDatabaseUtcTime(moderationTransaction);
            ChatInfractionRules.ResetExpiredCycle(accountInfractionState, evaluatedAtUtc);
            ChatInfractionRecord recordedChatInfraction = ReadPreviousSubmission(
                moderationTransaction, chatInfractionSubmission);
            recordedChatInfraction.AccountInfractionState = accountInfractionState;
            if (!recordedChatInfraction.IsRepeatedChatMessageSubmission &&
                !ChatInfractionRules.IsAccountBanned(accountInfractionState, evaluatedAtUtc))
            {
                ChatInfractionRules.ApplyMessageInfraction(accountInfractionState,
                    chatInfractionSubmission.DetectedInfractionCategory, evaluatedAtUtc);
                recordedChatInfraction.CurrentMessageInfractionPoints = ChatInfractionRules.GetMessageInfractionPoints(
                    chatInfractionSubmission.DetectedInfractionCategory);
                InsertSubmission(moderationTransaction, chatInfractionSubmission, recordedChatInfraction);
            }

            recordedChatInfraction.IsAccountBanned = ChatInfractionRules.IsAccountBanned(
                accountInfractionState, evaluatedAtUtc);
            SaveAccountState(moderationTransaction, chatInfractionSubmission.AccountUserId, accountInfractionState);
            if (accountInfractionState.IsChatAccountPermanentlyBanned)
            {
                BlockedAccountEmailRepository.BlockAccountEmail(moderationTransaction,
                    chatInfractionSubmission.AccountUserId);
            }

            return recordedChatInfraction;
        }

        private static ChatAccountInfractionState ReadAccountState(SqlConnection moderationConnection,
            SqlTransaction moderationTransaction, int accountUserId)
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState();
            using (SqlCommand moderationCommand = new SqlCommand(
                SelectAccountStateSql, moderationConnection, moderationTransaction))
            {
                moderationCommand.Parameters.AddWithValue("@accountUserId", accountUserId);
                using (SqlDataReader stateReader = moderationCommand.ExecuteReader())
                {
                    if (stateReader.Read())
                    {
                        accountInfractionState = MapAccountState(stateReader);
                    }
                }
            }

            return accountInfractionState;
        }

        private static ChatAccountInfractionState MapAccountState(SqlDataReader stateReader)
        {
            DateTime? chatAccountBanEndsAtUtc = null;
            if (!stateReader.IsDBNull(4))
            {
                chatAccountBanEndsAtUtc = DateTime.SpecifyKind(stateReader.GetDateTime(4), DateTimeKind.Utc);
            }

            return new ChatAccountInfractionState
            {
                AccumulatedChatInfractionPoints = stateReader.GetInt32(0),
                ThreateningChatMessageCount = stateReader.GetInt32(1),
                PreviousTemporaryChatBanCount = stateReader.GetInt32(2),
                IsChatAccountPermanentlyBanned = stateReader.GetBoolean(3),
                ChatAccountBanEndsAtUtc = chatAccountBanEndsAtUtc
            };
        }

        private static void AcquireAccountLock(SqlTransaction moderationTransaction, int accountUserId)
        {
            using (SqlCommand moderationCommand = new SqlCommand(AcquireAccountLockSql,
                moderationTransaction.Connection, moderationTransaction))
            {
                moderationCommand.Parameters.AddWithValue("@accountLockResource",
                    "ChatModerationAccount:" + accountUserId);
                moderationCommand.ExecuteNonQuery();
            }
        }

        private static void EnsureAccountStateExists(SqlTransaction moderationTransaction, int accountUserId)
        {
            const string InsertAccountStateSql =
                "IF NOT EXISTS (SELECT 1 FROM dbo.ChatModerationAccount WHERE AccountUserId=@accountUserId) " +
                "INSERT INTO dbo.ChatModerationAccount(AccountUserId) VALUES(@accountUserId)";
            using (SqlCommand moderationCommand = new SqlCommand(InsertAccountStateSql,
                moderationTransaction.Connection, moderationTransaction))
            {
                moderationCommand.Parameters.AddWithValue("@accountUserId", accountUserId);
                moderationCommand.ExecuteNonQuery();
            }
        }

        private static DateTime ReadDatabaseUtcTime(SqlTransaction moderationTransaction)
        {
            DateTime evaluatedAtUtc;
            using (SqlCommand moderationCommand = new SqlCommand("SELECT SYSUTCDATETIME()",
                moderationTransaction.Connection, moderationTransaction))
            {
                evaluatedAtUtc = DateTime.SpecifyKind((DateTime)moderationCommand.ExecuteScalar(), DateTimeKind.Utc);
            }

            return evaluatedAtUtc;
        }

        private static ChatInfractionRecord ReadPreviousSubmission(SqlTransaction moderationTransaction,
            ChatInfractionSubmission chatInfractionSubmission)
        {
            const string SelectSubmissionSql = "SELECT ChatMessageContentDigest, CurrentMessageInfractionPoints " +
                "FROM dbo.ChatModerationSubmission WHERE AccountUserId=@accountUserId " +
                "AND ChatMessageSubmissionId=@chatMessageSubmissionId";
            ChatInfractionRecord recordedChatInfraction = new ChatInfractionRecord();
            using (SqlCommand moderationCommand = new SqlCommand(SelectSubmissionSql,
                moderationTransaction.Connection, moderationTransaction))
            {
                AddSubmissionIdentityParameters(moderationCommand, chatInfractionSubmission);
                using (SqlDataReader submissionReader = moderationCommand.ExecuteReader())
                {
                    if (submissionReader.Read())
                    {
                        recordedChatInfraction.IsRepeatedChatMessageSubmission = true;
                        recordedChatInfraction.HasConflictingChatMessageIdentifier =
                            submissionReader.GetString(0) != chatInfractionSubmission.ChatMessageContentDigest;
                        recordedChatInfraction.CurrentMessageInfractionPoints = submissionReader.GetInt32(1);
                    }
                }
            }

            return recordedChatInfraction;
        }

        private static void InsertSubmission(SqlTransaction moderationTransaction,
            ChatInfractionSubmission chatInfractionSubmission, ChatInfractionRecord recordedChatInfraction)
        {
            const string InsertSubmissionSql = "INSERT INTO dbo.ChatModerationSubmission " +
                "(AccountUserId,ChatMessageSubmissionId,ChatMessageContentDigest,CurrentMessageInfractionPoints) " +
                "VALUES(@accountUserId,@chatMessageSubmissionId," +
                "@chatMessageContentDigest,@currentMessageInfractionPoints)";
            using (SqlCommand moderationCommand = new SqlCommand(InsertSubmissionSql,
                moderationTransaction.Connection, moderationTransaction))
            {
                AddSubmissionIdentityParameters(moderationCommand, chatInfractionSubmission);
                moderationCommand.Parameters.AddWithValue("@chatMessageContentDigest",
                    chatInfractionSubmission.ChatMessageContentDigest);
                moderationCommand.Parameters.AddWithValue("@currentMessageInfractionPoints",
                    recordedChatInfraction.CurrentMessageInfractionPoints);
                moderationCommand.ExecuteNonQuery();
            }
        }

        private static void AddSubmissionIdentityParameters(SqlCommand moderationCommand,
            ChatInfractionSubmission chatInfractionSubmission)
        {
            moderationCommand.Parameters.AddWithValue("@accountUserId", chatInfractionSubmission.AccountUserId);
            moderationCommand.Parameters.AddWithValue("@chatMessageSubmissionId",
                chatInfractionSubmission.ChatMessageSubmissionId);
        }

        private static void SaveAccountState(SqlTransaction moderationTransaction, int accountUserId,
            ChatAccountInfractionState accountInfractionState)
        {
            using (SqlCommand moderationCommand = new SqlCommand(UpdateAccountStateSql,
                moderationTransaction.Connection, moderationTransaction))
            {
                moderationCommand.Parameters.AddWithValue("@accountUserId", accountUserId);
                moderationCommand.Parameters.AddWithValue("@accumulatedChatInfractionPoints",
                    accountInfractionState.AccumulatedChatInfractionPoints);
                moderationCommand.Parameters.AddWithValue("@threateningChatMessageCount",
                    accountInfractionState.ThreateningChatMessageCount);
                moderationCommand.Parameters.AddWithValue("@previousTemporaryChatBanCount",
                    accountInfractionState.PreviousTemporaryChatBanCount);
                moderationCommand.Parameters.AddWithValue("@isChatAccountPermanentlyBanned",
                    accountInfractionState.IsChatAccountPermanentlyBanned);
                object chatAccountBanEndValue = DBNull.Value;
                if (accountInfractionState.ChatAccountBanEndsAtUtc.HasValue)
                {
                    chatAccountBanEndValue = accountInfractionState.ChatAccountBanEndsAtUtc.Value;
                }

                moderationCommand.Parameters.AddWithValue("@chatAccountBanEndsAtUtc", chatAccountBanEndValue);
                moderationCommand.ExecuteNonQuery();
            }
        }
    }
}
