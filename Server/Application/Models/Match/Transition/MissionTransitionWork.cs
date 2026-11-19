using System;

namespace Application.Models
{
    /// <summary>Identifies one reserved transition generation; it contains no cards.</summary>
    public sealed record MissionTransitionWork
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public Guid MissionTransitionScheduleId { get; init; }

        public MissionTransitionAction TransitionAction { get; init; }

        public int DestinationMissionNumber { get; init; }

        public long ConnectionVersion { get; init; }
    }
}
