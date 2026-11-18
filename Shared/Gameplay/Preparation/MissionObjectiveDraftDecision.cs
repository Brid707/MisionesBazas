using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Confirms one objective selection or pass without granting authority to the client.</summary>
    [DataContract]
    public sealed class MissionObjectiveDraftDecision
    {
        [DataMember(Order = 1)]
        public Guid ObjectiveDraftSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public bool IsAccepted { get; set; }

        [DataMember(Order = 3)]
        public MissionObjectiveDraftRejectionReason RejectionReason { get; set; }

        [DataMember(Order = 4)]
        public long CommittedMatchStateVersion { get; set; }

        [DataMember(Order = 5)]
        public bool HasCompletedSelectionFreeCycle { get; set; }
    }
}
