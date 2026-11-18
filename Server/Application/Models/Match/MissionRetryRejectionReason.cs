namespace Application.Models
{
    /// <summary>Identifies expected mission retry rejections.</summary>
    public enum MissionRetryRejectionReason
    {
        None = 0,
        MatchUnavailable = 1,
        ParticipantNotAllowed = 2,
        InvalidSubmission = 3,
        SubmissionIdentityReused = 4,
        WrongMissionAttempt = 5,
        RetryUnavailable = 6,
        StaleMatchState = 7,
        SubmissionExpired = 8,
        RequestLimitReached = 9,
        AttemptLimitReached = 10
    }
}
