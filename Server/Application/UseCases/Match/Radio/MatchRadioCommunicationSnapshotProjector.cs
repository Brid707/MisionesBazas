using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static class MatchRadioCommunicationSnapshotProjector
    {
        private static readonly IReadOnlyDictionary<RadioPublicMarker, RadioCommunicationMarker> s_publicRadioMarkers =
            new Dictionary<RadioPublicMarker, RadioCommunicationMarker>
            {
                { RadioPublicMarker.None, RadioCommunicationMarker.None },
                { RadioPublicMarker.Highest, RadioCommunicationMarker.Highest },
                { RadioPublicMarker.Only, RadioCommunicationMarker.Only },
                { RadioPublicMarker.Lowest, RadioCommunicationMarker.Lowest },
                { RadioPublicMarker.Hidden, RadioCommunicationMarker.Hidden }
            };

        private static readonly IReadOnlyDictionary<CommunicationRuleType, RadioCommunicationMode> s_radioModes =
            new Dictionary<CommunicationRuleType, RadioCommunicationMode>
            {
                { CommunicationRuleType.Standard, RadioCommunicationMode.Standard },
                { CommunicationRuleType.Interference, RadioCommunicationMode.Interference },
                { CommunicationRuleType.DisruptionUntilTrick2, RadioCommunicationMode.DisruptionUntilTrick2 },
                { CommunicationRuleType.DisruptionUntilTrick3, RadioCommunicationMode.DisruptionUntilTrick3 }
            };

        private static readonly IReadOnlyDictionary<RadioCommunicationRejection, RadioCommunicationFailureReason> s_radioAvailabilityFailures =
            new Dictionary<RadioCommunicationRejection, RadioCommunicationFailureReason>
            {
                { RadioCommunicationRejection.None, RadioCommunicationFailureReason.None },
                { RadioCommunicationRejection.MissionPreparationRequired,
                    RadioCommunicationFailureReason.MissionPreparationRequired },
                { RadioCommunicationRejection.MissionAttemptFinished,
                    RadioCommunicationFailureReason.MissionAttemptFinished },
                { RadioCommunicationRejection.AlreadyCommunicatedThisAttempt,
                    RadioCommunicationFailureReason.AlreadyCommunicatedThisAttempt },
                { RadioCommunicationRejection.SilencedByCaptain, RadioCommunicationFailureReason.SilencedByCaptain },
                { RadioCommunicationRejection.CannotCommunicateDuringActiveTrick,
                    RadioCommunicationFailureReason.CannotCommunicateDuringActiveTrick },
                { RadioCommunicationRejection.DisruptedUntilTrick,
                    RadioCommunicationFailureReason.DisruptedUntilTrick },
            };

        internal static PlayerRadioCommunicationSnapshot[] CreateRadioCommunications(MatchState matchState)
        {
            return matchState.RadioCommunicationsByParticipantUserId.Values.Select(communication =>
                new PlayerRadioCommunicationSnapshot
                {
                    ParticipantUserId = communication.ParticipantUserId,
                    CommunicatedCardId = communication.Request.CardId,
                    Marker = MapPublicRadioMarker(communication.ResolvedPublicMarker),
                    HasCommunicatedCardBeenPlayed = !matchState.PlayerHandCardIdsBySeat[
                        Array.IndexOf(matchState.ParticipantUserIds, communication.ParticipantUserId)]
                        .Contains(communication.Request.CardId)
                }).ToArray();
        }

        internal static RadioCommunicationMarker MapPublicRadioMarker(RadioPublicMarker marker)
        {
            return s_publicRadioMarkers[marker];
        }

        internal static RadioCommunicationMode GetRadioMode(MatchState state)
        {
            CommunicationRuleType mode =
                MissionCatalog.GetMission(state.MissionAttempt.MissionNumber).CommunicationRule;
            return s_radioModes[mode];
        }

        internal static RadioAvailabilitySnapshot CreateRadioAvailability(MatchState state, int participantSeat)
        {
            RadioCommunicationRejection rejection = RadioCommunicationRejection.MissionPreparationRequired;
            if (state.MissionAttempt.Phase == MissionAttemptPhase.Finished)
            {
                rejection = RadioCommunicationRejection.MissionAttemptFinished;
            }
            else if (state.MissionAttempt.Phase == MissionAttemptPhase.PlayingTricks)
            {
                rejection = RadioCommunicationRuleMapping.MapRejection(RadioCommunicationRules.GetAvailabilityRejection(
                    RadioCommunicationContextFactory.Create(state, state.ParticipantUserIds[participantSeat])));
            }
            return new RadioAvailabilitySnapshot
            {
                IsAvailable = rejection == RadioCommunicationRejection.None,
                FailureReason = s_radioAvailabilityFailures[rejection]
            };
        }
    }
}
