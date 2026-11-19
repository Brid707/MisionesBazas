using System;

namespace Application.Models
{
    /// <summary>Keeps radio requests and accepted effects inside the application boundary.</summary>
    public sealed record RadioCommunicationCommit
    {
        public Guid RadioCommunicationSubmissionId { get; init; }

        public long CommittedMatchStateVersion { get; init; }

        public bool HasStateChanged { get; init; }

        public RadioCommunicationRejection Rejection { get; init; }
    }
}
