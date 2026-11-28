using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Contains only public profile fields; never exports email or account credentials.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/PlayerProfiles")]
    public sealed class PublicPlayerProfileDetails
    {
        [DataMember(Order = 1)]
        public int ProfileOwnerUserId { get; set; }

        [DataMember(Order = 2)]
        public string Username { get; set; }

        [DataMember(Order = 3)]
        public string Biography { get; set; }

        [DataMember(Order = 4)]
        public DateTime AccountCreatedAtUtc { get; set; }

        [DataMember(Order = 5)]
        public int? CompletedMissionCount { get; set; }
    }
}
