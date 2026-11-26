using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionObjectiveStatus
    {
        [EnumMember] Pending = 0,
        [EnumMember] Completed = 1,
        [EnumMember] Failed = 2
    }
}
