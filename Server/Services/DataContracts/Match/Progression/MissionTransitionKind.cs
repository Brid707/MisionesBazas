using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes public mission progression without server-owned game data.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionTransitionKind
    {
        [EnumMember] None = 0,
        [EnumMember] RetryCurrentMission = 1,
        [EnumMember] AdvanceToNextMission = 2
    }
}
