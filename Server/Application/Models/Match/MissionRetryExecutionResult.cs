using System;

namespace Application.Models
{
    /// <summary>Reports a scheduled change for publication after releasing match locks.</summary>
    public sealed record MissionRetryExecutionResult
    {
        public string LobbyCode { get; init; }

        public bool HasStateChanged { get; init; }

        public bool HasRestartedMission { get; init; }

        public long CommittedMatchStateVersion { get; init; }
    }
}
