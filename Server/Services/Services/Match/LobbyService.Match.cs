using System;
using System.ServiceModel;
using Gameplay;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        private const string MissionEvaluationUnavailableCode = "MissionEvaluationUnavailable";
        private const string MatchOperationUnavailableTemplate =
            "Match operation unavailable. FailureCode={FailureCode}, ExceptionType={ExceptionType}.";

        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            EnsureMatchParticipantAllowed(lobbyCode, participantUserId);
            LobbyMatchPresence.Touch(lobbyCode.Trim().ToUpperInvariant(), participantUserId,
                OperationContext.Current?.SessionId);
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
                throw CreateMatchOperationFault(ex, MissionEvaluationUnavailableCode);
            }
            catch (InvalidOperationException ex)
            {
                throw CreateMatchOperationFault(ex, MissionEvaluationUnavailableCode);
            }
            if (playDecision.IsAccepted)
            {
                BroadcastToRoom(cardPlaySubmission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(playDecision.CommittedMatchStateVersion));
            }
            return playDecision;
        }

        public DistressSignalDecision SubmitDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > 16)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                { FailureCode = FaultInvalidSubmission });
            }
            EnsureMatchParticipantAllowed(submission.LobbyCode, participantUserId);
            DistressSignalDecision decision = _lobbyUseCase.Match.SubmitDistressSignal(submission, participantUserId);
            if (decision.IsAccepted)
            {
                BroadcastToRoom(submission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(decision.CommittedMatchStateVersion));
            }
            return decision;
        }

        private FaultException<MatchAccessFault> CreateMatchOperationFault(Exception ex, string failureCode)
        {
            _logger.Error(MatchOperationUnavailableTemplate, failureCode, ex.GetType().Name);
            return new FaultException<MatchAccessFault>(new MatchAccessFault
            {
                FailureCode = failureCode
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
