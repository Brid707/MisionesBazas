using System.Runtime.Serialization;

namespace PlayerProfiles
{
    /// <summary>Identifies controlled own-profile failures without exposing database diagnostics.</summary>
    [DataContract]
    public enum PlayerProfileFailureReason
    {
        [EnumMember] AccessDenied = 1,
        [EnumMember] InvalidBiography = 2,
        [EnumMember] ProfileUnavailable = 3,
        [EnumMember] ProfileNotFound = 4
    }
}
