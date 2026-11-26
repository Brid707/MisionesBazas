using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies controlled own-profile failures without exposing database diagnostics.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/PlayerProfiles")]
    public enum PlayerProfileFailureReason
    {
        [EnumMember] AccessDenied = 1,
        [EnumMember] InvalidBiography = 2,
        [EnumMember] ProfileUnavailable = 3,
        [EnumMember] ProfileNotFound = 4
    }
}
