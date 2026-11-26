using System;

namespace Application.Models
{
    /// <summary>Exposes public readiness and a request identifier only for the requesting participant.</summary>
    public sealed class MissionRetrySnapshot
    {
        public int MissionAttemptId { get; set; }

        public int AttemptNumber { get; set; }

        public bool IsRetryAvailable { get; set; }

        public int[] ReadyParticipantUserIds { get; set; }

        public Guid? AvailableMissionRetrySubmissionId { get; set; }

        public MissionRetryStatus Status { get; set; }

        public Guid MissionRetryScheduleId { get; set; }

        public int RemainingDelayMilliseconds { get; set; }

        public int[] MissingParticipantUserIds { get; set; }
    }
}
