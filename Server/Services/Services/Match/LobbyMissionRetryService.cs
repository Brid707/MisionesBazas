using System;
using System.Security.Cryptography;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed class LobbyMissionRetryService
    {
        private const int MaximumMatchActionLobbyCodeLength = 16;
        private const string FaultInvalidSubmission = "InvalidSubmission";
        private const string MissionRetryPreparationUnavailableCode = "MissionRetryPreparationUnavailable";

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly Action<string, long> _broadcastMatchStateChanged;
        private readonly Action _ensureSessionBudget;
        private readonly Action<string, int> _ensureParticipantAllowed;

        public LobbyMissionRetryService(
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

        public MissionRetryDecision ConfirmMissionRetry(MissionRetrySubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumMatchActionLobbyCodeLength)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = FaultInvalidSubmission
                });
            }

            _ensureSessionBudget();
            _ensureParticipantAllowed(submission.LobbyCode, participantUserId);

            MissionRetryConfirmation confirmation = ProcessMissionRetry(submission, participantUserId);
            if (confirmation.HasStateChanged)
            {
                _broadcastMatchStateChanged(submission.LobbyCode, confirmation.CommittedMatchStateVersion);
            }
            return MissionRetryMapper.MapDecision(confirmation);
        }

        private MissionRetryConfirmation ProcessMissionRetry(MissionRetrySubmission submission, int participantUserId)
        {
            MissionRetryConfirmation confirmation;
            try
            {
                confirmation = _lobbyUseCase.Match.ConfirmMissionRetry(
                    MissionRetryMapper.MapRequest(submission), participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = MissionRetryPreparationUnavailableCode
                }, new FaultReason(ex.Message));
            }
            catch (InvalidOperationException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = MissionRetryPreparationUnavailableCode
                }, new FaultReason(ex.Message));
            }
            catch (CryptographicException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = MissionRetryPreparationUnavailableCode
                }, new FaultReason(ex.Message));
            }
            return confirmation;
        }
    }
}
