using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies expected retry rejection without exposing server state.</summary>
    [DataContract]
    public enum MissionRetryRejectionReason
    {
        [EnumMember] None = 0,
        [EnumMember] MatchUnavailable = 1,
        [EnumMember] ParticipantNotAllowed = 2,
        [EnumMember] InvalidSubmission = 3,
        [EnumMember] SubmissionIdentityReused = 4,
        [EnumMember] WrongMissionAttempt = 5,
        [EnumMember] RetryUnavailable = 6,
        [EnumMember] StaleMatchState = 7,
        [EnumMember] SubmissionExpired = 8,
        [EnumMember] RequestLimitReached = 9,
        [EnumMember] AttemptLimitReached = 10
    }
}
