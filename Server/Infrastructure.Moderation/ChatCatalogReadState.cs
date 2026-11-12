using System.Collections.Generic;
using System.IO;

using Domain;

namespace Infrastructure.Moderation
{
    /// <summary>Bounds normalized catalog data and rejects conflicting duplicate definitions.</summary>
    internal sealed class ChatCatalogReadState
    {
        internal const int MaximumCatalogEntries = 2000;
        internal const int MaximumCatalogExpressionLength = 160;
        private const int MaximumNormalizedCatalogCharacters = 64000;

        private readonly Dictionary<string, ProhibitedChatExpression> _catalogExpressionsByIdentity =
            new Dictionary<string, ProhibitedChatExpression>();
        private readonly ChatMessageTextNormalizer _chatMessageTextNormalizer = new ChatMessageTextNormalizer();
        private int _catalogEntryCount;
        private int _normalizedCatalogCharacterCount;

        internal IReadOnlyCollection<ProhibitedChatExpression> Expressions =>
            new List<ProhibitedChatExpression>(_catalogExpressionsByIdentity.Values).AsReadOnly();

        internal void AddExpression(ProhibitedChatExpression expression)
        {
            _catalogEntryCount++;
            string normalizedExpressionText = _chatMessageTextNormalizer
                .NormalizeChatMessageText(expression.ExpressionText)
                .ComparableChatMessageText;
            ValidateEntryBudget(normalizedExpressionText);
            string expressionIdentity = expression.ExpressionCultureName + ":" + normalizedExpressionText;
            ProhibitedChatExpression previousExpression;
            if (_catalogExpressionsByIdentity.TryGetValue(expressionIdentity, out previousExpression))
            {
                ValidateDuplicate(previousExpression, expression);
            }
            else
            {
                _normalizedCatalogCharacterCount += normalizedExpressionText.Length;
                _catalogExpressionsByIdentity.Add(expressionIdentity, expression);
            }
        }

        private void ValidateEntryBudget(string normalizedExpressionText)
        {
            if (_catalogEntryCount > MaximumCatalogEntries || normalizedExpressionText.Length == 0 ||
                normalizedExpressionText.Length > MaximumCatalogExpressionLength ||
                _normalizedCatalogCharacterCount + normalizedExpressionText.Length > MaximumNormalizedCatalogCharacters)
            {
                throw new InvalidDataException("The chat catalog exceeds its entry or normalized text budget.");
            }
        }

        private static void ValidateDuplicate(ProhibitedChatExpression previousExpression,
            ProhibitedChatExpression expression)
        {
            if (previousExpression.InfractionCategory != expression.InfractionCategory ||
                previousExpression.CanMatchObfuscatedLetters != expression.CanMatchObfuscatedLetters)
            {
                throw new InvalidDataException("A normalized chat expression has conflicting catalog definitions.");
            }
        }
    }
}
