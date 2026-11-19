using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>Groups the captain, target and voluntary answers used for special preparation.</summary>
    public sealed record MissionRoleAssignmentContext
    {
        public MissionAttemptState Attempt { get; init; }
        public MissionDefinition Definition { get; init; }
        public int ActingParticipantSeat { get; init; }
        public int SelectedParticipantSeat { get; init; }
        public IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> ResponsesBySeat { get; init; }
    }
}
