using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    public static partial class MissionEvaluationRules
    {
        private static void ValidateEvaluationContext(MissionEvaluationContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException(nameof(context));
            }
            if (context.Definition == null || context.WinningPlay == null ||
                context.CompletedTrickPlays == null || context.CurrentObjectives == null)
            {
                throw new ArgumentException(nameof(context));
            }
            bool isTrickNumberValid = context.CurrentTrickNumber >= 1 &&
                context.CurrentTrickNumber <= context.TotalTricksInMission;
            bool isWinningPlayIncluded = context.CompletedTrickPlays.Contains(context.WinningPlay);
            if (!isTrickNumberValid || !isWinningPlayIncluded)
            {
                throw new ArgumentException(nameof(context));
            }
        }

        private static MissionEvaluationResult EvaluateObjectivesInTrick(
            MissionEvaluationContext context, List<MissionObjective> updatedObjectives)
        {
            MissionObjective[] capturedObjectives = updatedObjectives.Where(objective =>
                objective.Status == ObjectiveStatus.Pending && context.CompletedTrickPlays.Any(play =>
                    play.Card.IdCard == objective.CardId)).ToArray();
            MissionObjective wrongCapture = capturedObjectives.FirstOrDefault(objective =>
                objective.AssignedSeat != context.WinningPlay.Seat);
            MissionEvaluationResult missionEvaluation = null;
            if (wrongCapture != null)
            {
                missionEvaluation = FailObjective(updatedObjectives, wrongCapture.CardId,
                    MissionFailureReasons.ObjectiveCapturedByWrongSeat);
            }
            if (missionEvaluation == null)
            {
                missionEvaluation = ValidateSimultaneousCaptureConflicts(capturedObjectives, updatedObjectives);
            }
            if (missionEvaluation == null)
            {
                missionEvaluation = ValidateOrderPrecedence(context, capturedObjectives, updatedObjectives);
            }
            if (missionEvaluation == null)
            {
                ApplyCompletedObjectives(context.CurrentTrickNumber, capturedObjectives, updatedObjectives);
            }
            return missionEvaluation;
        }

        private static MissionEvaluationResult ValidateSimultaneousCaptureConflicts(
            IReadOnlyList<MissionObjective> capturedObjectives, List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult missionEvaluation = null;
            if (capturedObjectives.Count > 1)
            {
                MissionObjective numericObjective = capturedObjectives.FirstOrDefault(IsNumericObjective);
                MissionObjective[] arrowObjectives = capturedObjectives.Where(IsArrowObjective).ToArray();
                MissionObjective omegaObjective = capturedObjectives.FirstOrDefault(objective =>
                    objective.Token == ObjectiveTokenType.Omega);
                if (numericObjective != null)
                {
                    missionEvaluation = FailObjective(updatedObjectives, numericObjective.CardId,
                        MissionFailureReasons.MultipleOrderedTokensInSameTrick);
                }
                if (missionEvaluation == null && arrowObjectives.Length > 1)
                {
                    missionEvaluation = FailObjective(updatedObjectives, arrowObjectives[1].CardId,
                        MissionFailureReasons.MultipleArrowTokensInSameTrick);
                }
                if (missionEvaluation == null && omegaObjective != null)
                {
                    missionEvaluation = FailObjective(updatedObjectives, omegaObjective.CardId,
                        MissionFailureReasons.OmegaSimultaneousCompletion);
                }
            }
            return missionEvaluation;
        }

        private static MissionEvaluationResult ValidateOrderPrecedence(MissionEvaluationContext context,
            IReadOnlyList<MissionObjective> capturedObjectives, List<MissionObjective> updatedObjectives)
        {
            int completedObjectiveCount = updatedObjectives.Count(objective =>
                objective.Status == ObjectiveStatus.Completed);
            MissionEvaluationResult missionEvaluation = ValidateReservedNumericPositions(
                capturedObjectives, updatedObjectives, completedObjectiveCount);
            foreach (MissionObjective capturedObjective in capturedObjectives)
            {
                if (missionEvaluation == null)
                {
                    missionEvaluation = ValidateNumericTokenPosition(
                        capturedObjective, completedObjectiveCount, updatedObjectives);
                    if (missionEvaluation == null)
                    {
                        missionEvaluation = ValidateRelativeToken(context, capturedObjective, updatedObjectives);
                    }
                }
            }
            return missionEvaluation;
        }

        private static MissionEvaluationResult ValidateReservedNumericPositions(
            IReadOnlyList<MissionObjective> capturedObjectives, List<MissionObjective> updatedObjectives,
            int completedObjectiveCount)
        {
            int finalCompletionPosition = completedObjectiveCount + capturedObjectives.Count;
            MissionObjective displacedObjective = updatedObjectives.FirstOrDefault(objective =>
                IsNumericObjective(objective) && objective.Status == ObjectiveStatus.Pending &&
                (int)objective.Token > completedObjectiveCount && (int)objective.Token <= finalCompletionPosition &&
                !capturedObjectives.Contains(objective));
            MissionEvaluationResult missionEvaluation = null;
            if (displacedObjective != null)
            {
                missionEvaluation = FailObjective(updatedObjectives, displacedObjective.CardId,
                    MissionFailureReasons.PrecedingOrderTokenNotCompleted);
            }
            return missionEvaluation;
        }

        private static MissionEvaluationResult ValidateNumericTokenPosition(MissionObjective capturedObjective,
            int completedObjectiveCount, List<MissionObjective> updatedObjectives)
        {
            int completionPosition = completedObjectiveCount + 1;
            bool isNumericPositionInvalid = IsNumericObjective(capturedObjective) &&
                (int)capturedObjective.Token != completionPosition;
            MissionObjective reservedObjective = updatedObjectives.FirstOrDefault(objective =>
                IsNumericObjective(objective) && (int)objective.Token == completionPosition &&
                objective.Status != ObjectiveStatus.Completed);
            bool isReservedPositionTaken = !IsNumericObjective(capturedObjective) && reservedObjective != null;
            MissionEvaluationResult missionEvaluation = null;
            if (isNumericPositionInvalid || isReservedPositionTaken)
            {
                int failedCardId = isReservedPositionTaken ? reservedObjective.CardId : capturedObjective.CardId;
                missionEvaluation = FailObjective(updatedObjectives, failedCardId,
                    MissionFailureReasons.PrecedingOrderTokenNotCompleted);
            }
            return missionEvaluation;
        }

        private static MissionEvaluationResult ValidateRelativeToken(MissionEvaluationContext context,
            MissionObjective capturedObjective, List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult missionEvaluation = null;
            if (IsArrowObjective(capturedObjective))
            {
                bool hasPendingPredecessor = updatedObjectives.Any(objective => IsArrowObjective(objective) &&
                    objective.Token < capturedObjective.Token && objective.Status != ObjectiveStatus.Completed);
                if (hasPendingPredecessor)
                {
                    missionEvaluation = FailObjective(updatedObjectives, capturedObjective.CardId,
                        MissionFailureReasons.PrecedingArrowTokenNotCompleted);
                }
            }
            else if (capturedObjective.Token == ObjectiveTokenType.Omega)
            {
                missionEvaluation = ValidateOmegaPrecedence(context, capturedObjective, updatedObjectives);
            }
            return missionEvaluation;
        }

        private static bool IsNumericObjective(MissionObjective objective)
        {
            return objective.Token >= ObjectiveTokenType.OrderOne && objective.Token <= ObjectiveTokenType.OrderFive;
        }

        private static bool IsArrowObjective(MissionObjective objective)
        {
            return objective.Token >= ObjectiveTokenType.ArrowOne && objective.Token <= ObjectiveTokenType.ArrowFour;
        }

        private static MissionEvaluationResult ValidateOmegaPrecedence(MissionEvaluationContext context,
            MissionObjective capturedObjective, List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult missionEvaluation = null;
            bool hasOtherPendingObjective = updatedObjectives.Any(objective =>
                objective.CardId != capturedObjective.CardId && objective.Status != ObjectiveStatus.Completed);
            if (hasOtherPendingObjective)
            {
                missionEvaluation = FailObjective(updatedObjectives, capturedObjective.CardId,
                    MissionFailureReasons.OmegaObjectiveNotCompletedLast);
            }
            else if (context.Definition.SpecialRule == SpecialMissionRuleType.M48_OmegaObjectiveCompletedInLastTrick &&
                context.CurrentTrickNumber != context.TotalTricksInMission)
            {
                missionEvaluation = FailObjective(updatedObjectives, capturedObjective.CardId,
                    MissionFailureReasons.Mission48OmegaNotInLastTrick);
            }
            return missionEvaluation;
        }

        private static MissionEvaluationResult FailObjective(List<MissionObjective> updatedObjectives,
            int failedCardId, string failureReason)
        {
            int objectiveIndex = updatedObjectives.FindIndex(objective => objective.CardId == failedCardId);
            if (objectiveIndex >= 0)
            {
                updatedObjectives[objectiveIndex] = updatedObjectives[objectiveIndex] with
                {
                    Status = ObjectiveStatus.Failed
                };
            }
            return MissionEvaluationResult.Fail(updatedObjectives, failureReason);
        }

        private static void ApplyCompletedObjectives(int completedTrickNumber,
            IReadOnlyList<MissionObjective> capturedObjectives, List<MissionObjective> updatedObjectives)
        {
            foreach (MissionObjective capturedObjective in capturedObjectives)
            {
                int objectiveIndex = updatedObjectives.FindIndex(objective =>
                    objective.CardId == capturedObjective.CardId);
                updatedObjectives[objectiveIndex] = capturedObjective with
                {
                    Status = ObjectiveStatus.Completed,
                    CompletedAtTrickNumber = completedTrickNumber
                };
            }
        }
    }
}
