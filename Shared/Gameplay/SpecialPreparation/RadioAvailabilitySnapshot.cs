using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract]
    public sealed class RadioAvailabilitySnapshot
    {
        [DataMember(Order = 1)]
        public bool IsAvailable { get; set; }

        [DataMember(Order = 2)]
        public RadioCommunicationFailureReason FailureReason { get; set; }
    }
}
