using System;

namespace Application.Models
{
    /// <summary>Exposes preparation state and an action identifier only to its current participant.</summary>
    public sealed class PlayerMissionPreparationSnapshot
    {
        public Guid? AvailableObjectiveDraftSubmissionId { get; set; }

        public int MissionAttemptId { get; set; }

        public int MissionNumber { get; set; }

        public bool IsPreparationComplete { get; set; }

        public int CurrentObjectiveDraftPlayerUserId { get; set; }

        public MissionObjectiveSnapshot[] Objectives { get; set; }

        public MissionPreparationStage Stage { get; set; }
        public Guid MissionPreparationStageId { get; set; }
        public int[] EligibleRoleParticipantUserIds { get; set; }
        public bool CanRespondToBlindObjectives { get; set; }
        public BlindObjectiveParticipantSnapshot[] BlindObjectiveResponses { get; set; }
        public int? SilencedParticipantUserId { get; set; }
        public int? SoleObjectiveAssigneeUserId { get; set; }
        public int? SingleTrickWinnerParticipantUserId { get; set; }
        public int? FirstAndLastTrickWinnerParticipantUserId { get; set; }
        public int? FirstFourTricksWinnerParticipantUserId { get; set; }
        public int? LastTrickWinnerParticipantUserId { get; set; }
        public int? HeartNineOwnerParticipantUserId { get; set; }
        public int? RequiredHeartCaptureParticipantUserId { get; set; }
        public bool CanIdentifyHeartNineOwnership { get; set; }
    }
}
