using System.ServiceModel;

using Services.DataContracts;

namespace Services.Contracts
{
    /// <summary>
    /// Duplex callback contract defining push notifications dispatched from the server to lobby participants.
    /// </summary>
    public interface ILobbyCallback
    {
        /// <summary>Publishes a versioned authoritative room snapshot
        /// after rules, role or participants change.</summary>
        [OperationContract(IsOneWay = true)]
        void OnLobbyStateChanged(Lobby lobby);

        /// <summary>
        /// Notifies participants that a new player has joined the lobby room.
        /// </summary>
        /// <param name="player">The participant details of the user who joined.</param>
        [OperationContract(IsOneWay = true)]
        void OnPlayerJoinedLobby(LobbyPlayer player);

        /// <summary>
        /// Notifies participants that a player has left or was kicked from the lobby room.
        /// </summary>
        /// <param name="userId">The unique identifier of the user who left.</param>
        /// <param name="reason">The descriptive reason for leaving or being removed.</param>
        [OperationContract(IsOneWay = true)]
        void OnPlayerLeftLobby(int userId, string reason);

        /// <summary>
        /// Notifies participants that a player updated their readiness status.
        /// </summary>
        /// <param name="userId">The unique identifier of the user whose status changed.</param>
        /// <param name="isReady">Indicates whether the player is marked as ready.</param>
        [OperationContract(IsOneWay = true)]
        void OnPlayerReadyStatusChanged(int userId, bool isReady);

        /// <summary>
        /// Notifies participants of a new textual chat message dispatched in the room.
        /// </summary>
        /// <param name="message">The chat message object containing sender details and text.</param>
        [OperationContract(IsOneWay = true)]
        void OnReceiveLobbyChatMessage(LobbyMessage message);

        /// <summary>Notifies only the sanctioned account that server access has been revoked.</summary>
        [OperationContract(IsOneWay = true)]
        void OnChatAccountBanApplied(ChatAccountBanNotice chatAccountBanNotice);

        /// <summary>
        /// Notifies participants that the host launched the game and provides the new match identifier.
        /// </summary>
        /// <param name="gameId">The unique identifier of the newly initialized game match.</param>
        [OperationContract(IsOneWay = true)]
        void OnGameStarting(int gameId);

        /// <summary>
        /// Notifies participants that the lobby room has been closed or disbanded.
        /// </summary>
        /// <param name="reason">The reason describing why the room was closed.</param>
        [OperationContract(IsOneWay = true)]
        void OnLobbyDisbanded(string reason);
    }
}
