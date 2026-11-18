using System;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        private const int MaximumObjectiveDraftLobbyCodeLength = 16;
        private const int MaximumObjectiveDraftMessagesPerSecond = 8;
        private readonly object _objectiveDraftRequestGate = new object();
        private ObjectiveDraftRequestBudget _objectiveDraftSessionBudget;

        public MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumObjectiveDraftLobbyCodeLength)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                { FailureCode = FaultInvalidSubmission });
            }
            EnsureObjectiveDraftSessionBudget();
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

        private void EnsureObjectiveDraftSessionBudget()
        {
            lock (_objectiveDraftRequestGate)
            {
                ObjectiveDraftRequestBudget requestBudget = ObjectiveDraftRequestLimits.ConsumeWindow(
                    _objectiveDraftSessionBudget, MaximumObjectiveDraftMessagesPerSecond);
                if (requestBudget == null)
                {
                    throw new FaultException<MatchAccessFault>(new MatchAccessFault
                    {
                        FailureCode = nameof(MissionObjectiveDraftRejectionReason.RequestLimitReached)
                    });
                }
                _objectiveDraftSessionBudget = requestBudget;
            }
        }
    }
}
