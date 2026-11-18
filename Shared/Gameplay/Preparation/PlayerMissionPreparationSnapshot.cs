using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Exposes preparation state and an action identifier only to its current participant.</summary>
    [DataContract]
    public sealed class PlayerMissionPreparationSnapshot
    {
        [DataMember(Order = 6)]
        public Guid? AvailableObjectiveDraftSubmissionId { get; set; }

        [DataMember(Order = 1)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 2)]
        public int MissionNumber { get; set; }

        [DataMember(Order = 3)]
        public bool IsPreparationComplete { get; set; }

        [DataMember(Order = 4)]
        public int CurrentObjectiveDraftPlayerUserId { get; set; }

        [DataMember(Order = 5)]
        public MissionObjectiveSnapshot[] Objectives { get; set; }
    }
}
