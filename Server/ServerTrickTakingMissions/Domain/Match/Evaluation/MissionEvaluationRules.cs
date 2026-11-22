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
        private const int FirstMissionTrickNumber = 1;
        private const int FirstSpecialCardRank = (int)SpecialCardSymbol.Diamond;
        /// <summary>
        /// Evaluates a completed trick, verifying captured objectives and evaluating active special mission rules.
        /// </summary>
        /// <param name="context">The contextual state of the completed trick, hands, and mission rules.</param>
        /// <returns>A <see cref="MissionEvaluationResult"/> detailing attempt progress, success, or the failure
        /// reason.</returns>
        /// <exception cref="ArgumentNullException">Thrown when required context fields are null.</exception>
        public static MissionEvaluationResult EvaluateCompletedTrick(MissionEvaluationContext context)
        {
            MissionObjectiveEvaluationRules.ValidateEvaluationContext(context);
            var updatedObjectives = new List<MissionObjective>(context.CurrentObjectives);
            MissionEvaluationResult missionEvaluation = MissionObjectiveEvaluationRules.EvaluateObjectivesInTrick(context, updatedObjectives);
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

        private static MissionEvaluationResult EvaluateSpecialRule(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = EvaluateTrickCountConstraints(context, updatedObjectives);
            if (result == null)
            {
                result = EvaluateCardNumberConstraints(context, updatedObjectives);
            }
            if (result == null)
            {
                result = EvaluateSpecialCardConstraints(context, updatedObjectives);
            }
            if (result == null)
            {
                result = EvaluateAssignedPlayerConstraints(context, updatedObjectives);
            }
            if (result == null)
            {
                result = EvaluateDistributionConstraints(context, updatedObjectives);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateTrickCountConstraints(MissionEvaluationContext context,
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

        private static MissionEvaluationResult EvaluateCardNumberConstraints(MissionEvaluationContext context,
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
            MissionEvaluationResult result = null;
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M44_SpecialCardsWinTricksInAscendingOrder &&
                context.WinningPlay.Card.Suit == CardSuit.Special && !IsSpecialCardAscending(context))
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission44SpecialOrderViolated);
            }
            if (result == null && remainingSpecialToWin == 0)
            {
                result = MissionEvaluationResult.Success(updatedObjectives,
                    MissionFailureReasons.MissionSuccessMessage);
            }
            if (result == null && remainingSpecialToWin > context.TotalTricksInMission - context.CurrentTrickNumber)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives,
                    MissionFailureReasons.Mission13NotAllSpecialCardsWon);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateSpecialCardConstraints(MissionEvaluationContext context,
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
            SpecialCardSymbol expectedSymbol = (SpecialCardSymbol)(priorSpecialCount + FirstSpecialCardRank);

            return currentSymbol == expectedSymbol;
        }

        private static MissionEvaluationResult EvaluateAssignedPlayerConstraints(
            MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            switch (context.Definition.SpecialRule)
            {
                case SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard:
                    result = EvaluateMission33(context, updatedObjectives);
                    break;
                case SpecialMissionRuleType.M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo:
                    result = EvaluateMission34(context, updatedObjectives);
                    break;
                case SpecialMissionRuleType.M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard:
                    result = EvaluateMission41(context, updatedObjectives);
                    break;
                default:
                    break;
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateMission33(MissionEvaluationContext context,
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

        private static MissionEvaluationResult EvaluateMission34(MissionEvaluationContext context,
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

        private static MissionEvaluationResult EvaluateMission41(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = MissionEvaluationResult.Fail(updatedObjectives,
                MissionFailureReasons.Mission41RoleUnassigned);
            byte? selectedSeat = context.RoleConfig?.FirstAndLastTrickWinnerSeat;
            if (selectedSeat.HasValue && selectedSeat.Value < context.PlayerCount)
            {
                result = EvaluateFirstAndLastWinner(context, updatedObjectives);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateFirstAndLastWinner(MissionEvaluationContext context,
            List<MissionObjective> objectives)
        {
            bool isFirstTrick = context.CurrentTrickNumber == FirstMissionTrickNumber;
            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;
            bool hasSelectedWinner = context.WinningPlay.Seat == context.RoleConfig.FirstAndLastTrickWinnerSeat;
            string failureReason = null;
            if (isFirstTrick || isLastTrick)
            {
                failureReason = GetFirstOrLastWinnerFailure(context, hasSelectedWinner);
            }
            else if (hasSelectedWinner)
            {
                failureReason = MissionFailureReasons.Mission41IntermediateTrickWonBySelected;
            }
            return failureReason == null ? null : MissionEvaluationResult.Fail(objectives, failureReason);
        }

        private static string GetFirstOrLastWinnerFailure(MissionEvaluationContext context, bool hasSelectedWinner)
        {
            bool isFirstTrick = context.CurrentTrickNumber == FirstMissionTrickNumber;
            string failureReason = null;
            if (!hasSelectedWinner)
            {
                failureReason = isFirstTrick
                    ? MissionFailureReasons.Mission41FirstTrickNotWonBySelected
                    : MissionFailureReasons.Mission41LastTrickNotWonBySelected;
            }
            else if (context.WinningPlay.Card.Suit == CardSuit.Special)
            {
                failureReason = isFirstTrick
                    ? MissionFailureReasons.Mission41FirstTrickWonWithSpecial
                    : MissionFailureReasons.Mission41LastTrickWonWithSpecial;
            }
            return failureReason;
        }

        private static MissionEvaluationResult EvaluateDistributionConstraints(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts)
            {
                result = EvaluateMission46(context, updatedObjectives);
            }
            else if (context.Definition.SpecialRule == SpecialMissionRuleType.M50_SplitTrickWinsDistribution)
            {
                result = EvaluateMission50(context, updatedObjectives);
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateMission46(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            string failureReason = null;
            MissionEvaluationResult result = null;
            if (!context.HeartNineOwnerSeat.HasValue || context.HeartNineOwnerSeat.Value >= context.PlayerCount)
            {
                failureReason = MissionFailureReasons.Mission46HeartNineUnidentified;
            }
            else
            {
                failureReason = GetHeartCaptureFailure(context);
            }
            if (failureReason != null)
            {
                result = MissionEvaluationResult.Fail(updatedObjectives, failureReason);
            }
            else if (context.CapturedHeartCardCount == s_requiredHeartCardCount)
            {
                result = MissionEvaluationResult.Success(updatedObjectives,
                    MissionFailureReasons.MissionSuccessMessage);
            }
            return result;
        }

        private static readonly int s_requiredHeartCardCount =
            TrickTakingMissions.Rules.Rules.DeckRules.CreateStandardDeck().Count(card => card.Suit == CardSuit.Heart);

        private static string GetHeartCaptureFailure(MissionEvaluationContext context)
        {
            if (context.CapturedHeartCardCount < 0 || context.CapturedHeartCardCount > s_requiredHeartCardCount)
            {
                throw new ArgumentException(nameof(context.CapturedHeartCardCount));
            }
            byte targetSeat = ParticipantSeatRules.GetNextClockwiseSeat(context.HeartNineOwnerSeat.Value,
                context.PlayerCount);
            bool hasHeartCard = context.CompletedTrickPlays.Any(play => play.Card.Suit == CardSuit.Heart);
            string failureReason = null;
            if (hasHeartCard && context.WinningPlay.Seat != targetSeat)
            {
                failureReason = MissionFailureReasons.Mission46HeartCapturedByWrongSeat;
            }
            else if (context.CurrentTrickNumber == context.TotalTricksInMission &&
                context.CapturedHeartCardCount != s_requiredHeartCardCount)
            {
                failureReason = MissionFailureReasons.Mission46HeartsIncomplete;
            }
            return failureReason;
        }

        private static MissionEvaluationResult EvaluateMission50(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            string failureReason = MissionFailureReasons.Mission50RolesUnassigned;
            if (MissionSetupRules.ValidateRoleConfiguration(context.Definition, context.RoleConfig,
                context.PlayerCount))
            {
                failureReason = GetTrickDistributionFailure(context);
            }
            return failureReason == null ? null : MissionEvaluationResult.Fail(updatedObjectives, failureReason);
        }

        private static string GetTrickDistributionFailure(MissionEvaluationContext context)
        {
            string failureReason = null;
            bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;
            if (context.CurrentTrickNumber <= MissionFailureReasons.Mission50InitialTricksCount)
            {
                if (context.WinningPlay.Seat != context.RoleConfig.FirstFourTricksWinnerSeat)
                {
                    failureReason = MissionFailureReasons.Mission50FirstFourTricksWrongWinner;
                }
            }
            else
            {
                failureReason = GetLateTrickDistributionFailure(context, isLastTrick);
            }
            if (failureReason == null && context.CurrentTrickNumber >= context.TotalTricksInMission - 1)
            {
                bool haveRemainingParticipantsWon = Enumerable.Range(0, context.PlayerCount)
                    .Where(seat => seat != context.RoleConfig.FirstFourTricksWinnerSeat &&
                        seat != context.RoleConfig.LastTrickWinnerSeat)
                    .All(seat => GetTricksWon(context.TotalTricksWonBySeat, seat) > 0);
                if (!haveRemainingParticipantsWon)
                {
                    failureReason = MissionFailureReasons.Mission50RemainingPlayerWonNoTrick;
                }
            }
            return failureReason;
        }

        private static string GetLateTrickDistributionFailure(MissionEvaluationContext context, bool isLastTrick)
        {
            string failureReason = null;
            if (context.WinningPlay.Seat == context.RoleConfig.FirstFourTricksWinnerSeat)
            {
                failureReason = MissionFailureReasons.Mission50FirstFourWinnerWonExtra;
            }
            else if (!isLastTrick && context.WinningPlay.Seat == context.RoleConfig.LastTrickWinnerSeat)
            {
                failureReason = MissionFailureReasons.Mission50LastTrickWinnerWonEarly;
            }
            else if (isLastTrick && context.WinningPlay.Seat != context.RoleConfig.LastTrickWinnerSeat)
            {
                failureReason = MissionFailureReasons.Mission50LastTrickWrongWinner;
            }
            return failureReason;
        }

        private static MissionEvaluationResult DetermineOverallStatus(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = EvaluateMission48PenultimateTrick(context, updatedObjectives);
            if (result == null)
            {
                bool allObjectivesCompleted = updatedObjectives.All(o => o.Status == ObjectiveStatus.Completed);
                bool isLastTrick = context.CurrentTrickNumber == context.TotalTricksInMission;
                if (!allObjectivesCompleted && isLastTrick)
                {
                    MissionObjective firstPending = updatedObjectives.First(o => o.Status != ObjectiveStatus.Completed);
                    result = MissionObjectiveEvaluationRules.FailObjective(updatedObjectives, firstPending.CardId,
                        MissionFailureReasons.ObjectivesIncompleteAtMissionEnd);
                }
                else if (allObjectivesCompleted &&
                    (!HasOngoingSpecialRuleConstraints(context.Definition.SpecialRule) || isLastTrick))
                {
                    result = MissionEvaluationResult.Success(updatedObjectives,
                        MissionFailureReasons.MissionSuccessMessage);
                }
                else
                {
                    result = MissionEvaluationResult.InProgress(updatedObjectives);
                }
            }
            return result;
        }

        private static MissionEvaluationResult EvaluateMission48PenultimateTrick(MissionEvaluationContext context,
            List<MissionObjective> updatedObjectives)
        {
            MissionEvaluationResult result = null;
            bool isPenultimateTrick = context.CurrentTrickNumber == context.TotalTricksInMission - 1;
            if (context.Definition.SpecialRule == SpecialMissionRuleType.M48_OmegaObjectiveCompletedInLastTrick &&
                isPenultimateTrick)
            {
                MissionObjective pendingNonOmega = updatedObjectives
                    .FirstOrDefault(o => o.Token != ObjectiveTokenType.Omega && o.Status != ObjectiveStatus.Completed);
                if (pendingNonOmega != null)
                {
                    result = MissionObjectiveEvaluationRules.FailObjective(updatedObjectives, pendingNonOmega.CardId,
                        MissionFailureReasons.Mission48PendingNonOmegaBeforeLastTrick);
                }
            }
            return result;
        }

        private static bool HasOngoingSpecialRuleConstraints(SpecialMissionRuleType specialRule)
        {
            bool isSetupOnlyRule = specialRule == SpecialMissionRuleType.M11_CaptainSilencesOnePlayer ||
                specialRule == SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer ||
                specialRule == SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer;
            bool isPerTrickOnlyRule = specialRule == SpecialMissionRuleType.None ||
                specialRule == SpecialMissionRuleType.M17_NoTrickWonWithNumberNine;
            return !isSetupOnlyRule && !isPerTrickOnlyRule;
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
                (context.SpecialCardsWonSoFar ?? Array.Empty<Card>()).Where(c => c.Suit == CardSuit.Special)
                    .Select(c => c.SpecialSymbol));

            if (context.WinningPlay.Card.Suit == CardSuit.Special)
            {
                wonSymbols.Add(context.WinningPlay.Card.SpecialSymbol);
            }

            return wonSymbols.Count;
        }

        private static int GetTricksWon(IReadOnlyDictionary<int, int> tricksBySeat, int seat)
        {
            int wonTrickCount = 0;
            if (tricksBySeat != null && tricksBySeat.TryGetValue(seat, out int count))
            {
                wonTrickCount = count;
            }
            return wonTrickCount;
        }
    }
}
