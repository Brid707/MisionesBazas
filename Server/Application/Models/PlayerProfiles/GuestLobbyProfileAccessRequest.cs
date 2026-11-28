namespace Application.Models
{
    /// <summary>Identifies a guest credential, room and target for public-profile authorization.</summary>
    public sealed class GuestLobbyProfileAccessRequest
    {
        public int GuestViewerUserId { get; set; }

        public string GuestSessionToken { get; set; }

        public string LobbyCode { get; set; }

        public int ProfileOwnerUserId { get; set; }
    }
}
