using System;
using System.Linq;
using Application.Models;
using Application.Ports;

namespace Application.UseCases
{
    internal sealed class MatchMissionRetryHandler
    {
        private readonly IMatchStateStore _matchStateStore;

        public MatchMissionRetryHandler(IMatchStateStore matchStateStore)
        {
            _matchStateStore = matchStateStore ?? throw new ArgumentNullException(nameof(matchStateStore));
        }

        /// <summary>Rejects obsolete manual confirmations; only the server scheduler can restart an attempt.</summary>
        public MissionRetryConfirmation ConfirmMissionRetry(MissionRetryRequest missionRetryRequest,
            int participantUserId)
        {
            var confirmation = new MissionRetryConfirmation
            {
                MissionRetrySubmissionId = missionRetryRequest?.MissionRetrySubmissionId ?? Guid.Empty,
                RejectionReason = Application.Models.MissionRetryRejectionReason.RetryUnavailable
            };
            if (missionRetryRequest != null && !string.IsNullOrWhiteSpace(missionRetryRequest.LobbyCode))
            {
                MatchState matchState = _matchStateStore.FindMatch(missionRetryRequest.LobbyCode);
                if (matchState != null && matchState.ParticipantUserIds.Contains(participantUserId) &&
                    missionRetryRequest.MatchId == matchState.MatchId)
                {
                    lock (matchState)
                    {
                        confirmation = confirmation with
                        {
                            CurrentMissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                            CommittedMatchStateVersion = matchState.MatchStateVersion
                        };
                    }
                }
            }
            return confirmation;
        }
    }
}
