using System;
using System.Collections.Generic;

namespace Application.Models
{
    /// <summary>Identifies a participant confirmation for one failed mission attempt.</summary>
    public sealed record MissionRetryRequest
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public Guid MissionRetrySubmissionId { get; init; }

        public long ExpectedMatchStateVersion { get; init; }
    }
}
