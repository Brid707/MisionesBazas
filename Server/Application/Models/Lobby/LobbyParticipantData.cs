namespace Application.Models
{
    /// <summary>
    /// Represents participant information within an active lobby room in the application core.
    /// </summary>
    public sealed class LobbyParticipantData
    {
        public int IdUser { get; set; }

        public string Username { get; set; }

        public bool IsHost { get; set; }

        public bool IsReady { get; set; }
    }
}
