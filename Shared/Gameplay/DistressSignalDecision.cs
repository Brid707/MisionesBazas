using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Reports whether a distress signal card pass submission was accepted and executed.
    /// </summary>
    [DataContract]
    public sealed class DistressSignalDecision
    {
        [DataMember(Order = 1)]
        public bool IsAccepted { get; set; }

        [DataMember(Order = 2)]
        public bool IsExecuted { get; set; }

        [DataMember(Order = 3)]
        public MatchRejectionReason RejectionReason { get; set; }

        [DataMember(Order = 4)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
