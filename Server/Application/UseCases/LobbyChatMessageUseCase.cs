using System.Security.Cryptography;
using System.Text;
using System;

using Application.Models;
using Application.Ports;
using Domain;

namespace Application
{
    /// <summary>Moderates both languages and persists the sanction decision before permitting publication.</summary>
    public sealed class LobbyChatMessageUseCase : ILobbyChatMessageUseCase
    {
        private readonly ChatMessageModerator _chatMessageModerator;
        private readonly IChatInfractionRepository _chatInfractionRepository;

        public LobbyChatMessageUseCase(IProhibitedChatExpressionCatalog prohibitedChatExpressionCatalog,
            IChatInfractionRepository chatInfractionRepository)
        {
            _chatMessageModerator = new ChatMessageModerator(
                prohibitedChatExpressionCatalog.GetAllSupportedLanguageExpressions());
            _chatInfractionRepository = chatInfractionRepository;
        }

        public LobbyChatMessageProcessing ProcessChatMessage(AuthenticatedChatMessageSubmission chatMessageSubmission)
        {
            LobbyChatMessageProcessing chatMessageProcessing = new LobbyChatMessageProcessing
            {
                ChatMessageRejectionReason = ChatMessageRejectionReason.InvalidChatMessage
            };
            if (IsValidChatMessageSubmission(chatMessageSubmission))
            {
                chatMessageProcessing = ModerateAndRecordChatMessage(chatMessageSubmission);
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
            ChatMessageRejectionReason chatMessageRejectionReason = ChatMessageRejectionReason.None;
            if (recordedChatInfraction.HasConflictingChatMessageIdentifier)
            {
                chatMessageRejectionReason = ChatMessageRejectionReason.ConflictingChatMessageIdentifier;
            }
            else if (recordedChatInfraction.IsAccountBanned)
            {
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
