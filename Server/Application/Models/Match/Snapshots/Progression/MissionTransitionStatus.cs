
namespace Application.Models
{
    /// <summary>Describes public mission progression without server-owned game data.</summary>
    public enum MissionTransitionStatus
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
