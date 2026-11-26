
namespace Application.Models
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    public enum MissionPreparationStage
    {
        None = 0,
        RoleSelection = 1,
        BlindResponses = 2,
        AssigneeSelection = 3,
        ObjectiveDrafting = 4,
        PlayingTricks = 5,
        Finished = 6,
        HeartNineIdentification = 7,
        TrickDistributionSelection = 8
    }
}
