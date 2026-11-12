namespace Domain
{
    /// <summary>Contains the masked message and the highest category detected by the catalog.</summary>
    public sealed record ChatMessageModerationDecision
    {
        public string CensoredChatMessageText { get; init; }

        public ChatInfractionCategory DetectedInfractionCategory { get; init; }
    }
}
