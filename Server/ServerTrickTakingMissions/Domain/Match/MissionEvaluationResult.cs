using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Outcome of evaluating a completed trick against mission objectives and special rules.
    /// </summary>
    public sealed record MissionEvaluationResult
    {
        public MissionAttemptStatus OverallStatus { get; init; }

        public IReadOnlyList<MissionObjective> UpdatedObjectives { get; init; }

        public string Message { get; init; }

        public static MissionEvaluationResult Success(IReadOnlyList<MissionObjective> objectives, string message = null)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.Succeeded,
                UpdatedObjectives = objectives,
                Message = message
            };
        }

        public static MissionEvaluationResult InProgress(IReadOnlyList<MissionObjective> objectives, string message = null)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.InProgress,
                UpdatedObjectives = objectives,
                Message = message
            };
        }

        public static MissionEvaluationResult Fail(IReadOnlyList<MissionObjective> objectives, string reason)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.Failed,
                UpdatedObjectives = objectives,
                Message = reason
            };
        }
    }
}
