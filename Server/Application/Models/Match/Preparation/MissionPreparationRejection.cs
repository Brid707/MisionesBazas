namespace Application.Models
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    public enum MissionPreparationRejection
    {
        None = 0,
        InvalidSubmission = 1,
        MatchUnavailable = 2,
        ParticipantNotAllowed = 3,
        WrongMissionAttempt = 4,
        SubmissionIdentityReused = 5,
        StageMismatch = 6,
        StaleMatchState = 7,
        CaptainRequired = 8,
        InvalidTarget = 9,
        ResponsesPending = 10,
        AlreadyAnswered = 11,
        RequestLimitReached = 12,
        OperationUnavailable = 13
    }
}
