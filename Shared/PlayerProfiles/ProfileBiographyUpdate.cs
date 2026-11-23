using System.Runtime.Serialization;

namespace PlayerProfiles
{
    /// <summary>Replaces the authenticated account biography; no target account ID is accepted.</summary>
    [DataContract]
    public sealed class ProfileBiographyUpdate
    {
        [DataMember(Order = 1)]
        public string AccountSessionToken { get; set; }

        [DataMember(Order = 2)]
        public string Biography { get; set; }
    }
}
