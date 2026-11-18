using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Represents the immutable catalog definition and rules configuration of a mission.
    /// </summary>
    public sealed record MissionDefinition
    {
        public int MissionNumber { get; init; }

        public int ObjectiveCardCount { get; init; }

        public IReadOnlyList<ObjectiveTokenType> Tokens { get; init; }

        public CommunicationRuleType CommunicationRule { get; init; }

        public SpecialMissionRuleType SpecialRule { get; init; }

        public string Description { get; init; }
    }
}
