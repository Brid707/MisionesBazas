using System.Threading.Tasks;
using System;

using Model.GameServices;

namespace Model.Services
{
    /// <summary>
    /// Abstraction of the client-side lobby channel, used to request room operations and receive server push events.
    /// </summary>
    public interface ILobbyClient : IDisposable
    {
        event Action<LobbyPlayer> PlayerJoined;

        event Action<int, string> PlayerLeft;

        event Action<int, bool> PlayerReadyStatusChanged;

        event Action<LobbyMessage> ChatMessageReceived;

        event EventHandler<ChatAccountBanAppliedEventArgs> ChatAccountBanApplied;

        event Action<int> GameStarted;

        event Action<string> LobbyDisbanded;

        event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        Task<LobbyResult> CreateLobbyAsync(int hostUserId, byte targetMissionCount, byte playerLimit);

        Task<LobbyResult> JoinLobbyByCodeAsync(string lobbyCode, int userId);

        Task LeaveLobbyAsync(string lobbyCode, int userId);

        Task SetPlayerReadyStatusAsync(string lobbyCode, int userId, bool isReady);

        Task<LobbyChatMessageSubmissionOutcome> SendLobbyChatMessageAsync(
            LobbyChatMessageSubmission chatMessageSubmission);
    }
}
