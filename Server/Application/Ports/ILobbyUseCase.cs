using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Defines the primary input port for creating, joining, and managing multiplayer game lobbies.
    /// </summary>
    public interface ILobbyUseCase
    {
        /// <summary>
        /// Creates a new multiplayer lobby room hosted by the specified user.
        /// </summary>
        /// <param name="hostUserId">The unique identifier of the user hosting the room.</param>
        /// <param name="targetMissionCount">The number of missions configured for the session.</param>
        /// <param name="playerLimit">The maximum number of participants allowed (2 to 4).</param>
        /// <returns>A <see cref="LobbyActionOutcome"/> containing the generated lobby state or error details.</returns>
        LobbyActionOutcome CreateLobby(int hostUserId, byte targetMissionCount, byte playerLimit);

        /// <summary>
        /// Adds a user to an existing active lobby room using its invitation code.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the lobby.</param>
        /// <param name="userId">The unique identifier of the user joining the room.</param>
        /// <returns>A <see cref="LobbyActionOutcome"/> with the updated room state and participant data.</returns>
        LobbyActionOutcome JoinLobby(string lobbyCode, int userId);

        /// <summary>
        /// Removes a participant from an active lobby room and disbands the room if the host leaves.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the lobby.</param>
        /// <param name="userId">The unique identifier of the user leaving the room.</param>
        /// <returns>A <see cref="LobbyActionOutcome"/> indicating if the player left or room disbanded.</returns>
        LobbyActionOutcome LeaveLobby(string lobbyCode, int userId);

        /// <summary>
        /// Ejects a target participant from the lobby room when requested by the room host.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the lobby.</param>
        /// <param name="hostUserId">The unique identifier of the host issuing the kick.</param>
        /// <param name="targetUserId">The unique identifier of the player to remove.</param>
        /// <returns>A <see cref="LobbyActionOutcome"/> indicating whether the target player was removed.</returns>
        LobbyActionOutcome KickPlayer(string lobbyCode, int hostUserId, int targetUserId);

        /// <summary>
        /// Updates the readiness status of a participant inside the specified lobby room.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the lobby.</param>
        /// <param name="userId">The unique identifier of the participant.</param>
        /// <param name="isReady">The new readiness state.</param>
        /// <returns>A <see cref="LobbyActionOutcome"/> indicating whether the readiness state was updated.</returns>
        LobbyActionOutcome UpdatePlayerReadiness(string lobbyCode, int userId, bool isReady);

        /// <summary>
        /// Retrieves the display username of a participant currently inside the specified lobby.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the lobby.</param>
        /// <param name="userId">The unique identifier of the participant.</param>
        /// <returns>The username if the participant is in the room; otherwise, null.</returns>
        string GetParticipantUsername(string lobbyCode, int userId);

        /// <summary>
        /// Determines whether the specified lobby meets all domain conditions and transitions it to an active game.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the lobby.</param>
        /// <param name="hostUserId">The unique identifier of the host requesting the launch.</param>
        /// <returns>True if the lobby can transition and was marked in-game; otherwise, false.</returns>
        bool CanTransitionLobbyToGame(string lobbyCode, int hostUserId);
    }
}
