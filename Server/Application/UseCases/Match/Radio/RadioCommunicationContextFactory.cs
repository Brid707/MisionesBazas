using System;
using System.Linq;
using Application.Models;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static class RadioCommunicationContextFactory
    {
        internal static RadioCommunicationContext Create(MatchState state, int participantUserId,
            RadioCommunicationRequest request = null)
        {
            int seat = Array.IndexOf(state.ParticipantUserIds, participantUserId);
            var hand = state.PlayerHandCardIdsBySeat[seat].Select(DeckRules.GetCardById).ToArray();
            return new RadioCommunicationContext
            {
                HandCards = hand,
                CardToCommunicate = hand.FirstOrDefault(card => card.IdCard == request?.CardId),
                CurrentTrickNumber = state.CurrentTrickNumber,
                IsTrickInProgress = state.CurrentTrickCardPlays.Count > 0,
                HasCommunicatedThisAttempt =
                    state.RadioCommunicationsByParticipantUserId.ContainsKey(participantUserId),
                IsSilencedByCaptain = state.MissionAttempt.RoleConfig?.SilencedPlayerSeat == seat,
                CommunicationRule = MissionCatalog.GetMission(state.MissionAttempt.MissionNumber).CommunicationRule,
                SelectedPosition = RadioCommunicationRuleMapping.MapRequestedMarker(
                    request?.SelectedMarker ?? RadioPublicMarker.None)
            };
        }
    }
}
