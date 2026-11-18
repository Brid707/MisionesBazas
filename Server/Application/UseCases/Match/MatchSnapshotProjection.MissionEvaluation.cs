using Application.Models;
using Gameplay;

namespace Application.UseCases
{
    internal static partial class MatchSnapshotProjection
    {
        private static MissionEvaluationSnapshot CreateMissionEvaluation(MatchState matchState)
        {
            return new MissionEvaluationSnapshot
            {
                MissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                LastEvaluatedTrickNumber = matchState.LastEvaluatedTrickNumber,
                MissionAttemptStatus = matchState.LastMissionEvaluation == null
                    ? MissionAttemptEvaluationStatus.NotEvaluated
                    : MissionEvaluationMapper.MapAttemptStatus(matchState.MissionAttempt.Status),
                MissionFailureReason = matchState.LastMissionEvaluation == null
                    ? MissionEvaluationFailureReason.None
                    : MissionEvaluationMapper.MapFailureReason(matchState.LastMissionEvaluation.FailureCode)
            };
        }
    }
}
