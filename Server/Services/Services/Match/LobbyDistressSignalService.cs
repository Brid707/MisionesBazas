using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.DataContracts;
using Services.Mapping;
using ContractActionType = Services.DataContracts.DistressSignalActionType;
using ContractPassDirection = Services.DataContracts.DistressPassDirection;

namespace Services.Services
{
    public sealed class LobbyDistressSignalService
    {
        private const int MaximumMatchActionLobbyCodeLength = 16;
        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly Action<string, long> _broadcastMatchStateChanged;
        private readonly Action _ensureSessionBudget;
        private readonly Action<string, int> _ensureParticipantAllowed;

        public LobbyDistressSignalService(
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

        public DistressSignalConfirmation SubmitDistressSignal(DistressSignalSubmission submission, int participantUserId)
        {
            if (!IsSubmissionValid(submission))
            {
                throw CreateDistressFault(DistressSignalFailureReason.InvalidSubmission);
            }

            _ensureSessionBudget();
            _ensureParticipantAllowed(submission.LobbyCode, participantUserId);

            DistressSignalCommit signalCommit = ExecuteDistressSignal(submission, participantUserId);

            if (signalCommit.Rejection != DistressSignalRejection.None)
            {
                throw CreateDistressFault(DistressSignalMapper.MapRejection(signalCommit.Rejection));
            }

            if (signalCommit.HasStateChanged)
            {
                _broadcastMatchStateChanged(submission.LobbyCode, signalCommit.CommittedMatchStateVersion);
            }

            return new DistressSignalConfirmation
            {
                IsExecuted = signalCommit.IsExecuted,
                CommittedMatchStateVersion = signalCommit.CommittedMatchStateVersion
            };
        }

        private DistressSignalCommit ExecuteDistressSignal(DistressSignalSubmission submission, int participantUserId)
        {
            DistressSignalCommit signalCommit;
            try
            {
                signalCommit = _lobbyUseCase.Match.SubmitDistressSignal(
                    DistressSignalMapper.MapSubmission(submission), participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = nameof(DistressSignalFailureReason.OperationUnavailable)
                }, new FaultReason(ex.Message));
            }
            catch (InvalidOperationException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = nameof(DistressSignalFailureReason.OperationUnavailable)
                }, new FaultReason(ex.Message));
            }

            return signalCommit;
        }

        private static bool IsSubmissionValid(DistressSignalSubmission submission)
        {
            return submission is not null
                && !string.IsNullOrWhiteSpace(submission.LobbyCode)
                && submission.LobbyCode.Length <= MaximumMatchActionLobbyCodeLength
                && Enum.IsDefined(typeof(ContractActionType), submission.ActionType)
                && submission.ActionType != ContractActionType.None
                && Enum.IsDefined(typeof(ContractPassDirection), submission.SelectedDirection);
        }

        private static FaultException<DistressSignalFault> CreateDistressFault(DistressSignalFailureReason reason)
        {
            return new FaultException<DistressSignalFault>(new DistressSignalFault { FailureReason = reason });
        }
    }
}
