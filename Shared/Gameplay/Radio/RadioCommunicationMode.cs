using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    [DataContract]
    public enum RadioCommunicationMode
    {
        [EnumMember] Standard = 0,
        [EnumMember] Interference = 1
    }
}
