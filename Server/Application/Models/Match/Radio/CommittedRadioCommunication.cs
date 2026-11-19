using System;

namespace Application.Models
{
    /// <summary>Keeps radio requests and accepted effects inside the application boundary.</summary>
    public sealed record CommittedRadioCommunication
    {
        public int ParticipantUserId { get; init; }

        public RadioCommunicationRequest Request { get; init; }

        public RadioPublicMarker ResolvedPublicMarker { get; init; }

        public long CommittedMatchStateVersion { get; init; }
    }
}
