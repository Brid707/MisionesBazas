namespace Application.Models
{
    /// <summary>Describes moderation, persistence and publication eligibility for one lobby chat submission.</summary>
    public sealed class LobbyChatMessageProcessing
    {
        public bool CanPublishChatMessage { get; set; }

        public ChatMessageRejectionReason ChatMessageRejectionReason { get; set; }

        public string CensoredChatMessageText { get; set; }

        public ChatInfractionRecord RecordedChatInfraction { get; set; }
    }
}
