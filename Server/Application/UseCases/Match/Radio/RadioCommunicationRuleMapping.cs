using System.Collections.Generic;
using Application.Models;
using TrickTakingMissions.Rules.Enums;

namespace Application.UseCases
{
    internal static class RadioCommunicationRuleMapping
    {
        private static readonly IReadOnlyDictionary<RadioPublicMarker, RadioTokenPosition> s_positions =
            new Dictionary<RadioPublicMarker, RadioTokenPosition>
            {
                { RadioPublicMarker.None, RadioTokenPosition.None },
                { RadioPublicMarker.Highest, RadioTokenPosition.Highest },
                { RadioPublicMarker.Only, RadioTokenPosition.Only },
                { RadioPublicMarker.Lowest, RadioTokenPosition.Lowest },
                { RadioPublicMarker.Hidden, RadioTokenPosition.Interference }
            };

        internal static RadioTokenPosition MapRequestedMarker(RadioPublicMarker marker) => s_positions[marker];

        internal static RadioPublicMarker MapResolvedMarker(RadioTokenPosition position)
        {
            RadioPublicMarker marker = RadioPublicMarker.None;
            foreach (KeyValuePair<RadioPublicMarker, RadioTokenPosition> entry in s_positions)
            {
                if (entry.Value == position)
                {
                    marker = entry.Key;
                }
            }
            return marker;
        }

        internal static RadioCommunicationRejection MapRejection(RadioCommunicationRejectionReason reason)
        {
            return s_rejections[reason];
        }

        private static readonly IReadOnlyDictionary<RadioCommunicationRejectionReason,
            RadioCommunicationRejection> s_rejections =
            new Dictionary<RadioCommunicationRejectionReason, RadioCommunicationRejection>
            {
                { RadioCommunicationRejectionReason.DisruptedUntilTrick,
                    RadioCommunicationRejection.DisruptedUntilTrick },
                { RadioCommunicationRejectionReason.SilencedByCaptain,
                    RadioCommunicationRejection.SilencedByCaptain },
                { RadioCommunicationRejectionReason.None, RadioCommunicationRejection.None },
                { RadioCommunicationRejectionReason.CardNotInHand, RadioCommunicationRejection.CardNotInHand },
                { RadioCommunicationRejectionReason.SpecialCardNotAllowed,
                    RadioCommunicationRejection.SpecialCardNotAllowed },
                { RadioCommunicationRejectionReason.AlreadyCommunicatedThisAttempt,
                    RadioCommunicationRejection.AlreadyCommunicatedThisAttempt },
                { RadioCommunicationRejectionReason.CannotCommunicateDuringActiveTrick,
                    RadioCommunicationRejection.CannotCommunicateDuringActiveTrick },
                { RadioCommunicationRejectionReason.InvalidTokenPositionForCard,
                    RadioCommunicationRejection.InvalidTokenPositionForCard }
            };
    }
}
