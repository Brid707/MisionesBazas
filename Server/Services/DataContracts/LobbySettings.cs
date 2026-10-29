using System.Runtime.Serialization;

namespace Services.DTO
{
    /// <summary>
    /// Represents the configuration settings specified when creating or updating a lobby room.
    /// </summary>
    [DataContract]
    public sealed class LobbySettings
    {
        [DataMember]
        public byte TargetMissionCount { get; set; }

        [DataMember]
        public byte PlayerLimit { get; set; }
    }
}
