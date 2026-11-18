using System.Collections.Generic;
using System.Linq;
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

        public MissionEvaluationFailureCode FailureCode { get; init; }

        private static readonly IReadOnlyDictionary<string, MissionEvaluationFailureCode> s_failureCodes =
            new Dictionary<string, MissionEvaluationFailureCode>
            {
                { MissionFailureReasons.ObjectiveCapturedByWrongSeat,
                    MissionEvaluationFailureCode.ObjectiveCapturedByWrongSeat },
                { MissionFailureReasons.MultipleOrderedTokensInSameTrick,
                    MissionEvaluationFailureCode.MultipleOrderedTokensInSameTrick },
                { MissionFailureReasons.MultipleArrowTokensInSameTrick,
                    MissionEvaluationFailureCode.MultipleArrowTokensInSameTrick },
                { MissionFailureReasons.OmegaSimultaneousCompletion,
                    MissionEvaluationFailureCode.OmegaSimultaneousCompletion },
                { MissionFailureReasons.PrecedingOrderTokenNotCompleted,
                    MissionEvaluationFailureCode.PrecedingOrderTokenNotCompleted },
                { MissionFailureReasons.PrecedingArrowTokenNotCompleted,
                    MissionEvaluationFailureCode.PrecedingArrowTokenNotCompleted },
                { MissionFailureReasons.OmegaObjectiveNotCompletedLast,
                    MissionEvaluationFailureCode.OmegaObjectiveNotCompletedLast },
                { MissionFailureReasons.ObjectivesIncompleteAtMissionEnd,
                    MissionEvaluationFailureCode.ObjectivesIncompleteAtMissionEnd },
                { MissionFailureReasons.Mission48OmegaNotInLastTrick,
                    MissionEvaluationFailureCode.Mission48OmegaNotInLastTrick },
                { MissionFailureReasons.Mission05AllPlayersWonTrick,
                    MissionEvaluationFailureCode.AllParticipantsWonAtLeastOneTrick },
                { MissionFailureReasons.Mission48PendingNonOmegaBeforeLastTrick,
                    MissionEvaluationFailureCode.Mission48PendingNonOmegaBeforeLastTrick }
            };

        public static MissionEvaluationResult Success(IReadOnlyList<MissionObjective> objectives, string message = null)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.Succeeded,
                UpdatedObjectives = objectives.ToArray(),
                Message = message
            };
        }

        public static MissionEvaluationResult InProgress(IReadOnlyList<MissionObjective> objectives, string message = null)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.InProgress,
                UpdatedObjectives = objectives.ToArray(),
                Message = message
            };
        }

        public static MissionEvaluationResult Fail(IReadOnlyList<MissionObjective> objectives, string reason)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.Failed,
                UpdatedObjectives = objectives.ToArray(),
                FailureCode = GetFailureCode(reason),
                Message = reason
            };
        }
        private static MissionEvaluationFailureCode GetFailureCode(string failureReason)
        {
            MissionEvaluationFailureCode failureCode = MissionEvaluationFailureCode.SpecialMissionConstraint;
            if (failureReason != null && s_failureCodes.TryGetValue(failureReason, out var knownFailureCode))
            {
                failureCode = knownFailureCode;
            }
            return failureCode;
        }
    }
}
