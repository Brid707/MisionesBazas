using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Represents the state and participant list of an active game lobby room.
    /// </summary>
    [DataContract]
    public sealed class Lobby
    {
        [DataMember]
        public string LobbyCode { get; set; }

        [DataMember]
        public int HostUserId { get; set; }

        [DataMember]
        public byte TargetMissionCount { get; set; }

        [DataMember]
        public byte PlayerLimit { get; set; }

        [DataMember]
        public byte Status { get; set; }

        [DataMember]
        public bool IsPrivate { get; set; } = true;

        [DataMember]
        public bool IsChatSendingAvailable { get; set; }

        [DataMember]
        public long StateVersion { get; set; }

        [DataMember]
        public List<LobbyPlayer> Players { get; set; } = new List<LobbyPlayer>();
    }
}
