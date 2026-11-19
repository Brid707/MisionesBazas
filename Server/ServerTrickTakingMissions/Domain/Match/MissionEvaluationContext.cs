using System.Collections.Generic;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Contextual game state passed to evaluate completed tricks against mission rules and objectives.
    /// </summary>
    public sealed record MissionEvaluationContext
    {
        public MissionDefinition Definition { get; init; }

        public int TotalTricksInMission { get; init; }

        public int CurrentTrickNumber { get; init; }

        public TrickCardPlay WinningPlay { get; init; }

        public IReadOnlyList<TrickCardPlay> CompletedTrickPlays { get; init; }

        public IReadOnlyList<MissionObjective> CurrentObjectives { get; init; }

        public IReadOnlyDictionary<int, int> TotalTricksWonBySeat { get; init; }

        public IReadOnlyList<Card> SpecialCardsWonSoFar { get; init; }

        public int TricksWonWithNormalOneCount { get; init; }

        public MissionRoleConfiguration RoleConfig { get; init; }

        public byte? HeartNineOwnerSeat { get; init; }

        public byte CaptainSeat { get; init; }

        public int PlayerCount { get; init; }
    }
}
