using System.Collections.Generic;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Captures the finalized state of a completed trick for turn progression and mission evaluation.
    /// </summary>
    public sealed record CompletedTrickSummary
    {
        public int TrickNumber { get; init; }

        public int TotalTricksInMission { get; init; }

        public byte StartingSeat { get; init; }

        public byte WinningSeat { get; init; }

        public IReadOnlyList<TrickCardPlay> CardsPlayed { get; init; }
    }
}
