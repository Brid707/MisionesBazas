using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Contains only the public reason for an own-profile operation failure.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/PlayerProfiles")]
    public sealed class PlayerProfileFault
    {
        [DataMember(Order = 1)]
        public PlayerProfileFailureReason FailureReason { get; set; }
    }
}
