using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies expected retry rejection without exposing server state.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
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
