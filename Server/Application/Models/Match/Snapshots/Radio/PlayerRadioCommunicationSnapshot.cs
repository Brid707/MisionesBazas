using System;

namespace Application.Models
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    public sealed class PlayerRadioCommunicationSnapshot
    {
        public int ParticipantUserId { get; set; }

        public int CommunicatedCardId { get; set; }

        public RadioCommunicationMarker Marker { get; set; }

        public bool HasCommunicatedCardBeenPlayed { get; set; }
    }
}
