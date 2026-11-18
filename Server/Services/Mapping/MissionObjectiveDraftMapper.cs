using System.Collections.Generic;
using Application.Models;
using Gameplay;

namespace Services.Mapping
{
    internal static class MissionObjectiveDraftMapper
    {
        private static readonly IReadOnlyDictionary<MissionObjectiveDraftAction, ObjectiveDraftAction> s_actions =
            new Dictionary<MissionObjectiveDraftAction, ObjectiveDraftAction>
            {
                { MissionObjectiveDraftAction.SelectObjective, ObjectiveDraftAction.SelectObjective },
                { MissionObjectiveDraftAction.Pass, ObjectiveDraftAction.Pass }
            };
        private static readonly IReadOnlyDictionary<ObjectiveDraftRejectionReason,
            MissionObjectiveDraftRejectionReason> s_rejections =
            new Dictionary<ObjectiveDraftRejectionReason, MissionObjectiveDraftRejectionReason>
            {
                { ObjectiveDraftRejectionReason.None,
                    MissionObjectiveDraftRejectionReason.None },
                { ObjectiveDraftRejectionReason.MatchUnavailable,
                    MissionObjectiveDraftRejectionReason.MatchUnavailable },
                { ObjectiveDraftRejectionReason.ParticipantNotAllowed,
                    MissionObjectiveDraftRejectionReason.ParticipantNotAllowed },
                { ObjectiveDraftRejectionReason.InvalidSubmission,
                    MissionObjectiveDraftRejectionReason.InvalidSubmission },
                { ObjectiveDraftRejectionReason.SubmissionIdentityReused,
                    MissionObjectiveDraftRejectionReason.SubmissionIdentityReused },
                { ObjectiveDraftRejectionReason.StaleMatchState,
                    MissionObjectiveDraftRejectionReason.StaleMatchState },
                { ObjectiveDraftRejectionReason.NotDraftTurn,
                    MissionObjectiveDraftRejectionReason.NotDraftTurn },
                { ObjectiveDraftRejectionReason.ObjectiveUnavailable,
                    MissionObjectiveDraftRejectionReason.ObjectiveUnavailable },
                { ObjectiveDraftRejectionReason.PreparationCompleted,
                    MissionObjectiveDraftRejectionReason.PreparationCompleted },
                { ObjectiveDraftRejectionReason.RequestLimitReached,
                    MissionObjectiveDraftRejectionReason.RequestLimitReached },
                { ObjectiveDraftRejectionReason.UnsupportedDraftMode,
                    MissionObjectiveDraftRejectionReason.UnsupportedDraftMode },
                { ObjectiveDraftRejectionReason.SubmissionExpired,
                    MissionObjectiveDraftRejectionReason.SubmissionExpired }
            };

        internal static ObjectiveDraftSubmission MapSubmission(MissionObjectiveDraftSubmission submission)
        {
            s_actions.TryGetValue(submission.ObjectiveDraftAction, out ObjectiveDraftAction action);
            return new ObjectiveDraftSubmission
            {
                LobbyCode = submission.LobbyCode,
                MatchId = submission.MatchId,
                MissionAttemptId = submission.MissionAttemptId,
                ObjectiveDraftSubmissionId = submission.ObjectiveDraftSubmissionId,
                ExpectedMatchStateVersion = submission.ExpectedMatchStateVersion,
                ObjectiveDraftAction = action,
                SelectedMissionObjectiveId = submission.SelectedMissionObjectiveId
            };
        }

        internal static MissionObjectiveDraftDecision MapDecision(ObjectiveDraftDecision decision)
        {
            bool hasKnownRejection = s_rejections.TryGetValue(decision.RejectionReason,
                out MissionObjectiveDraftRejectionReason rejection);
            if (!hasKnownRejection)
            {
                rejection = MissionObjectiveDraftRejectionReason.InvalidSubmission;
            }
            bool isAccepted = hasKnownRejection && decision.IsAccepted &&
                decision.RejectionReason == ObjectiveDraftRejectionReason.None;
            return new MissionObjectiveDraftDecision
            {
                ObjectiveDraftSubmissionId = decision.ObjectiveDraftSubmissionId,
                IsAccepted = isAccepted,
                RejectionReason = rejection,
                CommittedMatchStateVersion = decision.CommittedMatchStateVersion,
                HasCompletedSelectionFreeCycle = isAccepted && decision.HasCompletedSelectionFreeCycle
            };
        }
    }
}
