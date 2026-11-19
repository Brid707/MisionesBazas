using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>Groups both distinct trick-distribution roles for one atomic domain decision.</summary>
    public sealed record MissionTrickDistributionContext
    {
        public MissionAttemptState Attempt { get; init; }
        public MissionDefinition Definition { get; init; }
        public int ActingParticipantSeat { get; init; }
        public int FirstFourTricksWinnerSeat { get; init; }
        public int LastTrickWinnerSeat { get; init; }
    }
}
