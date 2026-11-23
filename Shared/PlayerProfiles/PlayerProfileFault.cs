using System.Runtime.Serialization;

namespace PlayerProfiles
{
    /// <summary>Contains only the public reason for an own-profile operation failure.</summary>
    [DataContract]
    public sealed class PlayerProfileFault
    {
        [DataMember(Order = 1)]
        public PlayerProfileFailureReason FailureReason { get; set; }
    }
}
