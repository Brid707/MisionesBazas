namespace Services.Services
{
    /// <summary>Stores connection liveness metadata; no game cards or account credentials are retained.</summary>
    internal sealed class LobbyCallbackPresenceLease
    {
        public long LastSeenTimestamp { get; set; }

        public bool IsUnavailable { get; set; }
    }
}
