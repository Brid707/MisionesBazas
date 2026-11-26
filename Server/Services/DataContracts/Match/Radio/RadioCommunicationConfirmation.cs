using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class RadioCommunicationConfirmation
    {
        [DataMember(Order = 1)]
        public Guid RadioCommunicationSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
