using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed class LobbyObjectiveDraftService
    {
        private const int MaximumMatchActionLobbyCodeLength = 16;
        private const string FaultInvalidSubmission = "InvalidSubmission";

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly Action<string, long> _broadcastMatchStateChanged;
        private readonly Action _ensureSessionBudget;
        private readonly Action<string, int> _ensureParticipantAllowed;

        public LobbyObjectiveDraftService(
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

        public MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId)
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

            ObjectiveDraftDecision decision = _lobbyUseCase.Match.ProcessObjectiveDraftAction(
                MissionObjectiveDraftMapper.MapSubmission(submission), participantUserId);

            if (decision.HasStateChanged)
            {
                _broadcastMatchStateChanged(submission.LobbyCode, decision.CommittedMatchStateVersion);
            }

            return MissionObjectiveDraftMapper.MapDecision(decision);
        }
    }
}
