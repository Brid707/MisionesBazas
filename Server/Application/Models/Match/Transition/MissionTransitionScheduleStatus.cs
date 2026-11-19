namespace Application.Models
{
    /// <summary>Describes the authoritative automatic mission transition lifecycle.</summary>
    public enum MissionTransitionScheduleStatus
    {
        Inactive = 0,
        WaitingForParticipants = 1,
        CountingDown = 2,
        Preparing = 3,
        PreparationFailed = 4,
        AttemptLimitReached = 5,
        CampaignCompleted = 6,
        MissionUnavailable = 7
    }
}
