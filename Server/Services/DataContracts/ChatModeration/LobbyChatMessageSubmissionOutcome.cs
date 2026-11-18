using System.Runtime.Serialization;
using System;

namespace Services.DataContracts
{
    /// <summary>Describes committed processing of a particular submission, not delivery to every recipient.</summary>
    [DataContract]
    public sealed class LobbyChatMessageSubmissionOutcome
    {
        [DataMember(Order = 1)]
        public Guid ChatMessageSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public bool IsChatMessageAccepted { get; set; }

        [DataMember(Order = 3)]
        public bool IsRepeatedChatMessageSubmission { get; set; }

        [DataMember(Order = 4)]
        public LobbyChatMessageRejectionReason ChatMessageRejectionReason { get; set; }

        [DataMember(Order = 5)]
        public ChatInfractionNotice ChatInfractionNotice { get; set; }

        [DataMember(Order = 6)]
        public ChatAccountBanNotice ChatAccountBanNotice { get; set; }
    }
}
