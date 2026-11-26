using System.Collections.Generic;
using Application.Models;
using Contract = Services.DataContracts;
using RetryRejection = Application.Models.MissionRetryRejectionReason;

namespace Services.Mapping
{
    /// <summary>Translates retry requests and decisions without publishing the core transition marker.</summary>
    internal static class MissionRetryMapper
    {
        private static readonly IReadOnlyDictionary<RetryRejection, Contract.MissionRetryRejectionReason>
            s_rejectionReasons = new Dictionary<RetryRejection, Contract.MissionRetryRejectionReason>
            {
                { RetryRejection.None, Contract.MissionRetryRejectionReason.None },
                { RetryRejection.MatchUnavailable, Contract.MissionRetryRejectionReason.MatchUnavailable },
                { RetryRejection.ParticipantNotAllowed, Contract.MissionRetryRejectionReason.ParticipantNotAllowed },
                { RetryRejection.InvalidSubmission, Contract.MissionRetryRejectionReason.InvalidSubmission },
                { RetryRejection.SubmissionIdentityReused,
                    Contract.MissionRetryRejectionReason.SubmissionIdentityReused },
                { RetryRejection.WrongMissionAttempt, Contract.MissionRetryRejectionReason.WrongMissionAttempt },
                { RetryRejection.RetryUnavailable, Contract.MissionRetryRejectionReason.RetryUnavailable },
                { RetryRejection.StaleMatchState, Contract.MissionRetryRejectionReason.StaleMatchState },
                { RetryRejection.SubmissionExpired, Contract.MissionRetryRejectionReason.SubmissionExpired },
                { RetryRejection.RequestLimitReached, Contract.MissionRetryRejectionReason.RequestLimitReached },
                { RetryRejection.AttemptLimitReached, Contract.MissionRetryRejectionReason.AttemptLimitReached }
            };

        internal static MissionRetryRequest MapRequest(Contract.MissionRetrySubmission submission)
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

        internal static Contract.MissionRetryDecision MapDecision(MissionRetryConfirmation confirmation)
        {
            return new Contract.MissionRetryDecision
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
