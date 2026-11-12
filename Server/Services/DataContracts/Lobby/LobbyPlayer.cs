using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Represents participant information within an active lobby room.
    /// </summary>
    [DataContract]
    public sealed class LobbyPlayer
    {
        [DataMember]
        public int IdUser { get; set; }

        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public bool IsHost { get; set; }

        [DataMember]
        public bool IsReady { get; set; }
    }
}
