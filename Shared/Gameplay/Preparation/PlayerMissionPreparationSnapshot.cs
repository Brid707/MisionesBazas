using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Exposes preparation state and an action identifier only to its current participant.</summary>
    [DataContract]
    public sealed class PlayerMissionPreparationSnapshot
    {
        [DataMember(Order = 6)]
        public Guid? AvailableObjectiveDraftSubmissionId { get; set; }

        [DataMember(Order = 1)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 2)]
        public int MissionNumber { get; set; }

        [DataMember(Order = 3)]
        public bool IsPreparationComplete { get; set; }

        [DataMember(Order = 4)]
        public int CurrentObjectiveDraftPlayerUserId { get; set; }

        [DataMember(Order = 5)]
        public MissionObjectiveSnapshot[] Objectives { get; set; }

        [DataMember(Order = 7)]
        public MissionPreparationStage Stage { get; set; }
        [DataMember(Order = 8)]
        public Guid MissionPreparationStageId { get; set; }
        [DataMember(Order = 9)]
        public int[] EligibleRoleParticipantUserIds { get; set; }
        [DataMember(Order = 10)]
        public bool CanRespondToBlindObjectives { get; set; }
        [DataMember(Order = 11)]
        public BlindObjectiveParticipantSnapshot[] BlindObjectiveResponses { get; set; }
        [DataMember(Order = 12)]
        public int? SilencedParticipantUserId { get; set; }
        [DataMember(Order = 13)]
        public int? SoleObjectiveAssigneeUserId { get; set; }
        [DataMember(Order = 14)]
        public int? SingleTrickWinnerParticipantUserId { get; set; }
        [DataMember(Order = 15)]
        public int? FirstAndLastTrickWinnerParticipantUserId { get; set; }
        [DataMember(Order = 16)]
        public int? FirstFourTricksWinnerParticipantUserId { get; set; }
        [DataMember(Order = 17)]
        public int? LastTrickWinnerParticipantUserId { get; set; }
        [DataMember(Order = 18)]
        public int? HeartNineOwnerParticipantUserId { get; set; }
        [DataMember(Order = 19)]
        public int? RequiredHeartCaptureParticipantUserId { get; set; }
        [DataMember(Order = 20)]
        public bool CanIdentifyHeartNineOwnership { get; set; }
    }
}
