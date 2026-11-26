using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class RadioCommunicationFault
    {
        [DataMember(Order = 1)]
        public RadioCommunicationFailureReason FailureReason { get; set; }
    }
}
