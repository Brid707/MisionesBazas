using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    [DataContract]
    public enum MissionPreparationFailureReason
    {
        [EnumMember] None = 0,
        [EnumMember] InvalidSubmission = 1,
        [EnumMember] MatchUnavailable = 2,
        [EnumMember] ParticipantNotAllowed = 3,
        [EnumMember] WrongMissionAttempt = 4,
        [EnumMember] SubmissionIdentityReused = 5,
        [EnumMember] StageMismatch = 6,
        [EnumMember] StaleMatchState = 7,
        [EnumMember] CaptainRequired = 8,
        [EnumMember] InvalidTarget = 9,
        [EnumMember] ResponsesPending = 10,
        [EnumMember] AlreadyAnswered = 11,
        [EnumMember] RequestLimitReached = 12,
        [EnumMember] OperationUnavailable = 13
    }
}
