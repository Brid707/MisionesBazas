using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        private const int MaximumDistressLobbyCodeLength = 16;

        /// <summary>
        /// Processes a player's distress signal action, executing card exchange once all players unanimously agree.
        /// </summary>
        /// <param name="request">The distress signal request containing action, direction, or card selection.</param>
        /// <param name="participantUserId">The unique identifier of the submitting participant.</param>
        /// <returns>A commit describing whether the action was accepted and if the pass was executed.</returns>
        public DistressSignalCommit SubmitDistressSignal(DistressSignalRequest request, int participantUserId)
        {
            DistressSignalCommit result = RejectDistress(DistressSignalRejection.InvalidSubmission, 0);
            if (request != null && !string.IsNullOrWhiteSpace(request.LobbyCode) &&
                request.LobbyCode.Length <= MaximumDistressLobbyCodeLength)
            {
                MatchState matchState = _matchStateStore.FindMatch(request.LobbyCode);
                result = RejectDistress(DistressSignalRejection.MatchUnavailable, 0);
                if (matchState != null)
                {
                    lock (matchState)
                    {
                        result = ProcessDistressSignalUnderLock(matchState, request, participantUserId);
                    }
                }
            }
            return result;
        }

        private static DistressSignalCommit ProcessDistressSignalUnderLock(
            MatchState matchState, DistressSignalRequest request, int participantUserId)
        {
            int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            DistressSignalRejection rejection = ValidateDistressIdentityAndAttempt(
                matchState, request, participantSeat);
            DistressSignalCommit result = RejectDistress(rejection, matchState.MatchStateVersion);
            if (rejection == DistressSignalRejection.None)
            {
                var participantAction = new DistressParticipantAction(
                    request, (byte)participantSeat, participantUserId);
                result = DispatchDistressAction(matchState, participantAction);
            }
            return result;
        }

        private static DistressSignalRejection ValidateDistressIdentityAndAttempt(
            MatchState matchState, DistressSignalRequest request, int participantSeat)
        {
            DistressSignalRejection rejection;
            if (participantSeat < 0 || request.MatchId != matchState.MatchId)
            {
                rejection = DistressSignalRejection.ParticipantNotAllowed;
            }
            else if (!Enum.IsDefined(typeof(DistressSignalActionType), request.ActionType) ||
                request.ActionType == DistressSignalActionType.None)
            {
                rejection = DistressSignalRejection.InvalidSubmission;
            }
            else
            {
                rejection = ValidateDistressAttemptState(matchState, request);
            }
            return rejection;
        }

        private static DistressSignalRejection ValidateDistressAttemptState(
            MatchState matchState, DistressSignalRequest request)
        {
            DistressSignalRejection rejection = DistressSignalRejection.None;
            if (matchState.MissionAttempt == null ||
                request.MissionAttemptId != matchState.MissionAttempt.MissionAttemptId)
            {
                rejection = DistressSignalRejection.WrongMissionAttempt;
            }
            else if (matchState.MissionAttempt.Phase == MissionAttemptPhase.Finished)
            {
                rejection = DistressSignalRejection.MissionAttemptFinished;
            }
            else if (matchState.MissionAttempt.Phase != MissionAttemptPhase.PlayingTricks)
            {
                rejection = DistressSignalRejection.MissionPreparationRequired;
            }
            else
            {
                rejection = ValidateDistressGameplayWindow(matchState);
            }
            return rejection;
        }

        private static DistressSignalRejection ValidateDistressGameplayWindow(MatchState matchState)
        {
            DistressSignalRejection rejection = DistressSignalRejection.None;
            if (matchState.MissionAttempt.HasUsedDistressSignal)
            {
                rejection = DistressSignalRejection.DistressAlreadyUsed;
            }
            else if (matchState.CurrentTrickNumber > 1 || matchState.CurrentTrickCardPlays.Count > 0)
            {
                rejection = DistressSignalRejection.TrickAlreadyStarted;
            }
            else if (HasAnyPlayerCommunicated(matchState))
            {
                rejection = DistressSignalRejection.RadioAlreadyUsed;
            }
            return rejection;
        }

        private static bool HasAnyPlayerCommunicated(MatchState matchState)
        {
            bool hasCommittedRadio = matchState.RadioCommunicationsByParticipantUserId != null &&
                matchState.RadioCommunicationsByParticipantUserId.Count > 0;
            bool hasAttemptSeatRadio = matchState.MissionAttempt?.RadioCommunicationsBySeat != null &&
                matchState.MissionAttempt.RadioCommunicationsBySeat.Any(
                    communication => communication.HasUsedCommunicationToken);
            return hasCommittedRadio || hasAttemptSeatRadio;
        }

        private static DistressSignalCommit DispatchDistressAction(
            MatchState matchState, DistressParticipantAction participantAction)
        {
            DistressSignalCommit result;
            switch (participantAction.Request.ActionType)
            {
                case DistressSignalActionType.ProposeUsage:
                    result = HandleProposeUsage(matchState, participantAction);
                    break;
                case DistressSignalActionType.VoteUsage:
                    result = HandleVoteUsage(matchState, participantAction);
                    break;
                case DistressSignalActionType.VoteDirection:
                    result = HandleVoteDirection(matchState, participantAction);
                    break;
                case DistressSignalActionType.SubmitPassCard:
                    result = HandleSubmitPassCard(matchState, participantAction);
                    break;
                case DistressSignalActionType.CancelProposal:
                    result = HandleCancelProposal(matchState);
                    break;
                default:
                    result = RejectDistress(DistressSignalRejection.InvalidSubmission, matchState.MatchStateVersion);
                    break;
            }
            return result;
        }

        private static DistressSignalCommit HandleProposeUsage(
            MatchState matchState, DistressParticipantAction participantAction)
        {
            DistressSignalCommit result;
            if (!participantAction.Request.IsVoteAccepted)
            {
                result = RejectDistress(DistressSignalRejection.InvalidSubmission, matchState.MatchStateVersion);
            }
            else if (matchState.DistressStep != DistressSignalStep.None)
            {
                result = RejectDistress(DistressSignalRejection.InvalidStepTransition, matchState.MatchStateVersion);
            }
            else
            {
                matchState.DistressStep = DistressSignalStep.VotingToUse;
                matchState.DistressInitiatorUserId = participantAction.ParticipantUserId;
                matchState.HasDistressBeenRejected = false;
                matchState.DistressUsageYesVotesBySeat.Clear();
                matchState.DistressUsageYesVotesBySeat.Add(participantAction.ParticipantSeat);
                matchState.MatchStateVersion++;
                result = CreateAcceptedCommit(matchState, false);
            }
            return result;
        }

        private static DistressSignalCommit HandleVoteUsage(
            MatchState matchState, DistressParticipantAction participantAction)
        {
            DistressSignalCommit result;
            if (matchState.DistressStep != DistressSignalStep.VotingToUse)
            {
                result = RejectDistress(DistressSignalRejection.InvalidStepTransition, matchState.MatchStateVersion);
            }
            else if (!participantAction.Request.IsVoteAccepted)
            {
                result = HandleDistressRejection(matchState);
            }
            else
            {
                matchState.DistressUsageYesVotesBySeat.Add(participantAction.ParticipantSeat);
                int requiredPlayers = matchState.ParticipantUserIds.Length;
                if (matchState.DistressUsageYesVotesBySeat.Count >= requiredPlayers)
                {
                    matchState.DistressStep = DistressSignalStep.VotingDirection;
                    matchState.DistressDirectionVotesBySeat.Clear();
                }
                matchState.MatchStateVersion++;
                result = CreateAcceptedCommit(matchState, false);
            }
            return result;
        }

        private static DistressSignalCommit HandleVoteDirection(
            MatchState matchState, DistressParticipantAction participantAction)
        {
            PassDirection selectedDirection = participantAction.Request.SelectedDirection;
            bool isDirectionValid = selectedDirection == PassDirection.Left ||
                selectedDirection == PassDirection.Right;
            DistressSignalCommit result;
            if (!participantAction.Request.IsVoteAccepted || !isDirectionValid)
            {
                result = RejectDistress(DistressSignalRejection.InvalidSubmission, matchState.MatchStateVersion);
            }
            else if (matchState.DistressStep != DistressSignalStep.VotingDirection)
            {
                result = RejectDistress(DistressSignalRejection.InvalidStepTransition, matchState.MatchStateVersion);
            }
            else
            {
                matchState.DistressDirectionVotesBySeat[participantAction.ParticipantSeat] = selectedDirection;
                result = ResolveDirectionVotes(matchState);
            }
            return result;
        }

        private static DistressSignalCommit ResolveDirectionVotes(MatchState matchState)
        {
            DistressSignalCommit result;
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            if (matchState.DistressDirectionVotesBySeat.Count < requiredPlayers)
            {
                matchState.MatchStateVersion++;
                result = CreateAcceptedCommit(matchState, false);
            }
            else
            {
                int leftCount = matchState.DistressDirectionVotesBySeat.Values
                    .Count(direction => direction == PassDirection.Left);
                int rightCount = matchState.DistressDirectionVotesBySeat.Values
                    .Count(direction => direction == PassDirection.Right);
                bool isUnanimousLeft = leftCount == requiredPlayers;
                bool isUnanimousRight = rightCount == requiredPlayers;
                if (isUnanimousLeft || isUnanimousRight)
                {
                    matchState.DistressAgreedDirection = isUnanimousLeft ? PassDirection.Left : PassDirection.Right;
                    matchState.DistressStep = DistressSignalStep.SelectingCard;
                    matchState.PendingDistressPassCardIdsBySeat.Clear();
                    matchState.MatchStateVersion++;
                    result = CreateAcceptedCommit(matchState, false);
                }
                else
                {
                    result = HandleDistressRejection(matchState);
                }
            }
            return result;
        }

        private static DistressSignalCommit HandleSubmitPassCard(
            MatchState matchState, DistressParticipantAction participantAction)
        {
            DistressSignalCommit result;
            if (!participantAction.Request.IsVoteAccepted)
            {
                result = RejectDistress(DistressSignalRejection.InvalidSubmission, matchState.MatchStateVersion);
            }
            else if (matchState.DistressStep != DistressSignalStep.SelectingCard)
            {
                result = RejectDistress(DistressSignalRejection.InvalidStepTransition, matchState.MatchStateVersion);
            }
            else
            {
                DistressSignalRejection cardRejection = ValidateDistressCard(
                    matchState, participantAction.Request.CardIdToPass, participantAction.ParticipantSeat);
                if (cardRejection != DistressSignalRejection.None)
                {
                    result = RejectDistress(cardRejection, matchState.MatchStateVersion);
                }
                else
                {
                    result = RecordCardAndExecuteIfComplete(matchState, participantAction);
                }
            }
            return result;
        }

        private static DistressSignalCommit RecordCardAndExecuteIfComplete(
            MatchState matchState, DistressParticipantAction participantAction)
        {
            DistressSignalCommit result;
            PassDirection direction = matchState.DistressAgreedDirection ?? PassDirection.Left;
            matchState.PendingDistressPassCardIdsBySeat[participantAction.ParticipantSeat] =
                participantAction.Request.CardIdToPass;
            matchState.PendingDistressDirectionsBySeat[participantAction.ParticipantSeat] = direction;
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            if (matchState.PendingDistressPassCardIdsBySeat.Count >= requiredPlayers)
            {
                result = ExecuteDistressExchange(matchState, direction);
            }
            else
            {
                matchState.MatchStateVersion++;
                result = CreateAcceptedCommit(matchState, false);
            }
            return result;
        }

        private static DistressSignalCommit HandleCancelProposal(MatchState matchState)
        {
            bool isDistressInProgress = matchState.DistressStep != DistressSignalStep.None &&
                matchState.DistressStep != DistressSignalStep.Completed;
            return isDistressInProgress
                ? HandleDistressRejection(matchState)
                : RejectDistress(DistressSignalRejection.InvalidStepTransition, matchState.MatchStateVersion);
        }

        private static DistressSignalCommit HandleDistressRejection(MatchState matchState)
        {
            matchState.ResetDistressState();
            matchState.HasDistressBeenRejected = true;
            matchState.MatchStateVersion++;
            return CreateAcceptedCommit(matchState, false);
        }

        private static DistressSignalRejection ValidateDistressCard(
            MatchState matchState, int cardIdToPass, int participantSeat)
        {
            DistressSignalRejection rejection = DistressSignalRejection.None;
            List<int> playerHand = matchState.PlayerHandCardIdsBySeat[participantSeat];
            if (cardIdToPass < 1 || cardIdToPass > DeckRules.TotalDeckSize || !playerHand.Contains(cardIdToPass))
            {
                rejection = DistressSignalRejection.CardNotInHand;
            }
            else if (DeckRules.GetCardById(cardIdToPass).Suit == CardSuit.Special)
            {
                rejection = DistressSignalRejection.SpecialCardNotAllowed;
            }
            return rejection;
        }

        private static DistressSignalCommit ExecuteDistressExchange(
            MatchState matchState, PassDirection agreedDirection)
        {
            DistressSignalContext distressContext = BuildDistressContext(matchState, agreedDirection);
            DistressSignalCommit result;
            if (!DistressSignalRules.CanExecuteDistressSignal(distressContext))
            {
                result = RejectDistress(DistressSignalRejection.InvalidSubmission, matchState.MatchStateVersion);
            }
            else
            {
                ApplyDistressExchange(matchState, distressContext);
                result = CreateAcceptedCommit(matchState, true);
            }
            return result;
        }

        private static DistressSignalContext BuildDistressContext(
            MatchState matchState, PassDirection agreedDirection)
        {
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            var hands = new List<IReadOnlyList<Card>>(requiredPlayers);
            for (int seatIndex = 0; seatIndex < requiredPlayers; seatIndex++)
            {
                List<Card> seatHand = matchState.PlayerHandCardIdsBySeat[seatIndex]
                    .Select(DeckRules.GetCardById)
                    .ToList();
                hands.Add(seatHand.AsReadOnly());
            }
            var selectedCards = new Dictionary<byte, Card>();
            foreach (KeyValuePair<byte, int> entry in matchState.PendingDistressPassCardIdsBySeat)
            {
                selectedCards[entry.Key] = DeckRules.GetCardById(entry.Value);
            }
            return new DistressSignalContext
            {
                CurrentTrickNumber = matchState.CurrentTrickNumber,
                IsTrickInProgress = matchState.CurrentTrickCardPlays.Count > 0,
                HasUsedDistressSignal = matchState.MissionAttempt.HasUsedDistressSignal,
                HasAnyPlayerCommunicated = HasAnyPlayerCommunicated(matchState),
                AgreedDirection = agreedDirection,
                HandsBySeat = hands.AsReadOnly(),
                SelectedPassCardBySeat = selectedCards
            };
        }

        private static void ApplyDistressExchange(
            MatchState matchState, DistressSignalContext distressContext)
        {
            IReadOnlyList<IReadOnlyList<Card>> newHands =
                DistressSignalRules.ExecuteCardPass(distressContext);
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            for (int seatIndex = 0; seatIndex < requiredPlayers; seatIndex++)
            {
                matchState.PlayerHandCardIdsBySeat[seatIndex] = newHands[seatIndex]
                    .Select(card => card.IdCard)
                    .ToList();
            }
            int updatedAttemptNumber = matchState.HasAppliedDistressPenaltyInCurrentMission
                ? matchState.MissionAttempt.AttemptNumber
                : matchState.MissionAttempt.AttemptNumber + 1;
            matchState.HasAppliedDistressPenaltyInCurrentMission = true;
            matchState.CommitMissionAttemptUpdate(matchState.MissionAttempt with
            {
                HasUsedDistressSignal = true,
                AttemptNumber = updatedAttemptNumber
            });
            matchState.ResetDistressState();
            matchState.HasDistressBeenRejected = false;
        }

        private static DistressSignalCommit CreateAcceptedCommit(MatchState matchState, bool isExecuted)
        {
            return new DistressSignalCommit
            {
                Rejection = DistressSignalRejection.None,
                HasStateChanged = true,
                IsExecuted = isExecuted,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
        }

        private static DistressSignalCommit RejectDistress(
            DistressSignalRejection rejection, long committedMatchStateVersion)
        {
            return new DistressSignalCommit
            {
                Rejection = rejection,
                HasStateChanged = false,
                IsExecuted = false,
                CommittedMatchStateVersion = committedMatchStateVersion
            };
        }
    }
}
