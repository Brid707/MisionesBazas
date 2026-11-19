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
        /// <summary>
        /// Processes a player's distress signal card pass submission, executing card exchange once all players agree.
        /// </summary>
        /// <param name="submission">The distress signal submission containing pass card and direction.</param>
        /// <param name="participantUserId">The unique identifier of the submitting participant.</param>
        /// <returns>A decision describing whether the submission was accepted and if the pass was executed.</returns>
        public DistressSignalDecision SubmitDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode))
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.InvalidSubmission
                };
            }

            MatchState matchState = _matchStateStore.FindMatch(submission.LobbyCode);
            if (matchState == null)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.MatchUnavailable
                };
            }

            lock (matchState)
            {
                return ProcessDistressSignalUnderLock(matchState, submission, participantUserId);
            }
        }

        private static DistressSignalDecision ProcessDistressSignalUnderLock(
            MatchState matchState, DistressSignalSubmission submission, int participantUserId)
        {
            int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            if (participantSeat < 0 || submission.MatchId != matchState.MatchId)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.ParticipantNotAllowed
                };
            }

            if (!submission.IsVoteAccepted || submission.ActionType == DistressSignalActionType.CancelProposal)
            {
                return HandleDistressRejection(matchState);
            }

            MatchRejectionReason attemptReason = ValidateDistressAttemptState(matchState, submission);
            if (attemptReason != MatchRejectionReason.None)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = attemptReason
                };
            }

            return DispatchDistressAction(matchState, submission, (byte)participantSeat, participantUserId);
        }

        private static DistressSignalDecision DispatchDistressAction(
            MatchState matchState, DistressSignalSubmission submission, byte participantSeat, int participantUserId)
        {
            switch (submission.ActionType)
            {
                case DistressSignalActionType.ProposeUsage:
                    return HandleProposeUsage(matchState, participantSeat, participantUserId);

                case DistressSignalActionType.VoteUsage:
                    return HandleVoteUsage(matchState, participantSeat, submission.IsVoteAccepted);

                case DistressSignalActionType.VoteDirection:
                    return HandleVoteDirection(matchState, participantSeat, submission.SelectedDirection);

                case DistressSignalActionType.SubmitPassCard:
                    return HandleSubmitPassCard(matchState, submission, participantSeat);

                default:
                    return new DistressSignalDecision
                    {
                        IsAccepted = false,
                        IsExecuted = false,
                        RejectionReason = MatchRejectionReason.InvalidSubmission
                    };
            }
        }

        private static DistressSignalDecision HandleProposeUsage(
            MatchState matchState, byte participantSeat, int participantUserId)
        {
            if (matchState.DistressStep != DistressSignalStep.None)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.InvalidSubmission
                };
            }

            matchState.DistressStep = DistressSignalStep.VotingToUse;
            matchState.DistressInitiatorUserId = participantUserId;
            matchState.HasDistressBeenRejected = false;
            matchState.DistressUsageYesVotesBySeat.Clear();
            matchState.DistressUsageYesVotesBySeat.Add(participantSeat);

            matchState.MatchStateVersion++;
            return CreateAcceptedDecision(matchState, false);
        }

        private static DistressSignalDecision HandleVoteUsage(
            MatchState matchState, byte participantSeat, bool isVoteAccepted)
        {
            if (matchState.DistressStep != DistressSignalStep.VotingToUse)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.InvalidSubmission
                };
            }

            if (!isVoteAccepted)
            {
                return HandleDistressRejection(matchState);
            }

            matchState.DistressUsageYesVotesBySeat.Add(participantSeat);
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            if (matchState.DistressUsageYesVotesBySeat.Count >= requiredPlayers)
            {
                matchState.DistressStep = DistressSignalStep.VotingDirection;
                matchState.DistressDirectionVotesBySeat.Clear();
            }

            matchState.MatchStateVersion++;
            return CreateAcceptedDecision(matchState, false);
        }

        private static DistressSignalDecision HandleVoteDirection(
            MatchState matchState, byte participantSeat, PassDirection direction)
        {
            if (matchState.DistressStep != DistressSignalStep.VotingDirection)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.InvalidSubmission
                };
            }

            matchState.DistressDirectionVotesBySeat[participantSeat] = direction;
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            if (matchState.DistressDirectionVotesBySeat.Count >= requiredPlayers)
            {
                int leftCount = matchState.DistressDirectionVotesBySeat.Values
                    .Count(dir => dir == PassDirection.Left);
                int rightCount = matchState.DistressDirectionVotesBySeat.Values
                    .Count(dir => dir == PassDirection.Right);
                PassDirection resolved = leftCount >= rightCount ? PassDirection.Left : PassDirection.Right;

                matchState.DistressAgreedDirection = resolved;
                matchState.DistressStep = DistressSignalStep.SelectingCard;
                matchState.PendingDistressPassCardIdsBySeat.Clear();
            }

            matchState.MatchStateVersion++;
            return CreateAcceptedDecision(matchState, false);
        }

        private static DistressSignalDecision HandleSubmitPassCard(
            MatchState matchState, DistressSignalSubmission submission, byte participantSeat)
        {
            if (matchState.DistressStep != DistressSignalStep.SelectingCard)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.InvalidSubmission
                };
            }

            MatchRejectionReason cardReason = ValidateDistressCard(
                matchState, submission.CardIdToPass, participantSeat);
            if (cardReason != MatchRejectionReason.None)
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = cardReason
                };
            }

            PassDirection direction = matchState.DistressAgreedDirection ?? PassDirection.Left;
            matchState.PendingDistressPassCardIdsBySeat[participantSeat] = submission.CardIdToPass;
            matchState.PendingDistressDirectionsBySeat[participantSeat] = direction;

            int requiredPlayers = matchState.ParticipantUserIds.Length;
            if (matchState.PendingDistressPassCardIdsBySeat.Count >= requiredPlayers)
            {
                return ExecuteDistressExchange(matchState, direction);
            }

            matchState.MatchStateVersion++;
            return CreateAcceptedDecision(matchState, false);
        }

        private static DistressSignalDecision HandleDistressRejection(MatchState matchState)
        {
            matchState.ResetDistressState();
            matchState.HasDistressBeenRejected = true;
            matchState.MatchStateVersion++;
            return CreateAcceptedDecision(matchState, false);
        }

        private static DistressSignalDecision CreateAcceptedDecision(
            MatchState matchState, bool isExecuted)
        {
            return new DistressSignalDecision
            {
                IsAccepted = true,
                IsExecuted = isExecuted,
                RejectionReason = MatchRejectionReason.None,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
        }

        private static MatchRejectionReason ValidateDistressPrerequisites(
            MatchState matchState, DistressSignalSubmission submission, int participantSeat)
        {
            if (participantSeat < 0 || submission.MatchId != matchState.MatchId)
            {
                return MatchRejectionReason.ParticipantNotAllowed;
            }

            MatchRejectionReason attemptReason = ValidateDistressAttemptState(matchState, submission);
            if (attemptReason != MatchRejectionReason.None)
            {
                return attemptReason;
            }

            return ValidateDistressCard(matchState, submission.CardIdToPass, participantSeat);
        }

        private static MatchRejectionReason ValidateDistressAttemptState(
            MatchState matchState, DistressSignalSubmission submission)
        {
            if (matchState.MissionAttempt == null ||
                submission.MissionAttemptId != matchState.MissionAttempt.MissionAttemptId)
            {
                return MatchRejectionReason.WrongMissionAttempt;
            }

            if (matchState.MissionAttempt.HasUsedDistressSignal)
            {
                return MatchRejectionReason.InvalidSubmission;
            }

            if (matchState.CurrentTrickNumber > 1 || matchState.CurrentTrickCardPlays.Count > 0)
            {
                return MatchRejectionReason.InvalidSubmission;
            }

            if (HasAnyPlayerCommunicated(matchState))
            {
                return MatchRejectionReason.InvalidSubmission;
            }

            return MatchRejectionReason.None;
        }

        private static bool HasAnyPlayerCommunicated(MatchState matchState)
        {
            if (matchState.MissionAttempt?.RadioCommunicationsBySeat == null)
            {
                return false;
            }

            return matchState.MissionAttempt.RadioCommunicationsBySeat.Any(
                communication => communication.HasUsedCommunicationToken);
        }

        private static MatchRejectionReason ValidateDistressCard(
            MatchState matchState, int cardIdToPass, int participantSeat)
        {
            List<int> playerHand = matchState.PlayerHandCardIdsBySeat[participantSeat];
            if (!playerHand.Contains(cardIdToPass))
            {
                return MatchRejectionReason.CardNotInHand;
            }

            Card cardToPass = DeckRules.GetCardById(cardIdToPass);
            if (cardToPass.Suit == CardSuit.Special)
            {
                return MatchRejectionReason.InvalidSubmission;
            }

            return MatchRejectionReason.None;
        }

        private static void RecordDistressSelection(
            MatchState matchState, byte seatIndex, DistressSignalSubmission submission)
        {
            matchState.PendingDistressPassCardIdsBySeat[seatIndex] = submission.CardIdToPass;
            matchState.PendingDistressDirectionsBySeat[seatIndex] =
                matchState.DistressAgreedDirection ?? submission.SelectedDirection;
        }

        private static DistressSignalDecision ExecuteDistressExchange(
            MatchState matchState, PassDirection agreedDirection)
        {
            DistressSignalContext distressContext = BuildDistressContext(matchState, agreedDirection);
            if (!DistressSignalRules.CanExecuteDistressSignal(distressContext))
            {
                return new DistressSignalDecision
                {
                    IsAccepted = false,
                    IsExecuted = false,
                    RejectionReason = MatchRejectionReason.InvalidSubmission,
                    CommittedMatchStateVersion = matchState.MatchStateVersion
                };
            }

            ApplyDistressExchange(matchState, distressContext);

            return new DistressSignalDecision
            {
                IsAccepted = true,
                IsExecuted = true,
                RejectionReason = MatchRejectionReason.None,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
        }

        private static DistressSignalContext BuildDistressContext(
            MatchState matchState, PassDirection agreedDirection)
        {
            int requiredPlayers = matchState.ParticipantUserIds.Length;
            List<IReadOnlyList<Card>> hands = new List<IReadOnlyList<Card>>(requiredPlayers);

            for (int seatIndex = 0; seatIndex < requiredPlayers; seatIndex++)
            {
                List<Card> seatHand = matchState.PlayerHandCardIdsBySeat[seatIndex]
                    .Select(DeckRules.GetCardById)
                    .ToList();
                hands.Add(seatHand.AsReadOnly());
            }

            Dictionary<byte, Card> selectedCards = new Dictionary<byte, Card>();
            foreach (KeyValuePair<byte, int> entry in matchState.PendingDistressPassCardIdsBySeat)
            {
                selectedCards[entry.Key] = DeckRules.GetCardById(entry.Value);
            }

            return new DistressSignalContext
            {
                CurrentTrickNumber = matchState.CurrentTrickNumber,
                IsTrickInProgress = matchState.CurrentTrickCardPlays.Count > 0,
                HasUsedDistressSignal = matchState.MissionAttempt.HasUsedDistressSignal,
                HasAnyPlayerCommunicated = false,
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

            matchState.CommitMissionAttemptUpdate(matchState.MissionAttempt with
            {
                HasUsedDistressSignal = true,
                AttemptNumber = matchState.MissionAttempt.AttemptNumber + 1
            });

            matchState.ResetDistressState();
            matchState.HasDistressBeenRejected = false;
        }
    }
}
