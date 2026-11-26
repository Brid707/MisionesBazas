using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Replaces the authenticated account biography; no target account ID is accepted.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/PlayerProfiles")]
    public sealed class ProfileBiographyUpdate
    {
        [DataMember(Order = 1)]
        public string AccountSessionToken { get; set; }

        [DataMember(Order = 2)]
        public string Biography { get; set; }
    }
}
