using System.Linq;
using Application.Models;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static partial class MatchSnapshotProjection
    {
        private static PlayerRadioCommunicationSnapshot[] CreateRadioCommunications(MatchState matchState)
        {
            return matchState.RadioCommunicationsByParticipantUserId.Values.Select(communication =>
                new PlayerRadioCommunicationSnapshot
                {
                    ParticipantUserId = communication.ParticipantUserId,
                    CommunicatedCardId = communication.Request.CardId,
                    Marker = MapPublicRadioMarker(communication.ResolvedPublicMarker),
                    HasCommunicatedCardBeenPlayed = !matchState.PlayerHandCardIdsBySeat[
                        System.Array.IndexOf(matchState.ParticipantUserIds, communication.ParticipantUserId)]
                        .Contains(communication.Request.CardId)
                }).ToArray();
        }

        private static RadioCommunicationMarker MapPublicRadioMarker(RadioPublicMarker marker)
        {
            return s_publicRadioMarkers[marker];
        }

        private static readonly System.Collections.Generic.IReadOnlyDictionary<RadioPublicMarker,
            RadioCommunicationMarker> s_publicRadioMarkers =
            new System.Collections.Generic.Dictionary<RadioPublicMarker, RadioCommunicationMarker>
            {
                { RadioPublicMarker.None, RadioCommunicationMarker.None },
                { RadioPublicMarker.Highest, RadioCommunicationMarker.Highest },
                { RadioPublicMarker.Only, RadioCommunicationMarker.Only },
                { RadioPublicMarker.Lowest, RadioCommunicationMarker.Lowest },
                { RadioPublicMarker.Hidden, RadioCommunicationMarker.Hidden }
            };

        private static RadioCommunicationMode GetRadioMode(MatchState matchState)
        {
            return MissionCatalog.GetMission(matchState.MissionAttempt.MissionNumber).CommunicationRule ==
                CommunicationRuleType.Interference ? RadioCommunicationMode.Interference
                    : RadioCommunicationMode.Standard;
        }
    }
}
