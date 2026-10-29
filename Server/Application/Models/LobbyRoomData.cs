using System.Collections.Generic;

namespace Application.Models
{
    /// <summary>
    /// Represents the state and active participants of a game lobby room in the application core.
    /// </summary>
    public sealed class LobbyRoomData
    {
        public string LobbyCode { get; set; }

        public int HostUserId { get; set; }

        public byte TargetMissionCount { get; set; }

        public byte PlayerLimit { get; set; }

        public byte Status { get; set; }

        public List<LobbyParticipantData> Players { get; set; } = new List<LobbyParticipantData>();
    }
}
