using System;

namespace Application.Models
{
    /// <summary>Keeps radio requests and accepted effects inside the application boundary.</summary>
    public sealed record RadioCommunicationRequest
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public Guid RadioCommunicationSubmissionId { get; init; }

        public long ExpectedMatchStateVersion { get; init; }

        public int CardId { get; init; }

        public RadioPublicMarker SelectedMarker { get; init; }
    }
}
