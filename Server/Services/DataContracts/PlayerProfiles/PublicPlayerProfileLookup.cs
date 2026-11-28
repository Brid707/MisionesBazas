using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Selects a public account profile with registered-session or guest-lobby credentials.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/PlayerProfiles")]
    public sealed class PublicPlayerProfileLookup
    {
        [DataMember(Order = 1)]
        public int ProfileOwnerUserId { get; set; }

        [DataMember(Order = 2)]
        public string ProfileOwnerUsername { get; set; }

        [DataMember(Order = 3)]
        public string AccountSessionToken { get; set; }

        [DataMember(Order = 4)]
        public int GuestViewerUserId { get; set; }

        [DataMember(Order = 5)]
        public string GuestSessionToken { get; set; }

        [DataMember(Order = 6)]
        public string LobbyCode { get; set; }
    }
}
