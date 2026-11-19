using System.Runtime.Serialization;
using TrickTakingMissions.Rules.Enums;

namespace Gameplay
{
    /// <summary>
    /// Represents the public radio communication state for a player in the match snapshot.
    /// </summary>
    [DataContract]
    public sealed class PlayerRadioCommunicationSnapshot
    {
        [DataMember(Order = 1)]
        public int PlayerUserId { get; set; }

        [DataMember(Order = 2)]
        public byte Seat { get; set; }

        [DataMember(Order = 3)]
        public int? CommunicatedCardId { get; set; }

        [DataMember(Order = 4)]
        public RadioTokenPosition TokenPosition { get; set; }

        [DataMember(Order = 5)]
        public bool HasUsedCommunicationToken { get; set; }

        [DataMember(Order = 6)]
        public bool IsSilencedByCaptain { get; set; }
    }
}
