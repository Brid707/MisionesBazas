using System;
using System.Linq;
using Application.Models;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        private const int MaximumRadioRequestsPerSecond = 4;
        private const int MaximumRadioLobbyCodeLength = 16;

        public RadioCommunicationCommit SubmitRadioCommunication(
            RadioCommunicationRequest request, int participantUserId)
        {
            var result = RejectRadio(request, RadioCommunicationRejection.InvalidSubmission);
            if (request != null && !string.IsNullOrWhiteSpace(request.LobbyCode) &&
                request.LobbyCode.Length <= MaximumRadioLobbyCodeLength)
            {
                MatchState matchState = _matchStateStore.FindMatch(request.LobbyCode);
                result = RejectRadio(request, RadioCommunicationRejection.MatchUnavailable);
                if (matchState != null)
                {
                    lock (matchState)
                    {
                        result = ResolveRadioRequest(matchState, request, participantUserId);
                    }
                }
            }
            return result;
        }

        private static RadioCommunicationCommit ResolveRadioRequest(MatchState matchState,
            RadioCommunicationRequest request, int participantUserId)
        {
            RadioCommunicationRejection identityRejection =
                ValidateRadioIdentity(matchState, request, participantUserId);
            RadioCommunicationCommit result;
            if (identityRejection != RadioCommunicationRejection.None)
            {
                result = RejectRadio(request, identityRejection);
            }
            else if (matchState.ProcessedRadioCommunicationsBySubmissionId.TryGetValue(
                request.RadioCommunicationSubmissionId, out CommittedRadioCommunication previous))
            {
                result = previous.ParticipantUserId == participantUserId && previous.Request == request
                    ? new RadioCommunicationCommit
                    {
                        RadioCommunicationSubmissionId = request.RadioCommunicationSubmissionId,
                        CommittedMatchStateVersion = previous.CommittedMatchStateVersion
                    }
                    : RejectRadio(request, RadioCommunicationRejection.SubmissionIdentityReused);
            }
            else
            {
                result = ProcessNewRadioRequest(matchState, request, participantUserId);
            }
            return result;
        }

        private static RadioCommunicationRejection ValidateRadioIdentity(MatchState matchState,
            RadioCommunicationRequest request, int participantUserId)
        {
            RadioCommunicationRejection rejection = RadioCommunicationRejection.None;
            if (!matchState.ParticipantUserIds.Contains(participantUserId))
            {
                rejection = RadioCommunicationRejection.ParticipantNotAllowed;
            }
            else if (request.MatchId != matchState.MatchId || request.RadioCommunicationSubmissionId == Guid.Empty ||
                request.SelectedMarker == RadioPublicMarker.None ||
                !Enum.IsDefined(typeof(RadioPublicMarker), request.SelectedMarker))
            {
                rejection = RadioCommunicationRejection.InvalidSubmission;
            }
            else if (request.MissionAttemptId != matchState.MissionAttempt.MissionAttemptId)
            {
                rejection = RadioCommunicationRejection.WrongMissionAttempt;
            }
            return rejection;
        }

        private static RadioCommunicationCommit ProcessNewRadioRequest(MatchState matchState,
            RadioCommunicationRequest request, int participantUserId)
        {
            RadioCommunicationRejection rejection = ValidateRadioWindow(matchState, request, participantUserId);
            RadioCommunicationValidationResult validation = null;
            if (rejection == RadioCommunicationRejection.None)
            {
                validation = RadioCommunicationRules.ValidateCommunication(
                    CreateRadioContext(matchState, request, participantUserId));
                rejection = RadioCommunicationRuleMapping.MapRejection(validation.RejectionReason);
            }
            RadioCommunicationCommit result = RejectRadio(request, rejection);
            if (rejection == RadioCommunicationRejection.None)
            {
                result = matchState.CommitRadioCommunication(new CommittedRadioCommunication
                {
                    ParticipantUserId = participantUserId,
                    Request = request,
                    ResolvedPublicMarker = RadioCommunicationRuleMapping.MapResolvedMarker(validation.ResolvedPosition),
                    CommittedMatchStateVersion = matchState.MatchStateVersion + 1
                });
            }
            return result;
        }

        private static RadioCommunicationRejection ValidateRadioWindow(MatchState matchState,
            RadioCommunicationRequest request, int participantUserId)
        {
            RadioCommunicationRejection rejection = RadioCommunicationRejection.RequestLimitReached;
            if (MatchActionRequestLimits.ConsumeParticipantWindow(matchState.RadioBudgetsByParticipantUserId,
                participantUserId, MaximumRadioRequestsPerSecond) != null)
            {
                rejection = ValidateRadioPhase(matchState, request);
            }
            return rejection;
        }

        private static RadioCommunicationRejection ValidateRadioPhase(MatchState matchState,
            RadioCommunicationRequest request)
        {
            RadioCommunicationRejection rejection = RadioCommunicationRejection.MissionPreparationRequired;
            if (matchState.MissionAttempt.Phase == MissionAttemptPhase.Finished)
            {
                rejection = RadioCommunicationRejection.MissionAttemptFinished;
            }
            else if (matchState.MissionAttempt.Phase == MissionAttemptPhase.PlayingTricks)
            {
                rejection = request.ExpectedMatchStateVersion == matchState.MatchStateVersion
                    ? RadioCommunicationRejection.None : RadioCommunicationRejection.StaleMatchState;
            }
            return rejection;
        }

        private static RadioCommunicationContext CreateRadioContext(MatchState matchState,
            RadioCommunicationRequest request, int participantUserId)
        {
            int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            var hand = matchState.PlayerHandCardIdsBySeat[participantSeat].Select(DeckRules.GetCardById).ToArray();
            return new RadioCommunicationContext
            {
                HandCards = hand,
                CardToCommunicate = hand.FirstOrDefault(card => card.IdCard == request.CardId),
                CurrentTrickNumber = matchState.CurrentTrickNumber,
                IsTrickInProgress = matchState.CurrentTrickCardPlays.Count > 0,
                HasCommunicatedThisAttempt = matchState.RadioCommunicationsByParticipantUserId
                    .ContainsKey(participantUserId),
                CommunicationRule =
                    MissionCatalog.GetMission(matchState.MissionAttempt.MissionNumber).CommunicationRule,
                SelectedPosition = RadioCommunicationRuleMapping.MapRequestedMarker(request.SelectedMarker)
            };
        }

        private static RadioCommunicationCommit RejectRadio(RadioCommunicationRequest request,
            RadioCommunicationRejection rejection)
        {
            return new RadioCommunicationCommit
            {
                RadioCommunicationSubmissionId = request?.RadioCommunicationSubmissionId ?? Guid.Empty,
                Rejection = rejection
            };
        }
    }
}
