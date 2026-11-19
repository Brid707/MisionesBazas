using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        /// <summary>
        /// Processes a player's radio communication submission according to mission rules and current trick state.
        /// </summary>
        /// <param name="submission">The radio communication payload specifying card and position data.</param>
        /// <param name="participantUserId">The unique identifier of the requesting participant.</param>
        /// <returns>The decision indicating whether communication was accepted or rejected with details.</returns>
        public RadioCommunicationDecision CommunicateCard(
            RadioCommunicationSubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode))
            {
                return new RadioCommunicationDecision
                {
                    IsAccepted = false,
                    RejectionReason = RadioCommunicationRejectionReason.CardNotInHand
                };
            }

            MatchState matchState = _matchStateStore.FindMatch(submission.LobbyCode);
            if (matchState == null)
            {
                return new RadioCommunicationDecision
                {
                    IsAccepted = false,
                    RejectionReason = RadioCommunicationRejectionReason.CardNotInHand
                };
            }

            lock (matchState)
            {
                return ProcessRadioCommunicationUnderLock(matchState, submission, participantUserId);
            }
        }

        private static RadioCommunicationDecision ProcessRadioCommunicationUnderLock(
            MatchState matchState, RadioCommunicationSubmission submission, int participantUserId)
        {
            int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            if (!IsValidParticipantAndAttempt(matchState, submission, participantSeat))
            {
                return new RadioCommunicationDecision
                {
                    IsAccepted = false,
                    RejectionReason = RadioCommunicationRejectionReason.CardNotInHand
                };
            }

            List<int> handCardIds = matchState.PlayerHandCardIdsBySeat[participantSeat];
            if (!handCardIds.Contains(submission.CardId))
            {
                return new RadioCommunicationDecision
                {
                    IsAccepted = false,
                    RejectionReason = RadioCommunicationRejectionReason.CardNotInHand
                };
            }

            RadioCommunicationContext context = BuildRadioCommunicationContext(
                matchState, submission, participantSeat);
            RadioCommunicationValidationResult validation =
                RadioCommunicationRules.ValidateCommunication(context);

            if (!validation.IsValid)
            {
                return new RadioCommunicationDecision
                {
                    IsAccepted = false,
                    RejectionReason = validation.RejectionReason,
                    CommittedMatchStateVersion = matchState.MatchStateVersion
                };
            }

            PlayerRadioCommunicationState playerCommState =
                matchState.MissionAttempt.RadioCommunicationsBySeat[participantSeat];
            PlayerRadioCommunicationState updatedState = new PlayerRadioCommunicationState
            {
                Seat = (byte)participantSeat,
                HasUsedCommunicationToken = true,
                IsSilencedByCaptain = playerCommState.IsSilencedByCaptain,
                CommunicatedCard = context.CardToCommunicate,
                TokenPosition = validation.ResolvedPosition
            };

            CommitRadioCommunication(matchState, participantSeat, updatedState);

            return new RadioCommunicationDecision
            {
                IsAccepted = true,
                RejectionReason = RadioCommunicationRejectionReason.None,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
        }

        private static bool IsValidParticipantAndAttempt(
            MatchState matchState, RadioCommunicationSubmission submission, int participantSeat)
        {
            if (participantSeat < 0 || submission.MatchId != matchState.MatchId)
            {
                return false;
            }

            if (matchState.MissionAttempt == null ||
                submission.MissionAttemptId != matchState.MissionAttempt.MissionAttemptId)
            {
                return false;
            }

            return true;
        }

        private static RadioCommunicationContext BuildRadioCommunicationContext(
            MatchState matchState, RadioCommunicationSubmission submission, int participantSeat)
        {
            List<int> handCardIds = matchState.PlayerHandCardIdsBySeat[participantSeat];
            List<Card> handCards = handCardIds.Select(DeckRules.GetCardById).ToList();
            Card cardToCommunicate = DeckRules.GetCardById(submission.CardId);
            MissionDefinition missionDefinition = MissionCatalog.GetMission(
                matchState.MissionAttempt.MissionNumber);
            PlayerRadioCommunicationState playerCommState =
                matchState.MissionAttempt.RadioCommunicationsBySeat[participantSeat];

            return new RadioCommunicationContext
            {
                HandCards = handCards,
                CardToCommunicate = cardToCommunicate,
                SelectedPosition = submission.SelectedPosition,
                CommunicationRule = missionDefinition.CommunicationRule,
                CurrentTrickNumber = matchState.CurrentTrickNumber,
                IsTrickInProgress = matchState.CurrentTrickCardPlays.Count > 0,
                HasCommunicatedThisAttempt = playerCommState.HasUsedCommunicationToken,
                IsSilencedByCaptain = playerCommState.IsSilencedByCaptain
            };
        }

        private static void CommitRadioCommunication(
            MatchState matchState, int participantSeat, PlayerRadioCommunicationState updatedState)
        {
            List<PlayerRadioCommunicationState> updatedCommunications =
                new List<PlayerRadioCommunicationState>(matchState.MissionAttempt.RadioCommunicationsBySeat);

            updatedCommunications[participantSeat] = updatedState;

            matchState.CommitMissionAttemptUpdate(matchState.MissionAttempt with
            {
                RadioCommunicationsBySeat = updatedCommunications.AsReadOnly()
            });
        }
    }
}
