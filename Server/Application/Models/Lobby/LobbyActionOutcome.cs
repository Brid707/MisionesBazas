namespace Application.Models
{
    /// <summary>
    /// Represents the outcome of a lobby operation executed within the application core.
    /// </summary>
    public sealed class LobbyActionOutcome
    {
        public bool IsSuccess { get; set; }

        public string Message { get; set; }

        public int ErrorCode { get; set; }

        public bool IsRoomDisbanded { get; set; }

        public LobbyRoomData Lobby { get; set; }

        public LobbyParticipantData AffectedPlayer { get; set; }
    }
}
