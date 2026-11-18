using System.Collections.Generic;
using Application.Models;
using Gameplay;

namespace Services.Mapping
{
    internal static class RadioCommunicationMapper
    {
        internal static RadioCommunicationRequest MapSubmission(RadioCommunicationSubmission submission)
        {
            s_markers.TryGetValue(submission.SelectedMarker, out RadioPublicMarker marker);
            return new RadioCommunicationRequest
            {
                LobbyCode = submission.LobbyCode,
                MatchId = submission.MatchId,
                MissionAttemptId = submission.MissionAttemptId,
                RadioCommunicationSubmissionId = submission.RadioCommunicationSubmissionId,
                ExpectedMatchStateVersion = submission.ExpectedMatchStateVersion,
                CardId = submission.CardId,
                SelectedMarker = marker
            };
        }

        internal static RadioCommunicationFailureReason MapRejection(RadioCommunicationRejection rejection)
        {
            return s_failures[rejection];
        }

        private static readonly IReadOnlyDictionary<RadioCommunicationMarker, RadioPublicMarker> s_markers =
            new Dictionary<RadioCommunicationMarker, RadioPublicMarker>
            {
                { RadioCommunicationMarker.None, RadioPublicMarker.None },
                { RadioCommunicationMarker.Highest, RadioPublicMarker.Highest },
                { RadioCommunicationMarker.Only, RadioPublicMarker.Only },
                { RadioCommunicationMarker.Lowest, RadioPublicMarker.Lowest },
                { RadioCommunicationMarker.Hidden, RadioPublicMarker.Hidden }
            };
        private static readonly IReadOnlyDictionary<RadioCommunicationRejection,
            RadioCommunicationFailureReason> s_failures =
            new Dictionary<RadioCommunicationRejection, RadioCommunicationFailureReason>
            {
                { RadioCommunicationRejection.None, RadioCommunicationFailureReason.None },
                { RadioCommunicationRejection.InvalidSubmission, RadioCommunicationFailureReason.InvalidSubmission },
                { RadioCommunicationRejection.MatchUnavailable, RadioCommunicationFailureReason.MatchUnavailable },
                { RadioCommunicationRejection.ParticipantNotAllowed,
                    RadioCommunicationFailureReason.ParticipantNotAllowed },
                { RadioCommunicationRejection.WrongMissionAttempt,
                    RadioCommunicationFailureReason.WrongMissionAttempt },
                { RadioCommunicationRejection.SubmissionIdentityReused,
                    RadioCommunicationFailureReason.SubmissionIdentityReused },
                { RadioCommunicationRejection.StaleMatchState, RadioCommunicationFailureReason.StaleMatchState },
                { RadioCommunicationRejection.MissionPreparationRequired,
                    RadioCommunicationFailureReason.MissionPreparationRequired },
                { RadioCommunicationRejection.MissionAttemptFinished,
                    RadioCommunicationFailureReason.MissionAttemptFinished },
                { RadioCommunicationRejection.CardNotInHand, RadioCommunicationFailureReason.CardNotInHand },
                { RadioCommunicationRejection.SpecialCardNotAllowed,
                    RadioCommunicationFailureReason.SpecialCardNotAllowed },
                { RadioCommunicationRejection.AlreadyCommunicatedThisAttempt,
                    RadioCommunicationFailureReason.AlreadyCommunicatedThisAttempt },
                { RadioCommunicationRejection.CannotCommunicateDuringActiveTrick,
                    RadioCommunicationFailureReason.CannotCommunicateDuringActiveTrick },
                { RadioCommunicationRejection.InvalidTokenPositionForCard,
                    RadioCommunicationFailureReason.InvalidTokenPositionForCard },
                { RadioCommunicationRejection.RequestLimitReached,
                    RadioCommunicationFailureReason.RequestLimitReached },
                { RadioCommunicationRejection.OperationUnavailable,
                    RadioCommunicationFailureReason.OperationUnavailable }
            };
    }
}
