using System.Collections.Generic;
using System;

using Application.Models;
using Application.Ports;
using Domain;

namespace ChatModeration.Tests
{
    /// <summary>
    /// In-memory boundary substitute; does not claim to verify SQL transactions or restart durability.
    /// </summary>
    internal sealed class TestChatInfractionRepository : IChatInfractionRepository
    {
        private readonly object _accountLock = new object();
        private readonly Dictionary<int, ChatAccountInfractionState> _accountStates =
            new Dictionary<int, ChatAccountInfractionState>();
        private readonly Dictionary<string, string> _submissionDigests = new Dictionary<string, string>();

        public ChatAccountInfractionState GetAccountInfractionState(int accountUserId)
        {
            ChatAccountInfractionState accountInfractionState;
            lock (_accountLock)
            {
                if (!_accountStates.TryGetValue(accountUserId, out accountInfractionState))
                {
                    accountInfractionState = new ChatAccountInfractionState();
                    _accountStates.Add(accountUserId, accountInfractionState);
                }
            }

            return accountInfractionState;
        }

        public ChatInfractionRecord RecordChatMessageInfraction(ChatInfractionSubmission chatInfractionSubmission)
        {
            ChatInfractionRecord recordedChatInfraction;
            lock (_accountLock)
            {
                ChatAccountInfractionState accountInfractionState = GetAccountInfractionState(chatInfractionSubmission.AccountUserId);
                string submissionKey = chatInfractionSubmission.AccountUserId + ":" + chatInfractionSubmission.ChatMessageSubmissionId;
                bool isRepeated = _submissionDigests.TryGetValue(submissionKey, out string existingDigest);
                if (!isRepeated)
                {
                    ChatInfractionRules.ApplyMessageInfraction(accountInfractionState, chatInfractionSubmission.DetectedInfractionCategory, DateTime.UtcNow);
                    _submissionDigests.Add(submissionKey, chatInfractionSubmission.ChatMessageContentDigest);
                }

                recordedChatInfraction = new ChatInfractionRecord
                {
                    AccountInfractionState = accountInfractionState,
                    IsRepeatedChatMessageSubmission = isRepeated,
                    HasConflictingChatMessageIdentifier = isRepeated && existingDigest != chatInfractionSubmission.ChatMessageContentDigest,
                    CurrentMessageInfractionPoints = ChatInfractionRules.GetMessageInfractionPoints(
                        chatInfractionSubmission.DetectedInfractionCategory),
                    IsAccountBanned = ChatInfractionRules.IsAccountBanned(accountInfractionState, DateTime.UtcNow)
                };
            }

            return recordedChatInfraction;
        }
    }
}
