using System;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        private const int MaximumMatchActionLobbyCodeLength = 16;
        private const int MaximumMatchActionMessagesPerSecond = 8;
        private readonly object _matchActionRequestGate = new object();
        private MatchActionRequestBudget _matchActionSessionBudget;

        public MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumMatchActionLobbyCodeLength)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                { FailureCode = FaultInvalidSubmission });
            }
            EnsureMatchActionSessionBudget();
            EnsureMatchParticipantAllowed(submission.LobbyCode, participantUserId);
            ObjectiveDraftDecision decision = _lobbyUseCase.Match.ProcessObjectiveDraftAction(
                MissionObjectiveDraftMapper.MapSubmission(submission), participantUserId);
            if (decision.HasStateChanged)
            {
                BroadcastToRoom(submission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(decision.CommittedMatchStateVersion));
            }
            return MissionObjectiveDraftMapper.MapDecision(decision);
        }

        private void EnsureMatchActionSessionBudget()
        {
            lock (_matchActionRequestGate)
            {
                MatchActionRequestBudget requestBudget = MatchActionRequestLimits.ConsumeWindow(
                    _matchActionSessionBudget, MaximumMatchActionMessagesPerSecond);
                if (requestBudget == null)
                {
                    throw new FaultException<MatchAccessFault>(new MatchAccessFault
                    {
                        FailureCode = nameof(MissionObjectiveDraftRejectionReason.RequestLimitReached)
                    });
                }
                _matchActionSessionBudget = requestBudget;
            }
        }
    }
}
