using System;
using System.Linq;
using Application.Models;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        /// <summary>Rejects obsolete manual confirmations; only the server scheduler can restart an attempt.</summary>
        public MissionRetryConfirmation ConfirmMissionRetry(MissionRetryRequest missionRetryRequest,
            int participantUserId)
        {
            var confirmation = new MissionRetryConfirmation
            {
                MissionRetrySubmissionId = missionRetryRequest?.MissionRetrySubmissionId ?? Guid.Empty,
                RejectionReason = MissionRetryRejectionReason.RetryUnavailable
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
