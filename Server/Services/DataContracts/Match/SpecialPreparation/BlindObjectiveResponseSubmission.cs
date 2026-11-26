using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class BlindObjectiveResponseSubmission
    {
        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public Guid MissionPreparationStageId { get; set; }

        [DataMember(Order = 5)]
        public Guid MissionPreparationSubmissionId { get; set; }

        [DataMember(Order = 6)]
        public long ExpectedMatchStateVersion { get; set; }

        [DataMember(Order = 7)]
        public BlindObjectiveResponse Response { get; set; }
    }
}
