using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Encapsulates the authoritative state of a single mission attempt within a match.
    /// </summary>
    public sealed record MissionAttemptState
    {
        public int MissionAttemptId { get; init; }

        public int MissionNumber { get; init; }

        public int AttemptNumber { get; init; }

        public MissionAttemptPhase Phase { get; init; }

        public MissionAttemptStatus Status { get; init; }

        public byte CaptainSeat { get; init; }

        public int PlayerCount { get; init; }

        public byte CurrentObjectiveDraftSeat { get; init; }

        public int ConsecutiveObjectiveDraftPassCount { get; init; }

        public bool HasUsedDistressSignal { get; init; }

        public MissionRoleConfiguration RoleConfig { get; init; }

        public IReadOnlyList<MissionObjective> Objectives { get; init; }

        public IReadOnlyList<PlayerRadioCommunicationState> RadioCommunicationsBySeat { get; init; }
    }
}
