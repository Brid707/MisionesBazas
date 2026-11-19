namespace Application.Models
{
    /// <summary>
    /// Identifies business validation rejections for distress signal requests inside the application layer.
    /// </summary>
    public enum DistressSignalRejection
    {
        None = 0,
        InvalidSubmission = 1,
        MatchUnavailable = 2,
        ParticipantNotAllowed = 3,
        WrongMissionAttempt = 4,
        MissionPreparationRequired = 5,
        MissionAttemptFinished = 6,
        DistressAlreadyUsed = 7,
        TrickAlreadyStarted = 8,
        RadioAlreadyUsed = 9,
        CardNotInHand = 10,
        SpecialCardNotAllowed = 11,
        InvalidStepTransition = 12,
        OperationUnavailable = 13
    }
}
