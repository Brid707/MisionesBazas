using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    [DataContract]
    public sealed class RadioCommunicationConfirmation
    {
        [DataMember(Order = 1)]
        public Guid RadioCommunicationSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
