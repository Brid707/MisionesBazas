using System;

namespace Application.Models
{
    /// <summary>Identifies one reserved retry generation; it contains no cards.</summary>
    public sealed record MissionRetryWork
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public Guid MissionRetryScheduleId { get; init; }

        public long ConnectionVersion { get; init; }
    }
}
