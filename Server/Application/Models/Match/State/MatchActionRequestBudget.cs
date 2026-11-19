using System;

namespace Application.Models
{
    /// <summary>Tracks a bounded monotonic request window without retaining incoming payloads.</summary>
    public sealed record MatchActionRequestBudget
    {
        public long WindowStartedTimestamp { get; init; }

        public int RequestsInWindow { get; init; }
    }
}
