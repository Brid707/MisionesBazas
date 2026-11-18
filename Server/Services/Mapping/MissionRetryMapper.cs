using System.Collections.Generic;
using Application.Models;
using Gameplay;
using RetryRejection = Application.Models.MissionRetryRejectionReason;

namespace Services.Mapping
{
    /// <summary>Translates retry requests and decisions without publishing the core transition marker.</summary>
    internal static class MissionRetryMapper
    {
        private static readonly IReadOnlyDictionary<RetryRejection, Gameplay.MissionRetryRejectionReason>
            s_rejectionReasons = new Dictionary<RetryRejection, Gameplay.MissionRetryRejectionReason>
            {
                { RetryRejection.None, Gameplay.MissionRetryRejectionReason.None },
                { RetryRejection.MatchUnavailable, Gameplay.MissionRetryRejectionReason.MatchUnavailable },
                { RetryRejection.ParticipantNotAllowed, Gameplay.MissionRetryRejectionReason.ParticipantNotAllowed },
                { RetryRejection.InvalidSubmission, Gameplay.MissionRetryRejectionReason.InvalidSubmission },
                { RetryRejection.SubmissionIdentityReused,
                    Gameplay.MissionRetryRejectionReason.SubmissionIdentityReused },
                { RetryRejection.WrongMissionAttempt, Gameplay.MissionRetryRejectionReason.WrongMissionAttempt },
                { RetryRejection.RetryUnavailable, Gameplay.MissionRetryRejectionReason.RetryUnavailable },
                { RetryRejection.StaleMatchState, Gameplay.MissionRetryRejectionReason.StaleMatchState },
                { RetryRejection.SubmissionExpired, Gameplay.MissionRetryRejectionReason.SubmissionExpired },
                { RetryRejection.RequestLimitReached, Gameplay.MissionRetryRejectionReason.RequestLimitReached },
                { RetryRejection.AttemptLimitReached, Gameplay.MissionRetryRejectionReason.AttemptLimitReached }
            };

        internal static MissionRetryRequest MapRequest(MissionRetrySubmission submission)
        {
            return new MissionRetryRequest
            {
                LobbyCode = submission.LobbyCode,
                MatchId = submission.MatchId,
                MissionAttemptId = submission.MissionAttemptId,
                MissionRetrySubmissionId = submission.MissionRetrySubmissionId,
                ExpectedMatchStateVersion = submission.ExpectedMatchStateVersion
            };
        }

        internal static MissionRetryDecision MapDecision(MissionRetryConfirmation confirmation)
        {
            return new MissionRetryDecision
            {
                MissionRetrySubmissionId = confirmation.MissionRetrySubmissionId,
                IsAccepted = confirmation.IsAccepted,
                HasRestartedMission = confirmation.HasRestartedMission,
                CommittedMatchStateVersion = confirmation.CommittedMatchStateVersion,
                CurrentMissionAttemptId = confirmation.CurrentMissionAttemptId,
                RejectionReason = s_rejectionReasons[confirmation.RejectionReason]
            };
        }
    }
}
