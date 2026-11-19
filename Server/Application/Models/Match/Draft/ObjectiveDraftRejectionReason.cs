namespace Application.Models
{
    public enum ObjectiveDraftRejectionReason
    {
        None = 0,
        MatchUnavailable = 1,
        ParticipantNotAllowed = 2,
        InvalidSubmission = 3,
        SubmissionIdentityReused = 4,
        StaleMatchState = 5,
        NotDraftTurn = 6,
        ObjectiveUnavailable = 7,
        PreparationCompleted = 8,
        RequestLimitReached = 9,
        UnsupportedDraftMode = 10,
        SubmissionExpired = 11
    }
}
