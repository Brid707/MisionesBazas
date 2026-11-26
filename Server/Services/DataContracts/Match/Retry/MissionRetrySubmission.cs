using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Submits one identified readiness confirmation for a failed attempt.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionRetrySubmission
    {
        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public Guid MissionRetrySubmissionId { get; set; }

        [DataMember(Order = 5)]
        public long ExpectedMatchStateVersion { get; set; }
    }
}
