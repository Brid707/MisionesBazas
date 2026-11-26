using System;

namespace Application.Models
{
    /// <summary>Omits unrevealed card identities while describing public objective ownership.</summary>
    public sealed class MissionObjectiveSnapshot
    {
        public Guid MissionObjectiveId { get; set; }

        public int? CardId { get; set; }

        public MissionObjectiveToken Token { get; set; }

        public int? AssignedPlayerUserId { get; set; }

        public bool IsRevealed { get; set; }
        public MissionObjectiveStatus Status { get; set; }

        public int? CompletedAtTrickNumber { get; set; }
    }
}
