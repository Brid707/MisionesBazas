using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    [DataContract]
    public enum RadioCommunicationMarker
    {
        [EnumMember] None = 0,
        [EnumMember] Highest = 1,
        [EnumMember] Only = 2,
        [EnumMember] Lowest = 3,
        [EnumMember] Hidden = 4
    }
}
