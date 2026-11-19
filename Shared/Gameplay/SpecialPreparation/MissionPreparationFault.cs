using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract]
    public sealed class MissionPreparationFault
    {
        [DataMember(Order = 1)]
        public MissionPreparationFailureReason FailureReason { get; set; }
    }
}
