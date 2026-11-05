using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes the account restriction applied by the server for chat infractions.</summary>
    [DataContract]
    public sealed class ChatAccountBanNotice
    {
        [DataMember(Order = 4)]
        public DateTime EvaluatedAtUtc { get; set; }

        [DataMember(Order = 1)]
        public Guid ChatMessageSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public ChatAccountBanType ChatAccountBanType { get; set; }

        [DataMember(Order = 3)]
        public DateTime? ChatAccountBanEndsAtUtc { get; set; }
    }
}
