using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Publishes transition progress; never includes a deck or another participant hand.</summary>
    [DataContract]
    public sealed class MissionTransitionSnapshot
    {
        [DataMember(Order = 1)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 2)]
        public int AttemptNumber { get; set; }

        [DataMember(Order = 3)]
        public MissionTransitionStatus Status { get; set; }

        [DataMember(Order = 4)]
        public MissionTransitionKind Kind { get; set; }

        [DataMember(Order = 5)]
        public Guid MissionTransitionScheduleId { get; set; }

        [DataMember(Order = 6)]
        public int RemainingDelayMilliseconds { get; set; }

        [DataMember(Order = 7)]
        public int[] MissingParticipantUserIds { get; set; }

        [DataMember(Order = 8)]
        public int DestinationMissionNumber { get; set; }

        [DataMember(Order = 9)]
        public int TargetMissionCount { get; set; }
    }
}
