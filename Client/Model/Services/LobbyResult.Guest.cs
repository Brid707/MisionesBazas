using System.Runtime.Serialization;

namespace Model.GameServices
{
    public partial class LobbyResult
    {
        [DataMember]
        public string GuestSessionToken { get; set; }
    }
}
