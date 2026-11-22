using System;
using System.ServiceModel;
using Application.Ports;
using Gameplay;

namespace Services.Services
{
    public sealed class LobbyMatchGameplayService
    {
        private const string FaultMatchUnavailable = "MatchUnavailable";
        private const string FaultInvalidSubmission = "InvalidSubmission";
        private const string MissionEvaluationUnavailableCode = "MissionEvaluationUnavailable";

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly Action<string, long> _broadcastMatchStateChanged;
        private readonly Action<string, int> _ensureParticipantAllowed;

        public LobbyMatchGameplayService(
            ILobbyUseCase lobbyUseCase,
            Action<string, long> broadcastMatchStateChanged,
            Action<string, int> ensureParticipantAllowed)
        {
            _lobbyUseCase = lobbyUseCase ?? throw new ArgumentNullException(nameof(lobbyUseCase));
            _broadcastMatchStateChanged = broadcastMatchStateChanged ?? throw new ArgumentNullException(nameof(broadcastMatchStateChanged));
            _ensureParticipantAllowed = ensureParticipantAllowed ?? throw new ArgumentNullException(nameof(ensureParticipantAllowed));
        }

        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            _ensureParticipantAllowed(lobbyCode, participantUserId);
            LobbyMatchPresence.Touch(lobbyCode.Trim().ToUpperInvariant(), participantUserId,
                OperationContext.Current?.SessionId);
            PlayerMatchSnapshot participantSnapshot = _lobbyUseCase.Match.GetPlayerMatch(lobbyCode, participantUserId);
            if (participantSnapshot == null)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = FaultMatchUnavailable
                });
            }
            return participantSnapshot;
        }

        public CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            if (cardPlaySubmission == null || string.IsNullOrWhiteSpace(cardPlaySubmission.LobbyCode) ||
                cardPlaySubmission.LobbyCode.Length > 16)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = FaultInvalidSubmission
                });
            }

            _ensureParticipantAllowed(cardPlaySubmission.LobbyCode, participantUserId);

            CardPlayDecision playDecision;
            try
            {
                playDecision = _lobbyUseCase.Match.PlayCard(cardPlaySubmission, participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = MissionEvaluationUnavailableCode
                }, new FaultReason(ex.Message));
            }
            catch (InvalidOperationException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = MissionEvaluationUnavailableCode
                }, new FaultReason(ex.Message));
            }

            if (playDecision.IsAccepted)
            {
                _broadcastMatchStateChanged(cardPlaySubmission.LobbyCode, playDecision.CommittedMatchStateVersion);
            }

            return playDecision;
        }
    }
}
