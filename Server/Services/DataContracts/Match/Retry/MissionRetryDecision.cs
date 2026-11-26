using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Confirms a vote or one new attempt without returning private cards.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionRetryDecision
    {
        [DataMember(Order = 1)]
        public Guid MissionRetrySubmissionId { get; set; }

        [DataMember(Order = 2)]
        public bool IsAccepted { get; set; }

        [DataMember(Order = 3)]
        public bool HasRestartedMission { get; set; }

        [DataMember(Order = 4)]
        public long CommittedMatchStateVersion { get; set; }

        [DataMember(Order = 5)]
        public int CurrentMissionAttemptId { get; set; }

        [DataMember(Order = 6)]
        public MissionRetryRejectionReason RejectionReason { get; set; }
    }
}
