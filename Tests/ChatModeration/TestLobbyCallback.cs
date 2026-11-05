using System.Collections.Concurrent;
using System.ServiceModel;
using System.Threading;

using Model.GameServices;

namespace ChatModeration.Tests
{
    [CallbackBehavior(UseSynchronizationContext = false)]
    internal sealed class TestLobbyCallback : ILobbyServiceCallback
    {
        public ConcurrentQueue<LobbyMessage> ReceivedMessages { get; } = new ConcurrentQueue<LobbyMessage>();

        public AutoResetEvent MessageReceived { get; } = new AutoResetEvent(false);

        public AutoResetEvent ParticipantLeft { get; } = new AutoResetEvent(false);

        public AutoResetEvent AccountBanned { get; } = new AutoResetEvent(false);

        public void OnPlayerJoinedLobby(LobbyPlayer player) { }

        public void OnPlayerLeftLobby(int userId, string reason) { ParticipantLeft.Set(); }

        public void OnPlayerReadyStatusChanged(int userId, bool isReady) { }

        public void OnReceiveLobbyChatMessage(LobbyMessage message)
        {
            ReceivedMessages.Enqueue(message);
            MessageReceived.Set();
        }

        public void OnChatAccountBanApplied(ChatAccountBanNotice notice) { AccountBanned.Set(); }

        public void OnGameStarting(int gameId) { }

        public void OnLobbyDisbanded(string reason) { ParticipantLeft.Set(); }
    }
}
