using System;

namespace Application.Models
{
    /// <summary>Publishes transition progress; never includes a deck or another participant hand.</summary>
    public sealed class MissionTransitionSnapshot
    {
        public int MissionAttemptId { get; set; }

        public int AttemptNumber { get; set; }

        public MissionTransitionStatus Status { get; set; }

        public MissionTransitionKind Kind { get; set; }

        public Guid MissionTransitionScheduleId { get; set; }

        public int RemainingDelayMilliseconds { get; set; }

        public int[] MissingParticipantUserIds { get; set; }

        public int DestinationMissionNumber { get; set; }

        public int TargetMissionCount { get; set; }
    }
}
