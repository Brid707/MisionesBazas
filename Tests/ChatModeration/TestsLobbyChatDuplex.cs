using System.ServiceModel;
using System;

using Remote = Model.GameServices;

namespace ChatModeration.Tests
{
    public static class TestsLobbyChatDuplex
    {
        public static void SendLobbyChatMessage_MixedLanguages_PublishesOnlyMaskedText()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                chatDuplexEnvironment.SendParticipantMessage(Guid.NewGuid(), "idiota asshole");
                chatDuplexEnvironment.HostCallback.MessageReceived.WaitOne(5000);
                chatDuplexEnvironment.HostCallback.ReceivedMessages.TryDequeue(out Remote.LobbyMessage receivedMessage);

                TestAssert.Equal("*** ***", receivedMessage?.Message);
            }
        }

        public static void SendLobbyChatMessage_RepeatedSubmission_DoesNotDoubleInfractionPoints()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                Guid submissionId = Guid.NewGuid();

                chatDuplexEnvironment.SendParticipantMessage(submissionId, "idiota");
                chatDuplexEnvironment.SendParticipantMessage(submissionId, "idiota");

                TestAssert.Equal(1, chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2)
                    .AccumulatedChatInfractionPoints);
            }
        }

        public static void SendLobbyChatMessage_ConflictingSubmissionId_RejectsDifferentText()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                Guid submissionId = Guid.NewGuid();
                chatDuplexEnvironment.SendParticipantMessage(submissionId, "hola");

                Remote.LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = chatDuplexEnvironment.SendParticipantMessage(submissionId, "idiota");

                TestAssert.Equal(Remote.ChatMessageRejectionReason.ConflictingChatMessageIdentifier, chatMessageSubmissionOutcome.ChatMessageRejectionReason);
            }
        }

        public static void SendLobbyChatMessage_ThresholdReached_HidesTriggeringMessageAndRemovesParticipant()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2).AccumulatedChatInfractionPoints = 14;

                chatDuplexEnvironment.SendParticipantMessage(Guid.NewGuid(), "idiota");
                chatDuplexEnvironment.HostCallback.ParticipantLeft.WaitOne(5000);

                TestAssert.Equal("0:", chatDuplexEnvironment.HostCallback.ReceivedMessages.Count + ":" +
                    chatDuplexEnvironment.LobbyUseCase.GetParticipantUsername(chatDuplexEnvironment.LobbyCode, 2));
            }
        }

        public static void SendLobbyChatMessage_ThreeThreatsAtThreshold_PermanentlyBansAndRevokesSession()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2).AccumulatedChatInfractionPoints = 12;
                chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2).ThreateningChatMessageCount = 2;

                Remote.LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = chatDuplexEnvironment.SendParticipantMessage(
                    Guid.NewGuid(), "te voy a matar");

                TestAssert.Equal(Remote.ChatAccountBanType.Permanent, chatMessageSubmissionOutcome.ChatAccountBanNotice.ChatAccountBanType);
            }
        }

        public static void SendLobbyChatMessage_MissingAccountToken_RejectsSubmission()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                Remote.LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = chatDuplexEnvironment.ParticipantClient.SendLobbyChatMessage(
                    new Remote.LobbyChatMessageSubmission
                    {
                        ChatMessageSubmissionId = Guid.NewGuid(), LobbyCode = chatDuplexEnvironment.LobbyCode,
                        OriginalChatMessageText = "hola"
                    });

                TestAssert.Equal(Remote.ChatMessageRejectionReason.ChatAuthenticationRequired, chatMessageSubmissionOutcome.ChatMessageRejectionReason);
            }
        }

        public static void JoinLobbyByCode_ForgedAccountId_RejectsImpersonation()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                bool wasImpersonationRejected = false;

                try
                {
                    using (OperationContextScope accountRequestScope = ChatDuplexTestEnvironment.AttachToken(
                        chatDuplexEnvironment.ParticipantClient, chatDuplexEnvironment.ParticipantSessionToken))
                    {
                        chatDuplexEnvironment.ParticipantClient.JoinLobbyByCode(chatDuplexEnvironment.LobbyCode, 3);
                    }
                }
                catch (FaultException)
                {
                    wasImpersonationRejected = true;
                }

                TestAssert.Equal(true, wasImpersonationRejected);
            }
        }

        public static void SendLobbyChatMessage_PermanentBan_RevokesExistingAccountSession()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2)
                    .AccumulatedChatInfractionPoints = 12;
                chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2)
                    .ThreateningChatMessageCount = 2;

                chatDuplexEnvironment.SendParticipantMessage(Guid.NewGuid(), "te voy a matar");

                TestAssert.Equal(0, chatDuplexEnvironment.AccountAccessPolicy.ResolveAllowedAccountUserId(
                    chatDuplexEnvironment.ParticipantSessionToken));
            }
        }

        public static void SendLobbyChatMessage_SeveralProfanitiesInOneMessage_AddsOnePoint()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                chatDuplexEnvironment.SendParticipantMessage(Guid.NewGuid(), "idiota asshole mierda");

                TestAssert.Equal(1, chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2)
                    .AccumulatedChatInfractionPoints);
            }
        }

        public static void CreateAllowedAccountSession_AlreadyBannedAccount_DeniesNewSession()
        {
            using (ChatDuplexTestEnvironment chatDuplexEnvironment = new ChatDuplexTestEnvironment())
            {
                chatDuplexEnvironment.InfractionRepository.GetAccountInfractionState(2)
                    .IsChatAccountPermanentlyBanned = true;

                string accountSessionToken = chatDuplexEnvironment.AccountAccessPolicy.CreateAllowedAccountSession(2);

                TestAssert.Equal<string>(null, accountSessionToken);
            }
        }
    }
}
