using System.Runtime.Serialization;
using TrickTakingMissions.Rules.Enums;

namespace Gameplay
{
    /// <summary>
    /// Reports whether a radio communication request was accepted by the domain rules.
    /// </summary>
    [DataContract]
    public sealed class RadioCommunicationDecision
    {
        [DataMember(Order = 1)]
        public bool IsAccepted { get; set; }

        [DataMember(Order = 2)]
        public RadioCommunicationRejectionReason RejectionReason { get; set; }

        [DataMember(Order = 3)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
