using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Exposes public readiness and a request identifier only for the requesting participant.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionRetrySnapshot
    {
        [DataMember(Order = 1)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 2)]
        public int AttemptNumber { get; set; }

        [DataMember(Order = 3)]
        public bool IsRetryAvailable { get; set; }

        [DataMember(Order = 4)]
        public int[] ReadyParticipantUserIds { get; set; }

        [DataMember(Order = 5)]
        public Guid? AvailableMissionRetrySubmissionId { get; set; }

        [DataMember(Order = 6)]
        public MissionRetryStatus Status { get; set; }

        [DataMember(Order = 7)]
        public Guid MissionRetryScheduleId { get; set; }

        [DataMember(Order = 8)]
        public int RemainingDelayMilliseconds { get; set; }

        [DataMember(Order = 9)]
        public int[] MissingParticipantUserIds { get; set; }
    }
}
