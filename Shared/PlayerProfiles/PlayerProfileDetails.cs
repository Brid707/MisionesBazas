using System;
using System.Runtime.Serialization;

namespace PlayerProfiles
{
    /// <summary>Transports real own-account profile data; unavailable statistics remain null.</summary>
    [DataContract]
    public sealed class PlayerProfileDetails
    {
        [DataMember(Order = 1)]
        public string Username { get; set; }

        [DataMember(Order = 2)]
        public string Email { get; set; }

        [DataMember(Order = 3)]
        public DateTime AccountCreatedAtUtc { get; set; }

        [DataMember(Order = 4)]
        public string Biography { get; set; }

        [DataMember(Order = 5)]
        public int? CompletedMissionCount { get; set; }
    }
}
