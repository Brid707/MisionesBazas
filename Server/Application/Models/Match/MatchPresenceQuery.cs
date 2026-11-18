using System;

namespace Application.Models
{
    /// <summary>Identifies the participants and connection generation to verify.</summary>
    public sealed record MatchPresenceQuery
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public int[] ParticipantUserIds { get; init; }

        public long ExpectedConnectionVersion { get; init; }
    }
}
