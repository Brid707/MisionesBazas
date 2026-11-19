using System;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        public RadioCommunicationConfirmation SubmitRadioCommunication(RadioCommunicationSubmission submission,
            int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumMatchActionLobbyCodeLength ||
                !Enum.IsDefined(typeof(RadioCommunicationMarker), submission.SelectedMarker))
            {
                throw CreateRadioFault(RadioCommunicationFailureReason.InvalidSubmission);
            }
            EnsureMatchActionSessionBudget();
            EnsureMatchParticipantAllowed(submission.LobbyCode, participantUserId);
            RadioCommunicationCommit result = ExecuteRadioCommunication(submission, participantUserId);
            if (result.Rejection != RadioCommunicationRejection.None)
            {
                throw CreateRadioFault(RadioCommunicationMapper.MapRejection(result.Rejection));
            }
            if (result.HasStateChanged)
            {
                BroadcastToRoom(submission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(result.CommittedMatchStateVersion));
            }
            return new RadioCommunicationConfirmation
            {
                RadioCommunicationSubmissionId = result.RadioCommunicationSubmissionId,
                CommittedMatchStateVersion = result.CommittedMatchStateVersion
            };
        }

        private RadioCommunicationCommit ExecuteRadioCommunication(RadioCommunicationSubmission submission,
            int participantUserId)
        {
            RadioCommunicationCommit result;
            try
            {
                result = _lobbyUseCase.Match.SubmitRadioCommunication(
                    RadioCommunicationMapper.MapSubmission(submission), participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw CreateMatchOperationFault(ex, nameof(RadioCommunicationFailureReason.OperationUnavailable));
            }
            catch (InvalidOperationException ex)
            {
                throw CreateMatchOperationFault(ex, nameof(RadioCommunicationFailureReason.OperationUnavailable));
            }
            return result;
        }

        private static FaultException<RadioCommunicationFault> CreateRadioFault(RadioCommunicationFailureReason reason)
        {
            return new FaultException<RadioCommunicationFault>(new RadioCommunicationFault { FailureReason = reason });
        }
    }
}
