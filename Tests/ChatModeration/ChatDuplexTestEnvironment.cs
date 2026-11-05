using System.IO;
using System.Net.Sockets;
using System.Net;
using System.ServiceModel.Channels;
using System.ServiceModel;
using System;

using Application.Ports;
using Application;
using Host.DependencyInjection;
using Infrastructure.Moderation;
using Remote = Model.GameServices;
using Services.Security;
using Services.Services;

namespace ChatModeration.Tests
{
    /// <summary>Exercises real WCF transport and the generated consumer proxy with substituted storage.</summary>
    internal sealed class ChatDuplexTestEnvironment : IDisposable
    {
        private readonly ServiceHost _lobbyServiceHost;
        public ChatDuplexTestEnvironment()
        {
            InfractionRepository = new TestChatInfractionRepository();
            AccountAccessPolicy = new AccountAccessPolicy(new AuthenticatedAccountSessionRegistry(), InfractionRepository);
            HostSessionToken = AccountAccessPolicy.CreateAllowedAccountSession(1);
            ParticipantSessionToken = AccountAccessPolicy.CreateAllowedAccountSession(2);
            LobbyUseCase = new LobbyUseCase(new TestUserRepository());
            ILobbyChatMessageUseCase chatUseCase = new LobbyChatMessageUseCase(
                new ProhibitedChatExpressionCatalog(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ModerationCatalogs")),
                InfractionRepository);
            Uri serviceAddress = ReserveTestAddress();
            _lobbyServiceHost = new ServiceHost(typeof(LobbyService), serviceAddress);
            _lobbyServiceHost.AddServiceEndpoint(typeof(Services.Contracts.ILobbyService),
                new NetTcpBinding(SecurityMode.None), "");
            FuncInstanceProvider<LobbyService> instanceProvider = new FuncInstanceProvider<LobbyService>(
                () => new LobbyService(LobbyUseCase, chatUseCase, AccountAccessPolicy));
            _lobbyServiceHost.Description.Behaviors.Add(new DependencyInjectionServiceBehavior(instanceProvider));
            _lobbyServiceHost.Open();
            HostCallback = new TestLobbyCallback();
            ParticipantCallback = new TestLobbyCallback();
            HostClient = CreateClient(HostCallback, serviceAddress);
            ParticipantClient = CreateClient(ParticipantCallback, serviceAddress);
            using (OperationContextScope accountRequestScope = AttachToken(HostClient, HostSessionToken))
            {
                LobbyCode = HostClient.CreateLobby(1, new Remote.LobbySettings
                {
                    PlayerLimit = 4, TargetMissionCount = 5
                }).Lobby.LobbyCode;
            }

            using (OperationContextScope accountRequestScope = AttachToken(ParticipantClient, ParticipantSessionToken))
            {
                ParticipantClient.JoinLobbyByCode(LobbyCode, 2);
            }
        }

        public TestChatInfractionRepository InfractionRepository { get; }
        public TestLobbyCallback HostCallback { get; }
        public TestLobbyCallback ParticipantCallback { get; }
        public Remote.LobbyServiceClient HostClient { get; }
        public Remote.LobbyServiceClient ParticipantClient { get; }
        public string LobbyCode { get; }
        public string HostSessionToken { get; }
        public string ParticipantSessionToken { get; }
        public ILobbyUseCase LobbyUseCase { get; }
        public IAccountAccessPolicy AccountAccessPolicy { get; }

        public Remote.LobbyChatMessageSubmissionOutcome SendParticipantMessage(Guid submissionId, string messageText)
        {
            Remote.LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome;
            using (OperationContextScope accountRequestScope = AttachToken(ParticipantClient, ParticipantSessionToken))
            {
                chatMessageSubmissionOutcome = ParticipantClient.SendLobbyChatMessage(new Remote.LobbyChatMessageSubmission
                {
                    ChatMessageSubmissionId = submissionId, LobbyCode = LobbyCode, OriginalChatMessageText = messageText
                });
            }

            return chatMessageSubmissionOutcome;
        }

        public void Dispose()
        {
            ParticipantClient.Abort();
            HostClient.Abort();
            _lobbyServiceHost.Abort();
        }

        public static OperationContextScope AttachToken(Remote.LobbyServiceClient lobbyServiceClient, string accountSessionToken)
        {
            OperationContextScope accountRequestScope = new OperationContextScope(lobbyServiceClient.InnerChannel);
            OperationContext.Current.OutgoingMessageHeaders.Add(MessageHeader.CreateHeader(
                "AccountSessionToken", "urn:misiones-bazas:account-session", accountSessionToken));
            return accountRequestScope;
        }

        private static Remote.LobbyServiceClient CreateClient(TestLobbyCallback callback, Uri lobbyServiceAddress)
        {
            return new Remote.LobbyServiceClient(new InstanceContext(callback),
                new NetTcpBinding(SecurityMode.None), new EndpointAddress(lobbyServiceAddress));
        }

        private static Uri ReserveTestAddress()
        {
            TcpListener listener = new TcpListener(IPAddress.Loopback, 0);
            listener.Start();
            int lobbyServicePort = ((IPEndPoint)listener.LocalEndpoint).Port;
            listener.Stop();
            return new Uri("net.tcp://localhost:" + lobbyServicePort + "/ChatTest");
        }
    }
}
