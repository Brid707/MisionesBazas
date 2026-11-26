using System;

namespace Application.Models
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    public sealed class RadioAvailabilitySnapshot
    {
        public bool IsAvailable { get; set; }

        public RadioCommunicationFailureReason FailureReason { get; set; }
    }
}
