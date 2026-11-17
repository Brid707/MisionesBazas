using System;
using System.ServiceModel;
using Gameplay;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            EnsureMatchParticipantAllowed(lobbyCode, participantUserId);
            PlayerMatchSnapshot participantSnapshot = _lobbyUseCase.Match.GetPlayerMatch(lobbyCode, participantUserId);
            if (participantSnapshot == null)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault { FailureCode = "MatchUnavailable" });
            }
            return participantSnapshot;
        }

        public CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            if (cardPlaySubmission == null || string.IsNullOrWhiteSpace(cardPlaySubmission.LobbyCode) ||
                cardPlaySubmission.LobbyCode.Length > 16)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault { FailureCode = "InvalidSubmission" });
            }
            EnsureMatchParticipantAllowed(cardPlaySubmission.LobbyCode, participantUserId);
            CardPlayDecision playDecision = _lobbyUseCase.Match.PlayCard(cardPlaySubmission, participantUserId);
            if (playDecision.IsAccepted)
            {
                BroadcastToRoom(cardPlaySubmission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(playDecision.CommittedMatchStateVersion));
            }
            return playDecision;
        }
        private void EnsureMatchParticipantAllowed(string lobbyCode, int participantUserId)
        {
            try
            {
                EnsureParticipantOperationAllowed(participantUserId);
                EnsureRegisteredRoomChannel(lobbyCode, participantUserId);
            }
            catch (FaultException ex)
            {
                LogMatchFailure("Match access rejected", ex);
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = "ParticipantNotAllowed"
                });
            }
        }
        private void LogMatchFailure(string failureDescription, Exception ex)
        {
            _logger.Error(ex, "{FailureDescription}", failureDescription);
        }
    }
}
