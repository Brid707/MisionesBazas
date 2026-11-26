using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum RadioCommunicationMarker
    {
        [EnumMember] None = 0,
        [EnumMember] Highest = 1,
        [EnumMember] Only = 2,
        [EnumMember] Lowest = 3,
        [EnumMember] Hidden = 4
    }
}
