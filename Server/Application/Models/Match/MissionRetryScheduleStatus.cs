namespace Application.Models
{
    /// <summary>Describes the authoritative automatic retry lifecycle.</summary>
    public enum MissionRetryScheduleStatus
    {
        Inactive = 0,
        WaitingForParticipants = 1,
        CountingDown = 2,
        Preparing = 3,
        PreparationFailed = 4,
        AttemptLimitReached = 5
    }
}
