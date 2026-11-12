using System;


namespace Domain
{
    /// <summary>Tracks an account's current infraction cycle and previous temporary chat sanctions.</summary>
    public sealed class ChatAccountInfractionState
    {
        public int AccumulatedChatInfractionPoints { get; set; }

        public int ThreateningChatMessageCount { get; set; }

        public int PreviousTemporaryChatBanCount { get; set; }

        public bool IsChatAccountPermanentlyBanned { get; set; }

        public DateTime? ChatAccountBanEndsAtUtc { get; set; }
    }
}
