using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

using Application.Ports;

namespace Persistence.Repository
{
    /// <summary>Retains hashed normalized email restrictions independently of the account lifecycle.</summary>
    public sealed class BlockedAccountEmailRepository : IBlockedAccountEmailRepository
    {
        private const string SelectBlockedEmailSql =
            "SELECT COUNT(1) FROM dbo.PermanentlyBlockedAccountEmail WHERE NormalizedAccountEmailDigest=@emailDigest";
        private const string InsertBlockedEmailSql =
            "IF NOT EXISTS (SELECT 1 FROM dbo.PermanentlyBlockedAccountEmail WITH (UPDLOCK,HOLDLOCK) " +
            "WHERE NormalizedAccountEmailDigest=@emailDigest) " +
            "INSERT INTO dbo.PermanentlyBlockedAccountEmail(NormalizedAccountEmailDigest) VALUES(@emailDigest)";

        private readonly IChatModerationLogger _chatModerationLogger;

        public BlockedAccountEmailRepository(IChatModerationLogger chatModerationLogger)
        {
            _chatModerationLogger = chatModerationLogger ??
                throw new ArgumentNullException(nameof(chatModerationLogger));
        }

        public bool IsAccountEmailPermanentlyBlocked(string accountEmail)
        {
            bool isAccountEmailBlocked;
            try
            {
                using (SqlConnection moderationConnection = ModerationDatabaseConnection.Open())
                using (SqlCommand blockedEmailQuery = new SqlCommand(SelectBlockedEmailSql, moderationConnection))
                {
                    AddEmailDigestParameter(blockedEmailQuery, accountEmail);
                    isAccountEmailBlocked = (int)blockedEmailQuery.ExecuteScalar() > 0;
                }
            }
            catch (SqlException ex)
            {
                _chatModerationLogger.RecordPersistenceFailure(nameof(IsAccountEmailPermanentlyBlocked), ex);
                throw new InvalidOperationException("Unable to verify permanent email restrictions.", ex);
            }

            return isAccountEmailBlocked;
        }

        internal static void BlockAccountEmail(SqlTransaction moderationTransaction, int accountUserId)
        {
            string accountEmail;
            using (SqlCommand accountEmailQuery = new SqlCommand(
                "SELECT Email FROM dbo.[User] WHERE IdUser=@accountUserId",
                moderationTransaction.Connection, moderationTransaction))
            {
                accountEmailQuery.Parameters.Add("@accountUserId", SqlDbType.Int).Value = accountUserId;
                accountEmail = accountEmailQuery.ExecuteScalar() as string;
            }

            if (string.IsNullOrWhiteSpace(accountEmail))
            {
                throw new InvalidOperationException("Permanent restriction requires an existing account email.");
            }

            using (SqlCommand blockedEmailInsert = new SqlCommand(InsertBlockedEmailSql,
                moderationTransaction.Connection, moderationTransaction))
            {
                AddEmailDigestParameter(blockedEmailInsert, accountEmail);
                blockedEmailInsert.ExecuteNonQuery();
            }
        }

        private static void AddEmailDigestParameter(SqlCommand emailCommand, string accountEmail)
        {
            string normalizedAccountEmail = accountEmail.Trim().ToUpperInvariant();
            using (SHA256 emailHasher = SHA256.Create())
            {
                emailCommand.Parameters.Add("@emailDigest", SqlDbType.Binary, 32).Value =
                    emailHasher.ComputeHash(Encoding.Unicode.GetBytes(normalizedAccountEmail));
            }
        }
    }
}
