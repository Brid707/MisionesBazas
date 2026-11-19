using System;
using System.Runtime.Serialization;
using TrickTakingMissions.Rules.Enums;

namespace Gameplay
{
    /// <summary>
    /// Identifies a radio communication request placed on a specific card in hand.
    /// </summary>
    [DataContract]
    public sealed class RadioCommunicationSubmission
    {
        [DataMember(Order = 1)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 2)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public int CardId { get; set; }

        [DataMember(Order = 5)]
        public RadioTokenPosition SelectedPosition { get; set; }
    }
}
