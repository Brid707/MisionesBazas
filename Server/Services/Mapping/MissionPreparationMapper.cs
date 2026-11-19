using System.Collections.Generic;
using Application.Models;
using Gameplay;
using TrickTakingMissions.Rules.Enums;

namespace Services.Mapping
{
    internal static class MissionPreparationMapper
    {
        internal static MissionPreparationRequest MapSubmission(MissionRoleAssignmentSubmission submission)
        {
            return new MissionPreparationRequest
            {
                LobbyCode = submission.LobbyCode,
                MatchId = submission.MatchId,
                MissionAttemptId = submission.MissionAttemptId,
                MissionPreparationStageId = submission.MissionPreparationStageId,
                MissionPreparationSubmissionId = submission.MissionPreparationSubmissionId,
                ExpectedMatchStateVersion = submission.ExpectedMatchStateVersion,
                Action = MissionPreparationAction.AssignRole,
                SelectedParticipantUserId = submission.SelectedParticipantUserId
            };
        }

        internal static MissionPreparationRequest MapSubmission(BlindObjectiveResponseSubmission submission)
        {
            return new MissionPreparationRequest
            {
                LobbyCode = submission.LobbyCode,
                MatchId = submission.MatchId,
                MissionAttemptId = submission.MissionAttemptId,
                MissionPreparationStageId = submission.MissionPreparationStageId,
                MissionPreparationSubmissionId = submission.MissionPreparationSubmissionId,
                ExpectedMatchStateVersion = submission.ExpectedMatchStateVersion,
                Action = MissionPreparationAction.RecordBlindResponse,
                Response = submission.Response == BlindObjectiveResponse.Yes
                    ? BlindObjectiveCapableResponse.Yes : BlindObjectiveCapableResponse.No
            };
        }

        internal static MissionPreparationFailureReason MapRejection(MissionPreparationRejection rejection)
        {
            return s_failures[rejection];
        }

        private static readonly IReadOnlyDictionary<MissionPreparationRejection, MissionPreparationFailureReason>
            s_failures = new Dictionary<MissionPreparationRejection, MissionPreparationFailureReason>
            {
                { MissionPreparationRejection.None, MissionPreparationFailureReason.None },
                { MissionPreparationRejection.InvalidSubmission, MissionPreparationFailureReason.InvalidSubmission },
                { MissionPreparationRejection.MatchUnavailable, MissionPreparationFailureReason.MatchUnavailable },
                { MissionPreparationRejection.ParticipantNotAllowed,
                    MissionPreparationFailureReason.ParticipantNotAllowed },
                { MissionPreparationRejection.WrongMissionAttempt,
                    MissionPreparationFailureReason.WrongMissionAttempt },
                { MissionPreparationRejection.SubmissionIdentityReused,
                    MissionPreparationFailureReason.SubmissionIdentityReused },
                { MissionPreparationRejection.StageMismatch, MissionPreparationFailureReason.StageMismatch },
                { MissionPreparationRejection.StaleMatchState, MissionPreparationFailureReason.StaleMatchState },
                { MissionPreparationRejection.CaptainRequired, MissionPreparationFailureReason.CaptainRequired },
                { MissionPreparationRejection.InvalidTarget, MissionPreparationFailureReason.InvalidTarget },
                { MissionPreparationRejection.ResponsesPending, MissionPreparationFailureReason.ResponsesPending },
                { MissionPreparationRejection.AlreadyAnswered, MissionPreparationFailureReason.AlreadyAnswered },
                { MissionPreparationRejection.RequestLimitReached,
                    MissionPreparationFailureReason.RequestLimitReached },
                { MissionPreparationRejection.OperationUnavailable,
                    MissionPreparationFailureReason.OperationUnavailable },
            };
    }
}
