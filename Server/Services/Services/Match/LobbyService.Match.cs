using System;
using System.ServiceModel;
using Gameplay;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        private const string MissionEvaluationUnavailableCode = "MissionEvaluationUnavailable";
        private const string MissionEvaluationUnavailableTemplate =
            "Mission evaluation unavailable. ExceptionType={ExceptionType}.";

        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            EnsureMatchParticipantAllowed(lobbyCode, participantUserId);
            PlayerMatchSnapshot participantSnapshot = _lobbyUseCase.Match.GetPlayerMatch(lobbyCode, participantUserId);
            if (participantSnapshot == null)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                { FailureCode = FaultMatchUnavailable });
            }
            return participantSnapshot;
        }

        public CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            if (cardPlaySubmission == null || string.IsNullOrWhiteSpace(cardPlaySubmission.LobbyCode) ||
                cardPlaySubmission.LobbyCode.Length > 16)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                { FailureCode = FaultInvalidSubmission });
            }
            EnsureMatchParticipantAllowed(cardPlaySubmission.LobbyCode, participantUserId);
            CardPlayDecision playDecision;
            try
            {
                playDecision = _lobbyUseCase.Match.PlayCard(cardPlaySubmission, participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw CreateMissionEvaluationFault(ex);
            }
            catch (InvalidOperationException ex)
            {
                throw CreateMissionEvaluationFault(ex);
            }
            if (playDecision.IsAccepted)
            {
                BroadcastToRoom(cardPlaySubmission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(playDecision.CommittedMatchStateVersion));
            }
            return playDecision;
        }

        private FaultException<MatchAccessFault> CreateMissionEvaluationFault(Exception ex)
        {
            _logger.Error(MissionEvaluationUnavailableTemplate, ex.GetType().Name);
            return new FaultException<MatchAccessFault>(new MatchAccessFault
            {
                FailureCode = MissionEvaluationUnavailableCode
            });
        }

        private void EnsureMatchParticipantAllowed(string lobbyCode, int participantUserId)
        {
            try
            {
                EnsureParticipantOperationAllowed(participantUserId);
                EnsureRegisteredRoomChannel(lobbyCode, participantUserId);
            }
            catch (FaultException)
            {
                _logger.Warning(MatchAccessRejectedTemplate, participantUserId, lobbyCode);
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = FaultParticipantNotAllowed
                });
            }
        }
    }
}
