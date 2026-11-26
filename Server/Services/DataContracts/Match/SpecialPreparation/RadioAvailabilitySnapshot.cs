using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class RadioAvailabilitySnapshot
    {
        [DataMember(Order = 1)]
        public bool IsAvailable { get; set; }

        [DataMember(Order = 2)]
        public RadioCommunicationFailureReason FailureReason { get; set; }
    }
}
