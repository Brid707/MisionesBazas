using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionPreparationConfirmation
    {
        [DataMember(Order = 1)]
        public Guid MissionPreparationSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
