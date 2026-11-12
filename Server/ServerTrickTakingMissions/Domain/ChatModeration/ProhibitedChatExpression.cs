namespace Domain
{
    /// <summary>Describes one expression from the bilingual server moderation catalog.</summary>
    public sealed record ProhibitedChatExpression
    {
        public string ExpressionText { get; init; }

        public string ExpressionCultureName { get; init; }

        public ChatInfractionCategory InfractionCategory { get; init; }

        public bool CanMatchObfuscatedLetters { get; init; }
    }
}
