using Domain;

namespace Application.Models
{
    /// <summary>Stages a complete trick and evaluation before any live hand is modified.</summary>
    internal sealed record CompletedTrickResolution
    {
        public MatchCardPlay[] CompletedTrickCardPlays { get; init; }

        public int WinningParticipantSeat { get; init; }

        public int CompletedTrickNumber { get; init; }

        public MissionEvaluationResult MissionEvaluation { get; init; }

        public MissionTrickStatistics TrickStatistics { get; init; }

        public MissionAttemptState UpdatedMissionAttempt { get; init; }
    }
}
