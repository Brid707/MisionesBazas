using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Text;
using System;


namespace Domain
{
    /// <summary>Matches the bilingual catalog and masks the matched spans in the original message.</summary>
    public sealed class ChatMessageModerator
    {
        private const string ObfuscationSeparatorPattern = @"[\s._*\-]{0,2}";
        private const int MaximumRegexMatchMilliseconds = 50;
        private readonly ChatMessageTextNormalizer _chatMessageTextNormalizer;
        private readonly List<KeyValuePair<Regex, ChatInfractionCategory>> _compiledChatExpressionPatterns;

        public ChatMessageModerator(IEnumerable<ProhibitedChatExpression> prohibitedChatExpressions)
        {
            _chatMessageTextNormalizer = new ChatMessageTextNormalizer();
            _compiledChatExpressionPatterns = new List<KeyValuePair<Regex, ChatInfractionCategory>>();
            foreach (ProhibitedChatExpression prohibitedChatExpression in prohibitedChatExpressions)
            {
                Regex compiledExpressionPattern = new Regex(BuildExpressionPattern(prohibitedChatExpression),
                    RegexOptions.CultureInvariant | RegexOptions.Compiled,
                    TimeSpan.FromMilliseconds(MaximumRegexMatchMilliseconds));
                _compiledChatExpressionPatterns.Add(new KeyValuePair<Regex, ChatInfractionCategory>(
                    compiledExpressionPattern, prohibitedChatExpression.InfractionCategory));
            }
        }

        public ChatMessageModerationDecision EvaluateChatMessage(string originalChatMessageText)
        {
            NormalizedChatMessageText normalizedChatMessageText =
                _chatMessageTextNormalizer.NormalizeChatMessageText(originalChatMessageText);
            bool[] censoredOriginalCharacters = new bool[originalChatMessageText.Length];
            ChatInfractionCategory detectedInfractionCategory = ChatInfractionCategory.None;
            foreach (KeyValuePair<Regex, ChatInfractionCategory> expressionPattern in _compiledChatExpressionPatterns)
            {
                MatchCollection expressionMatches = expressionPattern.Key.Matches(
                    normalizedChatMessageText.ComparableChatMessageText);
                foreach (Match expressionMatch in expressionMatches)
                {
                    MarkOriginalCharacters(censoredOriginalCharacters, normalizedChatMessageText, expressionMatch);
                    if (expressionPattern.Value > detectedInfractionCategory)
                    {
                        detectedInfractionCategory = expressionPattern.Value;
                    }
                }
            }

            return new ChatMessageModerationDecision
            {
                CensoredChatMessageText = MaskOriginalCharacters(originalChatMessageText, censoredOriginalCharacters),
                DetectedInfractionCategory = detectedInfractionCategory
            };
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
