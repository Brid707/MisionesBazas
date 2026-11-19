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
    public static partial class MissionEvaluationRules
    {
        /// <summary>
        /// Evaluates a completed trick, verifying captured objectives and evaluating active special mission rules.
        /// </summary>
        /// <param name="context">The contextual state of the completed trick, hands, and mission rules.</param>
        /// <returns>A <see cref="MissionEvaluationResult"/> detailing attempt progress, success, or the failure
        /// reason.</returns>
        /// <exception cref="ArgumentNullException">Thrown when required context fields are null.</exception>
        public static MissionEvaluationResult EvaluateCompletedTrick(MissionEvaluationContext context)
        {
            ValidateEvaluationContext(context);
            var updatedObjectives = new List<MissionObjective>(context.CurrentObjectives);
            MissionEvaluationResult missionEvaluation = EvaluateObjectivesInTrick(context, updatedObjectives);
            if (missionEvaluation == null)
            {
                missionEvaluation = EvaluateSpecialRule(context, updatedObjectives);
            }
            if (missionEvaluation == null)
            {
                missionEvaluation = DetermineOverallStatus(context, updatedObjectives);
            }
            return missionEvaluation;
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
            MissionEvaluationResult result = null;
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M05_OnePlayerWinsNoTricks)
            {
                bool hasEveryParticipantWon = Enumerable.Range(0, context.PlayerCount)
                    .All(seat => GetTricksWon(context.TotalTricksWonBySeat, seat) > 0);
                if (hasEveryParticipantWon)
                {
                    result = MissionEvaluationResult.Fail(updatedObjectives,
                        MissionFailureReasons.Mission05AllPlayersWonTrick);
                }
            }
            else if (context.Definition.SpecialRule == SpecialMissionRuleType.M29_MaxTrickDifferenceTwo ||
                context.Definition.SpecialRule ==
                    SpecialMissionRuleType.M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo)
            {
                int wonTrickDifference = CalculateTrickDifferenceSpread(
                    context.TotalTricksWonBySeat, context.PlayerCount);
                if (wonTrickDifference > MissionFailureReasons.MaxTrickDifferenceThreshold)
                {
                    result = MissionEvaluationResult.Fail(updatedObjectives,
                        MissionFailureReasons.Mission29TrickDifferenceExceeded);
                }
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateCardNumberConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            switch (context.Definition.SpecialRule)
            {
                case SpecialMissionRuleType.M09_WinTrickWithNumberOne:
                    result = EvaluateWinningNormalOne(context, updatedObjectives);
                    break;
                case SpecialMissionRuleType.M16_NoTrickWonWithNumberNine:
                case SpecialMissionRuleType.M17_NoTrickWonWithNumberNine:
                    if (context.WinningPlay.Card.Suit != CardSuit.Special &&
                        context.WinningPlay.Card.Number == MissionFailureReasons.ForbiddenTrickWinnerCardNumber)
                    {
                        result = MissionEvaluationResult.Fail(updatedObjectives,
                            MissionFailureReasons.Mission16TrickWonWithNine);
                    }
                    break;
                case SpecialMissionRuleType.M26_TwoTricksWonWithNumberOne:
                    result = EvaluateTwoWinningNormalOnes(context, updatedObjectives);
                    break;
                default:
                    break;
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateTwoWinningNormalOnes(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            int missingWinningNormalOnes = MissionFailureReasons.Mission26RequiredOnesCount -
                context.TricksWonWithNormalOneCount;
            MissionEvaluationResult result = null;
            if (missingWinningNormalOnes <= 0)
            {
                result = MissionEvaluationResult.Success(updatedObjectives,
                    MissionFailureReasons.MissionSuccessMessage);
            }
            else if (missingWinningNormalOnes > context.TotalTricksInMission - context.CurrentTrickNumber)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission26LessTwoTricksWonWithOne);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateWinningNormalOne(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            if (context.TricksWonWithNormalOneCount > 0)
            {
                result = MissionEvaluationResult.Success(updatedObjectives,
                    MissionFailureReasons.MissionSuccessMessage);
            }
            else if (context.CurrentTrickNumber == context.TotalTricksInMission)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission09NoTrickWonWithOne);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateSpecialCardProgress(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            int remainingSpecialToWin = MissionFailureReasons.TotalSpecialCardsCount - CountSpecialCardsWon(context);
            int remainingTricks = context.TotalTricksInMission - context.CurrentTrickNumber;
            MissionEvaluationResult result = null;
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M13_WinTrickWithEverySpecialCard &&
                remainingSpecialToWin == 0)
            {
                result = MissionEvaluationResult.Success(updatedObjectives,
                    MissionFailureReasons.MissionSuccessMessage);
            }
            else if (context.Definition.SpecialRule ==
                SpecialMissionRuleType.M44_SpecialCardsWinTricksInAscendingOrder &&
                context.WinningPlay.Card.Suit == CardSuit.Special && !IsSpecialCardAscending(context))
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission44SpecialOrderViolated);
            }
            else if (remainingSpecialToWin > remainingTricks)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission13NotAllSpecialCardsWon);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateSpecialCardConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            bool isSpecialCardMission = context.Definition.SpecialRule ==
                SpecialMissionRuleType.M13_WinTrickWithEverySpecialCard || context.Definition.SpecialRule ==
                SpecialMissionRuleType.M44_SpecialCardsWinTricksInAscendingOrder;
            if (isSpecialCardMission)
            {
                bool hasLostSpecialCard = context.CompletedTrickPlays.Any(play =>
                    play.Card.Suit == CardSuit.Special && play != context.WinningPlay);
                result = hasLostSpecialCard
                    ? MissionEvaluationResult.Fail(updatedObjectives,
                        MissionFailureReasons.Mission13SpecialCardLostTrick)
                    : EvaluateSpecialCardProgress(context, updatedObjectives);
            }
            return result;
        }

        private static bool IsSpecialCardAscending(MissionEvaluationContext context)
        {
            SpecialCardSymbol currentSymbol = context.WinningPlay.Card.SpecialSymbol;
            int priorSpecialCount = (context.SpecialCardsWonSoFar ?? Array.Empty<Card>())
                .Count(card => card.Suit == CardSuit.Special && card.IdCard != context.WinningPlay.Card.IdCard);
            SpecialCardSymbol expectedSymbol = (SpecialCardSymbol)(priorSpecialCount + 1);

            return currentSymbol == expectedSymbol;
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
            MissionEvaluationResult result = MissionEvaluationResult.Fail(updatedObjectives,
                MissionFailureReasons.Mission33RoleUnassigned);
            byte? selectedParticipantSeat = context.RoleConfig?.SingleTrickWinnerSeat;
            if (selectedParticipantSeat.HasValue && selectedParticipantSeat.Value < context.PlayerCount)
            {
                result = EvaluateSingleTrickWinner(context, updatedObjectives);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateSingleTrickWinner(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            byte selectedParticipantSeat = context.RoleConfig.SingleTrickWinnerSeat.Value;
            int selectedParticipantWonTrickCount = GetTricksWon(context.TotalTricksWonBySeat, selectedParticipantSeat);
            MissionEvaluationResult result = null;
            if (context.WinningPlay.Seat == selectedParticipantSeat &&
                context.WinningPlay.Card.Suit == CardSuit.Special)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission33WonWithSpecialCard);
            }
            else if (selectedParticipantWonTrickCount > 1)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission33WonMultipleTricks);
            }
            else if (context.CurrentTrickNumber == context.TotalTricksInMission &&
                selectedParticipantWonTrickCount != 1)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission33DidNotWinExactlyOneTrick);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateMission34(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            if (context.CurrentTrickNumber == 1 && context.WinningPlay.Seat != context.CaptainSeat)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission34CaptainDidNotWinFirstTrick);
            }
            else if (context.CurrentTrickNumber == context.TotalTricksInMission &&
                context.WinningPlay.Seat != context.CaptainSeat)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission34CaptainDidNotWinLastTrick);
            }
            return result;
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

            if (isLastTrick && context.WinningPlay.Seat != roleB)
            {
                return MissionEvaluationResult.Fail(updatedObjectives, MissionFailureReasons.Mission50LastTrickWrongWinner);
            }

            bool isPenultimateOrLastTrick = context.CurrentTrickNumber >= context.TotalTricksInMission - 1;
            if (isPenultimateOrLastTrick)
            {
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
            List<MissionObjective> updatedObjectives)
        {
            bool isPenultimateTrick = context.CurrentTrickNumber == context.TotalTricksInMission - 1;
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M48_OmegaObjectiveCompletedInLastTrick &&
                isPenultimateTrick)
            {
                MissionObjective pendingNonOmega = updatedObjectives
                    .FirstOrDefault(o => o.Token != ObjectiveTokenType.Omega && o.Status != ObjectiveStatus.Completed);
                if (pendingNonOmega != null)
                {
                    return FailObjective(updatedObjectives, pendingNonOmega.CardId, MissionFailureReasons.Mission48PendingNonOmegaBeforeLastTrick);
                }
            }

            bool allObjectivesCompleted = updatedObjectives.All(o => o.Status == ObjectiveStatus.Completed);
            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;

            if (!allObjectivesCompleted && isLastTrick)
            {
                MissionObjective firstPending = updatedObjectives.First(o => o.Status != ObjectiveStatus.Completed);
                return FailObjective(updatedObjectives, firstPending.CardId, MissionFailureReasons.ObjectivesIncompleteAtMissionEnd);
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
            return specialRule != SpecialMissionRuleType.None &&
                specialRule != SpecialMissionRuleType.M11_CaptainSilencesOnePlayer &&
                specialRule != SpecialMissionRuleType.M17_NoTrickWonWithNumberNine &&
                specialRule != SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer &&
                specialRule != SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer;
        }

        private static int CalculateTrickDifferenceSpread(IReadOnlyDictionary<int, int> tricksBySeat, int playerCount)
        {
            int maximumWonTrickCount = 0;
            int minimumWonTrickCount = int.MaxValue;
            for (int participantSeat = 0; participantSeat < playerCount; participantSeat++)
            {
                int wonTrickCount = GetTricksWon(tricksBySeat, participantSeat);
                maximumWonTrickCount = Math.Max(maximumWonTrickCount, wonTrickCount);
                minimumWonTrickCount = Math.Min(minimumWonTrickCount, wonTrickCount);
            }
            return maximumWonTrickCount - minimumWonTrickCount;
        }

        private static int CountSpecialCardsWon(MissionEvaluationContext context)
        {
            var wonSymbols = new HashSet<SpecialCardSymbol>(
                (context.SpecialCardsWonSoFar ?? Array.Empty<Card>())
                    .Where(c => c.Suit == CardSuit.Special)
                    .Select(c => c.SpecialSymbol));

            if (context.WinningPlay.Card.Suit == CardSuit.Special)
            {
                wonSymbols.Add(context.WinningPlay.Card.SpecialSymbol);
            }

            return wonSymbols.Count;
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
