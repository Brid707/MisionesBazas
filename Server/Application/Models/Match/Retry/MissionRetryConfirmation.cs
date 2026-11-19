using System;
using System.Collections.Generic;

namespace Application.Models
{
    /// <summary>Retains the confirmation without repeating a prepared deal.</summary>
    public sealed record MissionRetryConfirmation
    {
        public Guid MissionRetrySubmissionId { get; init; }

        public bool IsAccepted { get; init; }

        public bool HasStateChanged { get; init; }

        public bool HasRestartedMission { get; init; }

        public long CommittedMatchStateVersion { get; init; }

        public int CurrentMissionAttemptId { get; init; }

        public MissionRetryRejectionReason RejectionReason { get; init; }
    }
}
