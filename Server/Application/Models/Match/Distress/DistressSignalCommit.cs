namespace Application.Models
{
    /// <summary>
    /// Represents the committed outcome of a distress signal request inside the application boundary.
    /// </summary>
    public sealed record DistressSignalCommit
    {
        public long CommittedMatchStateVersion { get; init; }

        public bool HasStateChanged { get; init; }

        public bool IsExecuted { get; init; }

        public DistressSignalRejection Rejection { get; init; }
    }
}
