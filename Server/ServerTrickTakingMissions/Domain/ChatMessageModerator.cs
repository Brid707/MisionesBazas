using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Text.RegularExpressions;

namespace Domain
{
    /// <summary>Matches the bilingual catalog and masks the matched spans in the original message.</summary>
    public sealed class ChatMessageModerator
    {
        private const string ObfuscationSeparatorPattern = @"[\s._*\-]{0,2}";
        private const int MaximumRegexMatchMilliseconds = 50;
        private const int MaximumPreparationMilliseconds = 2000;
        private const int MaximumMessageModerationMilliseconds = 100;
        private readonly ChatMessageTextNormalizer _chatMessageTextNormalizer;
        private readonly List<KeyValuePair<Regex, ChatInfractionCategory>> _chatExpressionPatterns;

        public ChatMessageModerator(IEnumerable<ProhibitedChatExpression> prohibitedChatExpressions)
        {
            _chatMessageTextNormalizer = new ChatMessageTextNormalizer();
            _chatExpressionPatterns = new List<KeyValuePair<Regex, ChatInfractionCategory>>();
            Stopwatch preparationTimer = Stopwatch.StartNew();
            foreach (ProhibitedChatExpression prohibitedChatExpression in prohibitedChatExpressions)
            {
                EnsureWithinTimeBudget(preparationTimer, MaximumPreparationMilliseconds);
                Regex expressionPattern = new Regex(BuildExpressionPattern(prohibitedChatExpression),
                    RegexOptions.CultureInvariant,
                    TimeSpan.FromMilliseconds(MaximumRegexMatchMilliseconds));
                _chatExpressionPatterns.Add(new KeyValuePair<Regex, ChatInfractionCategory>(
                    expressionPattern, prohibitedChatExpression.InfractionCategory));
                EnsureWithinTimeBudget(preparationTimer, MaximumPreparationMilliseconds);
            }
        }

        public ChatMessageModerationDecision EvaluateChatMessage(string originalChatMessageText)
        {
            Stopwatch moderationTimer = Stopwatch.StartNew();
            NormalizedChatMessageText normalizedChatMessageText =
                _chatMessageTextNormalizer.NormalizeChatMessageText(originalChatMessageText);
            bool[] censoredOriginalCharacters = new bool[originalChatMessageText.Length];
            ChatInfractionCategory detectedInfractionCategory = ChatInfractionCategory.None;
            foreach (KeyValuePair<Regex, ChatInfractionCategory> expressionPattern in _chatExpressionPatterns)
            {
                EnsureWithinTimeBudget(moderationTimer, MaximumMessageModerationMilliseconds);
                MatchCollection expressionMatches = expressionPattern.Key.Matches(
                    normalizedChatMessageText.ComparableChatMessageText);
                foreach (Match expressionMatch in expressionMatches)
                {
                    EnsureWithinTimeBudget(moderationTimer, MaximumMessageModerationMilliseconds);
                    MarkOriginalCharacters(censoredOriginalCharacters, normalizedChatMessageText, expressionMatch);
                    if (expressionPattern.Value > detectedInfractionCategory)
                    {
                        detectedInfractionCategory = expressionPattern.Value;
                    }
                }
            }

            EnsureWithinTimeBudget(moderationTimer, MaximumMessageModerationMilliseconds);
            return new ChatMessageModerationDecision
            {
                CensoredChatMessageText = MaskOriginalCharacters(originalChatMessageText, censoredOriginalCharacters),
                DetectedInfractionCategory = detectedInfractionCategory
            };
        }

        private static void EnsureWithinTimeBudget(Stopwatch operationTimer, int maximumElapsedMilliseconds)
        {
            if (operationTimer.ElapsedMilliseconds > maximumElapsedMilliseconds)
            {
                throw new TimeoutException("The chat moderation operation exceeded its processing budget.");
            }
        }

        private string BuildExpressionPattern(ProhibitedChatExpression prohibitedChatExpression)
        {
            string normalizedExpressionText = _chatMessageTextNormalizer.NormalizeChatMessageText(
                prohibitedChatExpression.ExpressionText).ComparableChatMessageText;
            List<string> expressionLetterPatterns = new List<string>();
            foreach (char expressionCharacter in normalizedExpressionText)
            {
                expressionLetterPatterns.Add(GetCharacterPattern(expressionCharacter,
                    prohibitedChatExpression.CanMatchObfuscatedLetters));
            }

            string expressionSeparator = prohibitedChatExpression.CanMatchObfuscatedLetters
                ? ObfuscationSeparatorPattern : string.Empty;
            return @"(?<![\p{L}\p{N}])" + string.Join(expressionSeparator, expressionLetterPatterns) +
                @"(?![\p{L}\p{N}])";
        }

        private static string GetCharacterPattern(char expressionCharacter, bool canMatchObfuscatedLetters)
        {
            string characterPattern = Regex.Escape(expressionCharacter.ToString());
            if (char.IsWhiteSpace(expressionCharacter))
            {
                characterPattern = @"\s+";
            }
            else if (expressionCharacter == '\'')
            {
                characterPattern = "['\u2019\u2018\u02BC]";
            }
            else if (canMatchObfuscatedLetters && char.IsLetter(expressionCharacter))
            {
                characterPattern = GetObfuscatedLetterPattern(expressionCharacter) + "{1,3}";
            }

            return characterPattern;
        }

        private static string GetObfuscatedLetterPattern(char expressionCharacter)
        {
            string characterPattern;
            switch (expressionCharacter)
            {
                case 'a': characterPattern = "[a@4]"; break;
                case 'e': characterPattern = "[e3]"; break;
                case 'i': characterPattern = "[i1!]"; break;
                case 'o': characterPattern = "[o0]"; break;
                case 's': characterPattern = "[s$5]"; break;
                case 't': characterPattern = "[t7]"; break;
                default: characterPattern = Regex.Escape(expressionCharacter.ToString()); break;
            }

            return characterPattern;
        }

        private static void MarkOriginalCharacters(bool[] censoredOriginalCharacters,
            NormalizedChatMessageText normalizedChatMessageText, Match expressionMatch)
        {
            int originalMatchStart = normalizedChatMessageText.OriginalCharacterStarts[expressionMatch.Index];
            int originalMatchEnd = normalizedChatMessageText.OriginalCharacterEnds[
                expressionMatch.Index + expressionMatch.Length - 1];
            for (int originalCharacterIndex = originalMatchStart; originalCharacterIndex < originalMatchEnd;
                originalCharacterIndex++)
            {
                censoredOriginalCharacters[originalCharacterIndex] = true;
            }
        }

        private static string MaskOriginalCharacters(string originalChatMessageText, bool[] censoredOriginalCharacters)
        {
            StringBuilder censoredChatMessageText = new StringBuilder();
            bool wasPreviousCharacterCensored = false;
            for (int originalCharacterIndex = 0; originalCharacterIndex < originalChatMessageText.Length;
                originalCharacterIndex++)
            {
                bool isCurrentCharacterCensored = censoredOriginalCharacters[originalCharacterIndex];
                if (isCurrentCharacterCensored && !wasPreviousCharacterCensored)
                {
                    censoredChatMessageText.Append("***");
                }
                else if (!isCurrentCharacterCensored)
                {
                    censoredChatMessageText.Append(originalChatMessageText[originalCharacterIndex]);
                }

                wasPreviousCharacterCensored = isCurrentCharacterCensored;
            }

            return censoredChatMessageText.ToString();
        }
    }
}
