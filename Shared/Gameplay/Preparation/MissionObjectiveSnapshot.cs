using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Omits unrevealed card identities while describing public objective ownership.</summary>
    [DataContract]
    public sealed class MissionObjectiveSnapshot
    {
        [DataMember(Order = 1)]
        public Guid MissionObjectiveId { get; set; }

        [DataMember(Order = 2)]
        public int? CardId { get; set; }

        [DataMember(Order = 3)]
        public MissionObjectiveToken Token { get; set; }

        [DataMember(Order = 4)]
        public int? AssignedPlayerUserId { get; set; }

        [DataMember(Order = 5)]
        public bool IsRevealed { get; set; }
        [DataMember(Order = 6)]
        public MissionObjectiveStatus Status { get; set; }

        [DataMember(Order = 7)]
        public int? CompletedAtTrickNumber { get; set; }
    }
}
