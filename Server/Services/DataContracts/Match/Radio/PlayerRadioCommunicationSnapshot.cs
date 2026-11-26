using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class PlayerRadioCommunicationSnapshot
    {
        [DataMember(Order = 1)]
        public int ParticipantUserId { get; set; }

        [DataMember(Order = 2)]
        public int CommunicatedCardId { get; set; }

        [DataMember(Order = 3)]
        public RadioCommunicationMarker Marker { get; set; }

        [DataMember(Order = 4)]
        public bool HasCommunicatedCardBeenPlayed { get; set; }
    }
}
