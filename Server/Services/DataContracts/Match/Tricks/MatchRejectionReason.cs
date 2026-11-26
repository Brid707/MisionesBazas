using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies expected play rejections without exposing private state.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MatchRejectionReason
    {
        [EnumMember] None = 0,
        [EnumMember] MatchUnavailable = 1,
        [EnumMember] ParticipantNotAllowed = 2,
        [EnumMember] InvalidSubmission = 3,
        [EnumMember] SubmissionIdentityReused = 4,
        [EnumMember] StaleMatchState = 5,
        [EnumMember] NotPlayerTurn = 6,
        [EnumMember] CardNotInHand = 7,
        [EnumMember] MustFollowLeadSuit = 8,
        [EnumMember] DealCompleted = 9,
        [EnumMember] SubmissionCapacityReached = 10,
        [EnumMember] MissionPreparationRequired = 11,
        [EnumMember] MissionAttemptFinished = 12,
        [EnumMember] WrongMissionAttempt = 13
    }
}
