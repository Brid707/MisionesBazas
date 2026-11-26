using System.Collections.Generic;
using Application.Models;
using Contract = Services.DataContracts;

namespace Services.Mapping
{
    internal static class RadioCommunicationMapper
    {
        internal static RadioCommunicationRequest MapSubmission(Contract.RadioCommunicationSubmission submission)
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

        internal static Contract.RadioCommunicationFailureReason MapRejection(RadioCommunicationRejection rejection)
        {
            return s_failures[rejection];
        }

        private static readonly IReadOnlyDictionary<Contract.RadioCommunicationMarker, RadioPublicMarker> s_markers =
            new Dictionary<Contract.RadioCommunicationMarker, RadioPublicMarker>
            {
                { Contract.RadioCommunicationMarker.None, RadioPublicMarker.None },
                { Contract.RadioCommunicationMarker.Highest, RadioPublicMarker.Highest },
                { Contract.RadioCommunicationMarker.Only, RadioPublicMarker.Only },
                { Contract.RadioCommunicationMarker.Lowest, RadioPublicMarker.Lowest },
                { Contract.RadioCommunicationMarker.Hidden, RadioPublicMarker.Hidden }
            };
        private static readonly IReadOnlyDictionary<RadioCommunicationRejection,
            Contract.RadioCommunicationFailureReason> s_failures =
            new Dictionary<RadioCommunicationRejection, Contract.RadioCommunicationFailureReason>
            {
                { RadioCommunicationRejection.DisruptedUntilTrick,
                    Contract.RadioCommunicationFailureReason.DisruptedUntilTrick },
                { RadioCommunicationRejection.SilencedByCaptain, Contract.RadioCommunicationFailureReason.SilencedByCaptain },
                { RadioCommunicationRejection.None, Contract.RadioCommunicationFailureReason.None },
                { RadioCommunicationRejection.InvalidSubmission, Contract.RadioCommunicationFailureReason.InvalidSubmission },
                { RadioCommunicationRejection.MatchUnavailable, Contract.RadioCommunicationFailureReason.MatchUnavailable },
                { RadioCommunicationRejection.ParticipantNotAllowed,
                    Contract.RadioCommunicationFailureReason.ParticipantNotAllowed },
                { RadioCommunicationRejection.WrongMissionAttempt,
                    Contract.RadioCommunicationFailureReason.WrongMissionAttempt },
                { RadioCommunicationRejection.SubmissionIdentityReused,
                    Contract.RadioCommunicationFailureReason.SubmissionIdentityReused },
                { RadioCommunicationRejection.StaleMatchState, Contract.RadioCommunicationFailureReason.StaleMatchState },
                { RadioCommunicationRejection.MissionPreparationRequired,
                    Contract.RadioCommunicationFailureReason.MissionPreparationRequired },
                { RadioCommunicationRejection.MissionAttemptFinished,
                    Contract.RadioCommunicationFailureReason.MissionAttemptFinished },
                { RadioCommunicationRejection.CardNotInHand, Contract.RadioCommunicationFailureReason.CardNotInHand },
                { RadioCommunicationRejection.SpecialCardNotAllowed,
                    Contract.RadioCommunicationFailureReason.SpecialCardNotAllowed },
                { RadioCommunicationRejection.AlreadyCommunicatedThisAttempt,
                    Contract.RadioCommunicationFailureReason.AlreadyCommunicatedThisAttempt },
                { RadioCommunicationRejection.CannotCommunicateDuringActiveTrick,
                    Contract.RadioCommunicationFailureReason.CannotCommunicateDuringActiveTrick },
                { RadioCommunicationRejection.InvalidTokenPositionForCard,
                    Contract.RadioCommunicationFailureReason.InvalidTokenPositionForCard },
                { RadioCommunicationRejection.RequestLimitReached,
                    Contract.RadioCommunicationFailureReason.RequestLimitReached },
                { RadioCommunicationRejection.OperationUnavailable,
                    Contract.RadioCommunicationFailureReason.OperationUnavailable }
            };
    }
}
