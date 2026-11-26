
namespace Application.Models
{
    /// <summary>Describes public mission progression without server-owned game data.</summary>
    public enum MissionTransitionKind
    {
        None = 0,
        RetryCurrentMission = 1,
        AdvanceToNextMission = 2
    }
}
