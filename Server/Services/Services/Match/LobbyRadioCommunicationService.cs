using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.DataContracts;
using Services.Mapping;
using ContractRadioFailure = Services.DataContracts.RadioCommunicationFailureReason;
using ContractRadioMarker = Services.DataContracts.RadioCommunicationMarker;

namespace Services.Services
{
    public sealed class LobbyRadioCommunicationService
    {
        private const int MaximumMatchActionLobbyCodeLength = 16;

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly Action<string, long> _broadcastMatchStateChanged;
        private readonly Action _ensureSessionBudget;
        private readonly Action<string, int> _ensureParticipantAllowed;

        public LobbyRadioCommunicationService(
            ILobbyUseCase lobbyUseCase,
            Action<string, long> broadcastMatchStateChanged,
            Action ensureSessionBudget,
            Action<string, int> ensureParticipantAllowed)
        {
            _lobbyUseCase = lobbyUseCase ?? throw new ArgumentNullException(nameof(lobbyUseCase));
            _broadcastMatchStateChanged = broadcastMatchStateChanged ?? throw new ArgumentNullException(nameof(broadcastMatchStateChanged));
            _ensureSessionBudget = ensureSessionBudget ?? throw new ArgumentNullException(nameof(ensureSessionBudget));
            _ensureParticipantAllowed = ensureParticipantAllowed ?? throw new ArgumentNullException(nameof(ensureParticipantAllowed));
        }

        public RadioCommunicationConfirmation SubmitRadioCommunication(RadioCommunicationSubmission submission,
            int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumMatchActionLobbyCodeLength ||
                !Enum.IsDefined(typeof(ContractRadioMarker), submission.SelectedMarker))
            {
                throw CreateRadioFault(ContractRadioFailure.InvalidSubmission);
            }

            _ensureSessionBudget();
            _ensureParticipantAllowed(submission.LobbyCode, participantUserId);

            RadioCommunicationCommit result = ExecuteRadioCommunication(submission, participantUserId);
            if (result.Rejection != RadioCommunicationRejection.None)
            {
                throw CreateRadioFault(RadioCommunicationMapper.MapRejection(result.Rejection));
            }

            if (result.HasStateChanged)
            {
                _broadcastMatchStateChanged(submission.LobbyCode, result.CommittedMatchStateVersion);
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
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = nameof(ContractRadioFailure.OperationUnavailable)
                }, new FaultReason(ex.Message));
            }
            catch (InvalidOperationException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = nameof(ContractRadioFailure.OperationUnavailable)
                }, new FaultReason(ex.Message));
            }
            return result;
        }

        private static FaultException<RadioCommunicationFault> CreateRadioFault(ContractRadioFailure reason)
        {
            return new FaultException<RadioCommunicationFault>(new RadioCommunicationFault { FailureReason = reason });
        }
    }
}
