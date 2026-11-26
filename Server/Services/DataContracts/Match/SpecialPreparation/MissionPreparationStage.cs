using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionPreparationStage
    {
        [EnumMember] None = 0,
        [EnumMember] RoleSelection = 1,
        [EnumMember] BlindResponses = 2,
        [EnumMember] AssigneeSelection = 3,
        [EnumMember] ObjectiveDrafting = 4,
        [EnumMember] PlayingTricks = 5,
        [EnumMember] Finished = 6,
        [EnumMember] HeartNineIdentification = 7,
        [EnumMember] TrickDistributionSelection = 8
    }
}
