using System;

namespace Application.Models
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    public sealed class BlindObjectiveParticipantSnapshot
    {
        public int ParticipantUserId { get; set; }

        public BlindObjectiveResponse Response { get; set; }
    }
}
