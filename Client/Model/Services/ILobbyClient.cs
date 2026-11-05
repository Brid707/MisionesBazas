using System;
using System.Threading.Tasks;

using Model.GameServices;

namespace Model.Services
{
    /// <summary>
    /// Abstraction of the client-side lobby channel, used to request room operations and receive server push events.
    /// </summary>
    public interface ILobbyClient : IDisposable
    {
        event EventHandler<LobbyStateChangedEventArgs> LobbyStateChanged;

        event Action<LobbyPlayer> PlayerJoined;

        event Action<int, string> PlayerLeft;

        event Action<int, bool> PlayerReadyStatusChanged;

        event Action<LobbyMessage> ChatMessageReceived;

        event EventHandler<ChatAccountBanAppliedEventArgs> ChatAccountBanApplied;

        event Action<int> GameStarted;

        event Action<string> LobbyDisbanded;

        event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        Task<LobbyResult> CreateLobbyAsync(int hostUserId, LobbySettings lobbySettings);

        /// <summary>Requests an update without replacing the room or its participants.</summary>
        /// <param name="lobbyCode">The existing room invitation code.</param>
        /// <param name="requesterUserId">The current participant requesting the change.</param>
        /// <param name="lobbySettings">The selected missions, capacity and privacy.</param>
        /// <returns>The confirmed state or rejection; null when delivery could not be confirmed.</returns>
        Task<LobbyResult> UpdateLobbySettingsAsync(string lobbyCode, int requesterUserId, LobbySettings lobbySettings);

        Task<LobbyResult> JoinLobbyByCodeAsync(string lobbyCode, int userId);

        /// <summary>Requests that the current host remove another lobby participant.</summary>
        Task KickPlayerAsync(string lobbyCode, int hostUserId, int targetUserId);

        /// <summary>Restores room access for a new host-authorized invitation; does not send the invitation.</summary>
        Task<LobbyResult> AuthorizeKickedPlayerReentryAsync(string lobbyCode, int hostUserId, int targetUserId);

        Task LeaveLobbyAsync(string lobbyCode, int userId);

        Task SetPlayerReadyStatusAsync(string lobbyCode, int userId, bool isReady);

        Task<LobbyChatMessageSubmissionOutcome> SendLobbyChatMessageAsync(
            LobbyChatMessageSubmission chatMessageSubmission);
    }
}
