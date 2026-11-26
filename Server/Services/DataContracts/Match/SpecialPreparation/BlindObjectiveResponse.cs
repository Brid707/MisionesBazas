using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies a mission preparation stage or decision explicitly.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum BlindObjectiveResponse
    {
        [EnumMember] Pending = 0,
        [EnumMember] Yes = 1,
        [EnumMember] No = 2
    }
}
