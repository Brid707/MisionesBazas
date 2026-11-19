using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Reports the stable decision for one identified card play submission.
    /// </summary>
    [DataContract]
    public sealed class CardPlayDecision
    {
        [DataMember(Order = 1)]
        public System.Guid CardPlaySubmissionId { get; set; }

        [DataMember(Order = 2)]
        public bool IsAccepted { get; set; }

        [DataMember(Order = 3)]
        public MatchRejectionReason RejectionReason { get; set; }

        [DataMember(Order = 4)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
