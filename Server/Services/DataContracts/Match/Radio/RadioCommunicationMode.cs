using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum RadioCommunicationMode
    {
        [EnumMember] Standard = 0,
        [EnumMember] Interference = 1,
        [EnumMember] DisruptionUntilTrick2 = 2,
        [EnumMember] DisruptionUntilTrick3 = 3
    }
}
