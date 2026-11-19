using System.ServiceModel;

using Services.DataContracts;

namespace Services.Contracts
{
    /// <summary>
    /// Service contract defining operations for lobby management, player coordination, and match launching.
    /// </summary>
    [ServiceContract(CallbackContract = typeof(ILobbyCallback))]
    public interface ILobbyService : IMatchService
    {
        /// <summary>Changes waiting-room configuration and returns the server-confirmed room or rejection.</summary>
        /// <param name="lobbyCode">The existing room invitation code.</param>
        /// <param name="requesterUserId">The participant whose channel and session will be verified.</param>
        /// <param name="settings">The requested mission, capacity and privacy values.</param>
        /// <returns>The confirmed room snapshot or a specific rejection.</returns>
        [OperationContract]
        LobbyResult UpdateLobbySettings(string lobbyCode, int requesterUserId, LobbySettings settings);

        /// <summary>
        /// Creates a new game lobby hosted by the specified user with custom configuration settings.
        /// </summary>
        /// <param name="hostUserId">The unique identifier of the user creating the lobby.</param>
        /// <param name="settings">The initial room configuration settings (limit and missions).</param>
        /// <returns>A <see cref="LobbyResult"/> encapsulating the outcome and generated lobby data.</returns>
        [OperationContract]
        LobbyResult CreateLobby(int hostUserId, LobbySettings settings);

        /// <summary>
        /// Attempts to connect a user to an active lobby using its unique invitation code.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric room invitation code.</param>
        /// <param name="userId">The unique identifier of the user attempting to join.</param>
        /// <returns>A <see cref="LobbyResult"/> encapsulating the room state or failure details.</returns>
        [OperationContract]
        LobbyResult JoinLobbyByCode(string lobbyCode, int userId);

        /// <summary>
        /// Disconnects a participant from the active lobby room.
        /// </summary>
        /// <param name="lobbyCode">The room invitation code.</param>
        /// <param name="userId">The unique identifier of the user leaving the room.</param>
        [OperationContract(IsOneWay = true)]
        void LeaveLobby(string lobbyCode, int userId);

        /// <summary>
        /// Ejects a participant from the lobby room by host command.
        /// </summary>
        /// <param name="lobbyCode">The room invitation code.</param>
        /// <param name="hostUserId">The unique identifier of the room host issuing the command.</param>
        /// <param name="targetUserId">The unique identifier of the user to be ejected.</param>
        [OperationContract(IsOneWay = true)]
        void KickPlayerByUserId(string lobbyCode, int hostUserId, int targetUserId);

        /// <summary>Allows an invitation workflow to restore access after a host-issued removal.</summary>
        /// <param name="lobbyCode">The room whose reentry restriction will be removed.</param>
        /// <param name="hostUserId">The current host authorizing a new invitation.</param>
        /// <param name="targetUserId">The player being invited back to this room.</param>
        /// <returns>Authorization confirmation or a specific rejection; does not deliver an invitation.</returns>
        [OperationContract]
        LobbyResult AuthorizeKickedPlayerReentry(string lobbyCode, int hostUserId, int targetUserId);

        /// <summary>
        /// Updates the readiness status of a player inside the lobby room.
        /// </summary>
        /// <param name="lobbyCode">The room invitation code.</param>
        /// <param name="userId">The unique identifier of the participant updating status.</param>
        /// <param name="isReady">Indicates whether the participant is ready to start.</param>
        [OperationContract(IsOneWay = true)]
        void SetPlayerReadyStatus(string lobbyCode, int userId, bool isReady);

        /// <summary>Processes an authenticated chat submission and returns its committed disposition.</summary>
        /// <param name="chatMessageSubmission">The identified lobby message to evaluate.</param>
        /// <returns>The acceptance, moderation notice or account ban for this submission.</returns>
        [OperationContract]
        LobbyChatMessageSubmissionOutcome SendLobbyChatMessage(LobbyChatMessageSubmission chatMessageSubmission);

        /// <summary>
        /// Instructs the server to initialize the game match from the current lobby once participants are ready.
        /// </summary>
        /// <param name="lobbyCode">The room invitation code.</param>
        /// <param name="hostUserId">The unique identifier of the host initiating the match.</param>
        [OperationContract]
        void StartGameFromLobby(string lobbyCode, int hostUserId);
    }
}
