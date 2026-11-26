
namespace Application.Models
{
    /// <summary>Identifies expected play rejections without exposing private state.</summary>
    public enum MatchRejectionReason
    {
        None = 0,
        MatchUnavailable = 1,
        ParticipantNotAllowed = 2,
        InvalidSubmission = 3,
        SubmissionIdentityReused = 4,
        StaleMatchState = 5,
        NotPlayerTurn = 6,
        CardNotInHand = 7,
        MustFollowLeadSuit = 8,
        DealCompleted = 9,
        SubmissionCapacityReached = 10,
        MissionPreparationRequired = 11,
        MissionAttemptFinished = 12,
        WrongMissionAttempt = 13
    }
}
