
namespace Application.Models
{
    /// <summary>
    /// Reports the stable decision for one identified card play submission.
    /// </summary>
    public sealed class CardPlayDecision
    {
        public System.Guid CardPlaySubmissionId { get; set; }

        public bool IsAccepted { get; set; }

        public MatchRejectionReason RejectionReason { get; set; }

        public long CommittedMatchStateVersion { get; set; }
    }
}
