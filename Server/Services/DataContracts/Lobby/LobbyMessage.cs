using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Represents a chat message exchanged among participants in a lobby room.
    /// </summary>
    [DataContract]
    public sealed class LobbyMessage
    {
        [DataMember]
        public int SenderUserId { get; set; }

        [DataMember]
        public string SenderUsername { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public DateTime SentAt { get; set; }
    }
}
