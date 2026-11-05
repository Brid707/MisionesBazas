namespace Application.Models
{
    /// <summary>Groups the requested lobby rules independently of transport serialization.</summary>
    public sealed record LobbyConfiguration
    {
        public byte TargetMissionCount { get; init; }
        public byte PlayerLimit { get; init; }
        public bool IsPrivate { get; init; }
    }
}
