using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    [DataContract]
    public sealed class RadioCommunicationFault
    {
        [DataMember(Order = 1)]
        public RadioCommunicationFailureReason FailureReason { get; set; }
    }
}
