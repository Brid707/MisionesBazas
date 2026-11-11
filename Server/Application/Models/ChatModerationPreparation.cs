using System.Collections.Generic;

using Domain;

namespace Application.Models
{
    /// <summary>Contains a validated bilingual catalog and its ready-to-use moderation filter.</summary>
    public sealed record ChatModerationPreparation
    {
        public IReadOnlyCollection<ProhibitedChatExpression> Expressions { get; init; }

        public ChatMessageModerator MessageModerator { get; init; }

        public bool IsChatSendingAvailable => MessageModerator != null;
    }
}
