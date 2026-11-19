using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    [DataContract]
    public enum MissionPreparationStage
    {
        [EnumMember] None = 0,
        [EnumMember] RoleSelection = 1,
        [EnumMember] BlindResponses = 2,
        [EnumMember] AssigneeSelection = 3,
        [EnumMember] ObjectiveDrafting = 4,
        [EnumMember] PlayingTricks = 5,
        [EnumMember] Finished = 6
    }
}
