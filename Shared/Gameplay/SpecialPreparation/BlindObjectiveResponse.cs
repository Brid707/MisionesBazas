using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    [DataContract]
    public enum BlindObjectiveResponse
    {
        [EnumMember] Pending = 0,
        [EnumMember] Yes = 1,
        [EnumMember] No = 2
    }
}
