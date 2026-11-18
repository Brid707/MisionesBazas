using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    [DataContract]
    public enum MissionObjectiveStatus
    {
        [EnumMember] Pending = 0,
        [EnumMember] Completed = 1,
        [EnumMember] Failed = 2
    }
}
