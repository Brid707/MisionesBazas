using System;

namespace Application.Models
{
    /// <summary>Retains a stable decision and whether its first execution changed the match.</summary>
    public sealed record ObjectiveDraftDecision
    {
        public Guid ObjectiveDraftSubmissionId { get; init; }

        public bool IsAccepted { get; init; }

        public ObjectiveDraftRejectionReason RejectionReason { get; init; }

        public long CommittedMatchStateVersion { get; init; }

        public bool HasCompletedSelectionFreeCycle { get; init; }

        public bool HasStateChanged { get; init; }
    }
}
