using System;

namespace Application.Models
{
    /// <summary>Binds an accepted submission to its participant and immutable decision.</summary>
    public sealed record ProcessedObjectiveDraft
    {
        public int ParticipantUserId { get; init; }

        public ObjectiveDraftSubmission ObjectiveDraftSubmission { get; init; }

        public ObjectiveDraftDecision ObjectiveDraftDecision { get; init; }
    }
}
