namespace Application.Models
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    public enum RadioCommunicationRejection
    {
        None = 0,
        InvalidSubmission = 1,
        MatchUnavailable = 2,
        ParticipantNotAllowed = 3,
        WrongMissionAttempt = 4,
        SubmissionIdentityReused = 5,
        StaleMatchState = 6,
        MissionPreparationRequired = 7,
        MissionAttemptFinished = 8,
        CardNotInHand = 9,
        SpecialCardNotAllowed = 10,
        AlreadyCommunicatedThisAttempt = 11,
        CannotCommunicateDuringActiveTrick = 12,
        InvalidTokenPositionForCard = 13,
        RequestLimitReached = 14,
        OperationUnavailable = 15,
        DisruptedUntilTrick = 16,
        SilencedByCaptain = 17
    }
}
