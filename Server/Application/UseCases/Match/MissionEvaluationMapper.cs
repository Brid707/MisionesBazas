using System;
using System.Collections.Generic;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Enums;

namespace Application.UseCases
{
    /// <summary>Maps internal evaluation values to the explicit public snapshot contracts.</summary>
    internal static class MissionEvaluationMapper
    {
        private static readonly IReadOnlyDictionary<ObjectiveStatus, MissionObjectiveStatus> s_objectiveStatuses =
            new Dictionary<ObjectiveStatus, MissionObjectiveStatus>
            {
                { ObjectiveStatus.Pending, MissionObjectiveStatus.Pending },
                { ObjectiveStatus.Completed, MissionObjectiveStatus.Completed },
                { ObjectiveStatus.Failed, MissionObjectiveStatus.Failed }
            };

        private static readonly IReadOnlyDictionary<MissionAttemptStatus, MissionAttemptEvaluationStatus>
            s_attemptStatuses = new Dictionary<MissionAttemptStatus, MissionAttemptEvaluationStatus>
            {
                { MissionAttemptStatus.InProgress, MissionAttemptEvaluationStatus.InProgress },
                { MissionAttemptStatus.Succeeded, MissionAttemptEvaluationStatus.Succeeded },
                { MissionAttemptStatus.Failed, MissionAttemptEvaluationStatus.Failed }
            };

        private static readonly IReadOnlyDictionary<MissionEvaluationFailureCode, MissionEvaluationFailureReason>
            s_failureReasons = new Dictionary<MissionEvaluationFailureCode, MissionEvaluationFailureReason>
            {
                { MissionEvaluationFailureCode.None,
                    MissionEvaluationFailureReason.None },
                { MissionEvaluationFailureCode.ObjectiveCapturedByWrongSeat,
                    MissionEvaluationFailureReason.ObjectiveCapturedByWrongSeat },
                { MissionEvaluationFailureCode.MultipleOrderedTokensInSameTrick,
                    MissionEvaluationFailureReason.MultipleOrderedTokensInSameTrick },
                { MissionEvaluationFailureCode.MultipleArrowTokensInSameTrick,
                    MissionEvaluationFailureReason.MultipleArrowTokensInSameTrick },
                { MissionEvaluationFailureCode.OmegaSimultaneousCompletion,
                    MissionEvaluationFailureReason.OmegaSimultaneousCompletion },
                { MissionEvaluationFailureCode.PrecedingOrderTokenNotCompleted,
                    MissionEvaluationFailureReason.PrecedingOrderTokenNotCompleted },
                { MissionEvaluationFailureCode.PrecedingArrowTokenNotCompleted,
                    MissionEvaluationFailureReason.PrecedingArrowTokenNotCompleted },
                { MissionEvaluationFailureCode.OmegaObjectiveNotCompletedLast,
                    MissionEvaluationFailureReason.OmegaObjectiveNotCompletedLast },
                { MissionEvaluationFailureCode.ObjectivesIncompleteAtMissionEnd,
                    MissionEvaluationFailureReason.ObjectivesIncompleteAtMissionEnd },
                { MissionEvaluationFailureCode.Mission48OmegaNotInLastTrick,
                    MissionEvaluationFailureReason.Mission48OmegaNotInLastTrick },
                { MissionEvaluationFailureCode.Mission48PendingNonOmegaBeforeLastTrick,
                    MissionEvaluationFailureReason.Mission48PendingNonOmegaBeforeLastTrick },
                { MissionEvaluationFailureCode.AllParticipantsWonAtLeastOneTrick,
                    MissionEvaluationFailureReason.AllParticipantsWonAtLeastOneTrick },
                { MissionEvaluationFailureCode.SpecialMissionConstraint,
                    MissionEvaluationFailureReason.SpecialMissionConstraint }
            };

        internal static MissionObjectiveStatus MapObjectiveStatus(ObjectiveStatus objectiveStatus)
        {
            if (!s_objectiveStatuses.TryGetValue(objectiveStatus, out MissionObjectiveStatus publicStatus))
            {
                throw new ArgumentOutOfRangeException(nameof(objectiveStatus));
            }
            return publicStatus;
        }

        internal static MissionAttemptEvaluationStatus MapAttemptStatus(MissionAttemptStatus attemptStatus)
        {
            if (!s_attemptStatuses.TryGetValue(attemptStatus, out MissionAttemptEvaluationStatus publicStatus))
            {
                throw new ArgumentOutOfRangeException(nameof(attemptStatus));
            }
            return publicStatus;
        }

        internal static MissionEvaluationFailureReason MapFailureReason(MissionEvaluationFailureCode failureCode)
        {
            if (!s_failureReasons.TryGetValue(failureCode, out MissionEvaluationFailureReason publicReason))
            {
                throw new ArgumentOutOfRangeException(nameof(failureCode));
            }
            return publicReason;
        }
    }
}
