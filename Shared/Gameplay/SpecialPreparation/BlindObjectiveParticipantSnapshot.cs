using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract]
    public sealed class BlindObjectiveParticipantSnapshot
    {
        [DataMember(Order = 1)]
        public int ParticipantUserId { get; set; }

        [DataMember(Order = 2)]
        public BlindObjectiveResponse Response { get; set; }
    }
}
