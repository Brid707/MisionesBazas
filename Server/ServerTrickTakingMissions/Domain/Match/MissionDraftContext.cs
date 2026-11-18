using System.Collections.Generic;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Encapsulates the contextual parameters required to validate an objective draft selection.
    /// </summary>
    public sealed record MissionDraftContext
    {
        public MissionDefinition Definition { get; init; }

        public IReadOnlyList<MissionObjective> CurrentObjectives { get; init; }

        public int ObjectiveIndex { get; init; }

        public byte AttemptingSeat { get; init; }

        public byte CurrentObjectiveDraftSeat { get; init; }

        public byte CaptainSeat { get; init; }

        public MissionRoleConfiguration RoleConfig { get; init; }

        public int PlayerCount { get; init; }
    }
}
