using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Evaluates completed tricks against active mission objectives and special mission victory conditions.
    /// </summary>
    public static class MissionEvaluationRules
    {
        /// <summary>
        /// Evaluates a completed trick, verifying captured objectives and evaluating active special mission rules.
        /// </summary>
        /// <param name="context">The contextual state of the completed trick, hands, and mission rules.</param>
        /// <returns>A <see cref="MissionEvaluationResult"/> detailing attempt progress, success, or the failure reason.</returns>
        /// <exception cref="ArgumentNullException">Thrown when required context fields are null.</exception>
        public static MissionEvaluationResult EvaluateCompletedTrick(MissionEvaluationContext context)
        {
            if (context is null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            if (context.WinningPlay is null)
            {
                throw new ArgumentNullException(nameof(context.WinningPlay));
            }

            if (context.CompletedTrickPlays is null)
            {
                throw new ArgumentNullException(nameof(context.CompletedTrickPlays));
            }

            var updatedObjectives = new List<MissionObjective>(context.CurrentObjectives ?? Array.Empty<MissionObjective>());

            MissionEvaluationResult objectiveResult = EvaluateObjectivesInTrick(context, updatedObjectives);
            if (objectiveResult != null)
            {
                return objectiveResult;
            }

            MissionEvaluationResult specialRuleResult = EvaluateSpecialRule(context, updatedObjectives);
            if (specialRuleResult != null)
            {
                return specialRuleResult;
            }

            return DetermineOverallStatus(context, updatedObjectives);
        }

        private static MissionEvaluationResult EvaluateObjectivesInTrick(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            var capturedObjectives = new List<MissionObjective>();

            for (int index = 0; index < updatedObjectives.Count; index++)
            {
                MissionObjective objective = updatedObjectives[index];
                if (context.CompletedTrickPlays.Any(play => play.Card.IdCard == objective.CardId))
                {
                    if (context.WinningPlay.Seat != objective.AssignedSeat)
                    {
                        return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.ObjectiveCapturedByWrongSeat);
                    }

                    capturedObjectives.Add(objective);
                }
            }

            MissionEvaluationResult conflictResult = ValidateSimultaneousCaptureConflicts(capturedObjectives, updatedObjectives);
            if (conflictResult != null)
            {
                return conflictResult;
            }

            MissionEvaluationResult precedenceResult = ValidateOrderPrecedence(context, capturedObjectives, updatedObjectives);
            if (precedenceResult != null)
            {
                return precedenceResult;
            }

            ApplyCompletedObjectives(context.CurrentTrickNumber, capturedObjectives, updatedObjectives);
            return null;
        }

        private static MissionEvaluationResult ValidateSimultaneousCaptureConflicts(
            List<MissionObjective> capturedObjectives,
            List<MissionObjective> updatedObjectives)
        {
            if (capturedObjectives.Count <= 1)
            {
                return null;
            }

            int numericOrderCount = capturedObjectives.Count(o => o.Token >= ObjectiveTokenType.OrderOne && o.Token <= ObjectiveTokenType.OrderFive);
            if (numericOrderCount > 1)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.MultipleOrderedTokensInSameTrick);
            }

            int arrowCount = capturedObjectives.Count(o => o.Token >= ObjectiveTokenType.ArrowOne && o.Token <= ObjectiveTokenType.ArrowFour);
            if (arrowCount > 1)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.MultipleArrowTokensInSameTrick);
            }

            if (capturedObjectives.Any(o => o.Token == ObjectiveTokenType.Omega))
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.OmegaSimultaneousCompletion);
            }

            return null;
        }

        private static MissionEvaluationResult ValidateOrderPrecedence(
            MissionEvaluationContext context,
            List<MissionObjective> capturedObjectives,
            List<MissionObjective> updatedObjectives)
        {
            foreach (MissionObjective captured in capturedObjectives)
            {
                if (captured.Token >= ObjectiveTokenType.OrderTwo && captured.Token <= ObjectiveTokenType.OrderFive)
                {
                    ObjectiveTokenType precedingToken = captured.Token - 1;
                    bool isPredecessorComplete = updatedObjectives.Any(o => o.Token == precedingToken && o.Status == ObjectiveStatus.Completed);
                    if (!isPredecessorComplete)
                    {
                        return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.PrecedingOrderTokenNotCompleted);
                    }
                }
                else if (captured.Token >= ObjectiveTokenType.ArrowTwo && captured.Token <= ObjectiveTokenType.ArrowFour)
                {
                    ObjectiveTokenType precedingArrow = captured.Token - 1;
                    bool isPredecessorComplete = updatedObjectives.Any(o => o.Token == precedingArrow && o.Status == ObjectiveStatus.Completed);
                    if (!isPredecessorComplete)
                    {
                        return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.PrecedingArrowTokenNotCompleted);
                    }
                }
                else if (captured.Token == ObjectiveTokenType.Omega)
                {
                    MissionEvaluationResult omegaResult = ValidateOmegaPrecedence(context, captured, updatedObjectives);
                    if (omegaResult != null)
                    {
                        return omegaResult;
                    }
                }
            }

            return null;
        }

        private static MissionEvaluationResult ValidateOmegaPrecedence(
            MissionEvaluationContext context,
            MissionObjective captured,
            List<MissionObjective> updatedObjectives)
        {
            bool hasOtherPending = updatedObjectives.Any(o => o.CardId != captured.CardId && o.Status != ObjectiveStatus.Completed);
            if (hasOtherPending)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.OmegaObjectiveNotCompletedLast);
            }

            if (context.Definition.SpecialRule == SpecialMissionRuleType.M48_OmegaObjectiveCompletedInLastTrick &&
                context.CurrentTrickNumber != context.TotalTricksInMission)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission48OmegaNotInLastTrick);
            }

            return null;
        }

        private static void ApplyCompletedObjectives(
            int currentTrickNumber,
            List<MissionObjective> capturedObjectives,
            List<MissionObjective> updatedObjectives)
        {
            foreach (MissionObjective captured in capturedObjectives)
            {
                int objIndex = updatedObjectives.FindIndex(o => o.CardId == captured.CardId);
                updatedObjectives[objIndex] = updatedObjectives[objIndex] with
                {
                    Status = ObjectiveStatus.Completed,
                    CompletedAtTrickNumber = currentTrickNumber
                };
            }
        }

        private static MissionEvaluationResult EvaluateSpecialRule(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult countResult = EvaluateTrickCountConstraints(context, updatedObjectives);
            if (countResult != null)
            {
                return countResult;
            }

            MissionEvaluationResult cardNumResult = EvaluateCardNumberConstraints(context, updatedObjectives);
            if (cardNumResult != null)
            {
                return cardNumResult;
            }

            MissionEvaluationResult specialCardResult = EvaluateSpecialCardConstraints(context, updatedObjectives);
            if (specialCardResult != null)
            {
                return specialCardResult;
            }

            MissionEvaluationResult assignedPlayerResult = EvaluateAssignedPlayerConstraints(context, updatedObjectives);
            if (assignedPlayerResult != null)
            {
                return assignedPlayerResult;
            }

            return EvaluateDistributionConstraints(context, updatedObjectives);
        }

        private static MissionEvaluationResult EvaluateTrickCountConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M05_OnePlayerWinsNoTricks)
            {
                bool everyPlayerWonAtLeastOne = Enumerable.Range(0, context.PlayerCount)
                    .All(seat => GetTricksWon(context.TotalTricksWonBySeat, seat) > 0);

                if (everyPlayerWonAtLeastOne)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission05AllPlayersWonTrick);
                }
            }
            else if (context.Definition.SpecialRule == SpecialMissionRuleType.M29_MaxTrickDifferenceTwo)
            {
                int trickSpread = CalculateTrickDifferenceSpread(context.TotalTricksWonBySeat, context.PlayerCount);
                if (trickSpread > MissionFailureReasons.MaxTrickDifferenceThreshold)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission29TrickDifferenceExceeded);
                }
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateCardNumberConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;

            switch (context.Definition.SpecialRule)
            {
                case SpecialMissionRuleType.M09_WinTrickWithNumberOne:
                    if (isLastTrick && context.TotalNormalOnesWonCount == 0)
                    {
                        return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission09NoTrickWonWithOne);
                    }
                    break;

                case SpecialMissionRuleType.M16_NoTrickWonWithNumberNine:
                case SpecialMissionRuleType.M17_NoTrickWonWithNumberNine:
                    bool isWonWithNine = context.WinningPlay.Card.Suit != CardSuit.Special &&
                                         context.WinningPlay.Card.Number == MissionFailureReasons.ForbiddenTrickWinnerCardNumber;
                    if (isWonWithNine)
                    {
                        return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission16TrickWonWithNine);
                    }
                    break;

                case SpecialMissionRuleType.M26_TwoTricksWonWithNumberOne:
                    if (isLastTrick && context.TotalNormalOnesWonCount < MissionFailureReasons.Mission26RequiredOnesCount)
                    {
                        return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission26LessTwoTricksWonWithOne);
                    }
                    break;
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateSpecialCardConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            bool hasLostSpecialCard = context.CompletedTrickPlays.Any(play => play.Card.Suit == CardSuit.Special && play != context.WinningPlay);
            if (hasLostSpecialCard)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission13SpecialCardLostTrick);
            }

            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;

            if (context.Definition.SpecialRule == SpecialMissionRuleType.M13_WinTrickWithEverySpecialCard)
            {
                if (isLastTrick && CountSpecialCardsWon(context.SpecialCardsWonSoFar) < MissionFailureReasons.TotalSpecialCardsCount)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission13NotAllSpecialCardsWon);
                }
            }
            else if (context.Definition.SpecialRule == SpecialMissionRuleType.M44_SpecialCardsWinTricksInAscendingOrder)
            {
                if (context.WinningPlay.Card.Suit == CardSuit.Special && !IsSpecialCardAscending(context))
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission44SpecialOrderViolated);
                }

                if (isLastTrick && (context.SpecialCardsWonSoFar?.Count ?? 0) < MissionFailureReasons.TotalSpecialCardsCount)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission44NotAllSpecialCardsWon);
                }
            }

            return null;
        }

        private static bool IsSpecialCardAscending(MissionEvaluationContext context)
        {
            SpecialCardSymbol currentSymbol = context.WinningPlay.Card.SpecialSymbol;
            IReadOnlyList<Card> previousSpecialWon = context.SpecialCardsWonSoFar ?? Array.Empty<Card>();

            if (previousSpecialWon.Count > 0)
            {
                Card lastSpecial = previousSpecialWon[previousSpecialWon.Count - 1];
                return currentSymbol > lastSpecial.SpecialSymbol;
            }

            return true;
        }

        private static MissionEvaluationResult EvaluateAssignedPlayerConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            switch (context.Definition.SpecialRule)
            {
                case SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard:
                    return EvaluateMission33(context, updatedObjectives);

                case SpecialMissionRuleType.M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo:
                    return EvaluateMission34(context, updatedObjectives);

                case SpecialMissionRuleType.M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard:
                    return EvaluateMission41(context, updatedObjectives);

                default:
                    return null;
            }
        }

        private static MissionEvaluationResult EvaluateMission33(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (!context.RoleConfig.SingleTrickWinnerSeat.HasValue)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission33RoleUnassigned);
            }

            byte targetSeat = context.RoleConfig.SingleTrickWinnerSeat.Value;
            if (context.WinningPlay.Seat == targetSeat)
            {
                if (context.WinningPlay.Card.Suit == CardSuit.Special)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission33WonWithSpecialCard);
                }

                if (GetTricksWon(context.TotalTricksWonBySeat, targetSeat) > 1)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission33WonMultipleTricks);
                }
            }

            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;
            if (isLastTrick && GetTricksWon(context.TotalTricksWonBySeat, targetSeat) != 1)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission33DidNotWinExactlyOneTrick);
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateMission34(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (context.CurrentTrickNumber == 1 && context.WinningPlay.Seat != context.CaptainSeat)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission34CaptainDidNotWinFirstTrick);
            }

            if (context.CurrentTrickNumber == context.TotalTricksInMission && context.WinningPlay.Seat != context.CaptainSeat)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission34CaptainDidNotWinLastTrick);
            }

            int spread = CalculateTrickDifferenceSpread(context.TotalTricksWonBySeat, context.PlayerCount);
            if (spread > MissionFailureReasons.MaxTrickDifferenceThreshold)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission29TrickDifferenceExceeded);
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateMission41(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (!context.RoleConfig.FirstAndLastTrickWinnerSeat.HasValue)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission41RoleUnassigned);
            }

            byte targetSeat = context.RoleConfig.FirstAndLastTrickWinnerSeat.Value;
            bool isFirstTrick = context.CurrentTrickNumber == 1;
            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;

            if (isFirstTrick)
            {
                if (context.WinningPlay.Seat != targetSeat)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission41FirstTrickNotWonBySelected);
                }

                if (context.WinningPlay.Card.Suit == CardSuit.Special)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission41FirstTrickWonWithSpecial);
                }
            }
            else if (!isLastTrick)
            {
                if (context.WinningPlay.Seat == targetSeat)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission41IntermediateTrickWonBySelected);
                }
            }
            else
            {
                if (context.WinningPlay.Seat != targetSeat)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission41LastTrickNotWonBySelected);
                }

                if (context.WinningPlay.Card.Suit == CardSuit.Special)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission41LastTrickWonWithSpecial);
                }
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateDistributionConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts)
            {
                return EvaluateMission46(context, updatedObjectives);
            }

            if (context.Definition.SpecialRule == SpecialMissionRuleType.M50_SplitTrickWinsDistribution)
            {
                return EvaluateMission50(context, updatedObjectives);
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateMission46(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (!context.HeartNineOwnerSeat.HasValue)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission46HeartNineUnidentified);
            }

            byte targetSeat = (byte)((context.HeartNineOwnerSeat.Value + 1) % context.PlayerCount);
            bool hasHeartCard = context.CompletedTrickPlays.Any(play => play.Card.Suit == CardSuit.Heart);

            if (hasHeartCard && context.WinningPlay.Seat != targetSeat)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission46HeartCapturedByWrongSeat);
            }

            return null;
        }

        private static MissionEvaluationResult EvaluateMission50(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            if (!context.RoleConfig.FirstFourTricksWinnerSeat.HasValue ||
                !context.RoleConfig.LastTrickWinnerSeat.HasValue)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50RolesUnassigned);
            }

            byte roleA = context.RoleConfig.FirstFourTricksWinnerSeat.Value;
            byte roleB = context.RoleConfig.LastTrickWinnerSeat.Value;

            if (context.CurrentTrickNumber <= MissionFailureReasons.Mission50InitialTricksCount)
            {
                if (context.WinningPlay.Seat != roleA)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50FirstFourTricksWrongWinner);
                }
            }
            else if (context.WinningPlay.Seat == roleA)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50FirstFourWinnerWonExtra);
            }

            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;
            if (!isLastTrick && context.WinningPlay.Seat == roleB)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50LastTrickWinnerWonEarly);
            }

            if (isLastTrick)
            {
                if (context.WinningPlay.Seat != roleB)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50LastTrickWrongWinner);
                }

                bool allRemainingWon = Enumerable.Range(0, context.PlayerCount)
                    .Where(seat => seat != roleA && seat != roleB)
                    .All(seat => GetTricksWon(context.TotalTricksWonBySeat, seat) > 0);

                if (!allRemainingWon)
                {
                    return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50RemainingPlayerWonNoTrick);
                }
            }

            return null;
        }

        private static MissionEvaluationResult DetermineOverallStatus(
            MissionEvaluationContext context,
            IReadOnlyList<MissionObjective> updatedObjectives)
        {
            bool allObjectivesCompleted = updatedObjectives.All(o => o.Status == ObjectiveStatus.Completed);
            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;

            if (!allObjectivesCompleted && isLastTrick)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.ObjectivesIncompleteAtMissionEnd);
            }

            bool hasPendingSpecialRuleConstraints = HasOngoingSpecialRuleConstraints(context.Definition.SpecialRule);
            if (allObjectivesCompleted && (!hasPendingSpecialRuleConstraints || isLastTrick))
            {
                return MissionEvaluationResult.Success(updatedObjectives, MissionFailureReasons.MissionSuccessMessage);
            }

            return MissionEvaluationResult.InProgress(updatedObjectives);
        }

        private static bool HasOngoingSpecialRuleConstraints(SpecialMissionRuleType specialRule)
        {
            switch (specialRule)
            {
                case SpecialMissionRuleType.None:
                case SpecialMissionRuleType.M11_CaptainSilencesOnePlayer:
                case SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer:
                case SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer:
                    return false;

                default:
                    return true;
            }
        }

        private static int CalculateTrickDifferenceSpread(IReadOnlyDictionary<int, int> tricksBySeat, int playerCount)
        {
            int maxWins = 0;
            int minWins = int.MaxValue;

            for (int seat = 0; seat < playerCount; seat++)
            {
                int wins = GetTricksWon(tricksBySeat, seat);
                if (wins > maxWins) maxWins = wins;
                if (wins < minWins) minWins = wins;
            }

            return maxWins - minWins;
        }

        private static int CountSpecialCardsWon(IReadOnlyList<Card> specialCards)
        {
            return (specialCards ?? Array.Empty<Card>())
                .Where(c => c.Suit == CardSuit.Special)
                .Select(c => c.SpecialSymbol)
                .Distinct()
                .Count();
        }

        private static int GetTricksWon(IReadOnlyDictionary<int, int> tricksBySeat, int seat)
        {
            if (tricksBySeat != null && tricksBySeat.TryGetValue(seat, out int count))
            {
                return count;
            }

            return 0;
        }
    }
}
