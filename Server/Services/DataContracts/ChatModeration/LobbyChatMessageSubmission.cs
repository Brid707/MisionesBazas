using System.Runtime.Serialization;
using System;


namespace Services.DataContracts
{
    /// <summary>Identifies the text and lobby submitted for processing by the authenticated account.</summary>
    [DataContract]
    public sealed class LobbyChatMessageSubmission
    {
        [DataMember(Order = 1)]
        public Guid ChatMessageSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 3)]
        public string OriginalChatMessageText { get; set; }
    }
}
