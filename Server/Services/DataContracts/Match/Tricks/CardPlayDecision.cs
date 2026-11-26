using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Reports the stable decision for one identified card play submission.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
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
