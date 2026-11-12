using System.Collections.Generic;


namespace Domain
{
    /// <summary>Preserves original character spans while comparing normalized text.</summary>
    public sealed record NormalizedChatMessageText
    {
        public string ComparableChatMessageText { get; init; }

        public IReadOnlyList<int> OriginalCharacterStarts { get; init; }

        public IReadOnlyList<int> OriginalCharacterEnds { get; init; }
    }
}
