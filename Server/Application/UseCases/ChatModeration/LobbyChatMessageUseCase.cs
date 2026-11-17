using System;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

using Application.Models;
using Application.Ports;
using Domain;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Application
{
    /// <summary>Moderates both languages and persists the sanction decision before permitting publication.</summary>
    public sealed class LobbyChatMessageUseCase : ILobbyChatMessageUseCase
    {
        private const string ChatModerationMatchingTimeoutTemplate =
            "Chat moderation exceeded regex matching budget for user {UserId} in lobby {LobbyCode}. Failure " +
            "type {FailureType}.";
        private const string ChatModerationMessageTimeoutTemplate =
            "Chat moderation exceeded message budget for user {UserId} in lobby {LobbyCode}. Failure " +
            "type {FailureType}.";
        private const string ChatInfractionDetectedTemplate =
            "Chat infraction of category {InfractionCategory} detected for user {UserId} in lobby {LobbyCode}.";
        private const string ChatMessageRejectedBannedAccountTemplate =
            "Chat message rejected: user {UserId} has an active chat ban in lobby {LobbyCode}.";
        private const string ChatInfractionPersistenceFailureTemplate =
            "Aborted chat infraction recording for user {UserId} in lobby {LobbyCode} due to database failure.";

        private readonly ChatMessageModerator _chatMessageModerator;
        private readonly IChatInfractionRepository _chatInfractionRepository;
        private readonly ILoggerService _moderationLogger;

        public LobbyChatMessageUseCase(ChatModerationPreparation moderationPreparation,
            IChatInfractionRepository chatInfractionRepository, ILoggerService moderationLogger)
        {
            if (moderationPreparation == null)
            {
                throw new ArgumentNullException(nameof(moderationPreparation));
            }

            _chatMessageModerator = moderationPreparation.MessageModerator;
            _chatInfractionRepository = chatInfractionRepository ??
                throw new ArgumentNullException(nameof(chatInfractionRepository));
            _moderationLogger = moderationLogger ?? throw new ArgumentNullException(nameof(moderationLogger));
        }

        public bool IsChatSendingAvailable => _chatMessageModerator != null;

        public LobbyChatMessageProcessing ProcessChatMessage(AuthenticatedChatMessageSubmission chatMessageSubmission)
        {
            LobbyChatMessageProcessing chatMessageProcessing = new LobbyChatMessageProcessing
            {
                ChatMessageRejectionReason = ChatMessageRejectionReason.InvalidChatMessage
            };
            if (!IsChatSendingAvailable)
            {
                chatMessageProcessing.ChatMessageRejectionReason = ChatMessageRejectionReason.ChatModerationUnavailable;
            }
            else if (IsValidChatMessageSubmission(chatMessageSubmission))
            {
                try
                {
                    chatMessageProcessing = ModerateAndRecordChatMessage(chatMessageSubmission);
                }
                catch (RegexMatchTimeoutException ex)
                {
                    _moderationLogger.Warning(ChatModerationMatchingTimeoutTemplate,
                        chatMessageSubmission.AccountUserId, chatMessageSubmission.LobbyCode, ex.GetType().Name);
                    chatMessageProcessing.ChatMessageRejectionReason =
                        ChatMessageRejectionReason.ChatModerationUnavailable;
                }
                catch (TimeoutException ex)
                {
                    _moderationLogger.Warning(ChatModerationMessageTimeoutTemplate,
                        chatMessageSubmission.AccountUserId, chatMessageSubmission.LobbyCode, ex.GetType().Name);
                    chatMessageProcessing.ChatMessageRejectionReason =
                        ChatMessageRejectionReason.ChatModerationUnavailable;
                }
                catch (InvalidOperationException)
                {
                    _moderationLogger.Warning(ChatInfractionPersistenceFailureTemplate,
                        chatMessageSubmission.AccountUserId, chatMessageSubmission.LobbyCode);
                    chatMessageProcessing.ChatMessageRejectionReason =
                        ChatMessageRejectionReason.ChatModerationUnavailable;
                }
            }

            return chatMessageProcessing;
        }

        private static bool IsValidChatMessageSubmission(AuthenticatedChatMessageSubmission chatMessageSubmission)
        {
            return chatMessageSubmission != null && chatMessageSubmission.AccountUserId > 0 &&
                chatMessageSubmission.ChatMessageSubmissionId != Guid.Empty &&
                !string.IsNullOrWhiteSpace(chatMessageSubmission.OriginalChatMessageText) &&
                chatMessageSubmission.OriginalChatMessageText.Length <= ChatInfractionRules.MaximumChatMessageLength;
        }

        private LobbyChatMessageProcessing ModerateAndRecordChatMessage(
            AuthenticatedChatMessageSubmission chatMessageSubmission)
        {
            ChatMessageModerationDecision moderationDecision = _chatMessageModerator.EvaluateChatMessage(
                chatMessageSubmission.OriginalChatMessageText);
            ChatInfractionRecord recordedChatInfraction = _chatInfractionRepository.RecordChatMessageInfraction(
                new ChatInfractionSubmission
                {
                    AccountUserId = chatMessageSubmission.AccountUserId,
                    ChatMessageSubmissionId = chatMessageSubmission.ChatMessageSubmissionId,
                    ChatMessageContentDigest = ComputeChatMessageContentDigest(chatMessageSubmission),
                    DetectedInfractionCategory = moderationDecision.DetectedInfractionCategory
                });
            if (moderationDecision.DetectedInfractionCategory != ChatInfractionCategory.None)
            {
                _moderationLogger.Warning(ChatInfractionDetectedTemplate,
                    moderationDecision.DetectedInfractionCategory,
                    chatMessageSubmission.AccountUserId,
                    chatMessageSubmission.LobbyCode);
            }

            ChatMessageRejectionReason chatMessageRejectionReason = ChatMessageRejectionReason.None;
            if (recordedChatInfraction.HasConflictingChatMessageIdentifier)
            {
                chatMessageRejectionReason = ChatMessageRejectionReason.ConflictingChatMessageIdentifier;
            }
            else if (recordedChatInfraction.IsAccountBanned)
            {
                _moderationLogger.Warning(ChatMessageRejectedBannedAccountTemplate,
                    chatMessageSubmission.AccountUserId,
                    chatMessageSubmission.LobbyCode);
                chatMessageRejectionReason = ChatMessageRejectionReason.ChatAccountBanned;
            }

            return new LobbyChatMessageProcessing
            {
                CanPublishChatMessage = chatMessageRejectionReason == ChatMessageRejectionReason.None &&
                    !recordedChatInfraction.IsRepeatedChatMessageSubmission,
                ChatMessageRejectionReason = chatMessageRejectionReason,
                CensoredChatMessageText = moderationDecision.CensoredChatMessageText,
                RecordedChatInfraction = recordedChatInfraction
            };
        }

        private static string ComputeChatMessageContentDigest(AuthenticatedChatMessageSubmission chatMessageSubmission)
        {
            byte[] chatMessageDigest;
            using (SHA256 chatMessageHasher = SHA256.Create())
            {
                string chatMessageIdentityText = chatMessageSubmission.LobbyCode.Trim().ToUpperInvariant() + "\n" +
                    chatMessageSubmission.OriginalChatMessageText;
                chatMessageDigest = chatMessageHasher.ComputeHash(Encoding.UTF8.GetBytes(chatMessageIdentityText));
            }

            return Convert.ToBase64String(chatMessageDigest);
        }
    }
}
