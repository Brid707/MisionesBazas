
namespace Application.Models
{
    /// <summary>Describes automatic retry presentation without exposing server timing internals.</summary>
    public enum MissionRetryStatus
    {
        Inactive = 0,
        WaitingForParticipants = 1,
        CountingDown = 2,
        Preparing = 3,
        PreparationFailed = 4,
        AttemptLimitReached = 5
    }
}
