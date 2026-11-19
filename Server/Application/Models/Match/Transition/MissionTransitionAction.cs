namespace Application.Models
{
    /// <summary>Distinguishes repeating an attempt from advancing its mission.</summary>
    public enum MissionTransitionAction
    {
        None = 0,
        RetryCurrentMission = 1,
        AdvanceToNextMission = 2
    }
}
