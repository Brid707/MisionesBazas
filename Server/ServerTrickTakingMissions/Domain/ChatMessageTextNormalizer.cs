using System.Collections.Generic;
using System.Globalization;
using System.Text;


namespace Domain
{
    /// <summary>Normalizes case, Unicode compatibility forms and accents while retaining original spans.</summary>
    public sealed class ChatMessageTextNormalizer
    {
        public NormalizedChatMessageText NormalizeChatMessageText(string originalChatMessageText)
        {
            StringBuilder comparableChatMessageText = new StringBuilder();
            List<int> originalCharacterStarts = new List<int>();
            List<int> originalCharacterEnds = new List<int>();
            TextElementEnumerator textElements = StringInfo.GetTextElementEnumerator(originalChatMessageText);
            while (textElements.MoveNext())
            {
                string originalTextElement = textElements.GetTextElement();
                string normalizedTextElement = originalTextElement.Normalize(NormalizationForm.FormKD)
                    .ToLowerInvariant();
                foreach (char normalizedCharacter in normalizedTextElement)
                {
                    UnicodeCategory characterCategory = char.GetUnicodeCategory(normalizedCharacter);
                    if (characterCategory != UnicodeCategory.NonSpacingMark &&
                    characterCategory != UnicodeCategory.Format)
                    {
                        comparableChatMessageText.Append(normalizedCharacter);
                        originalCharacterStarts.Add(textElements.ElementIndex);
                        originalCharacterEnds.Add(textElements.ElementIndex + originalTextElement.Length);
                    }
                }
            }

            return new NormalizedChatMessageText
            {
                ComparableChatMessageText = comparableChatMessageText.ToString(),
                OriginalCharacterStarts = originalCharacterStarts.AsReadOnly(),
                OriginalCharacterEnds = originalCharacterEnds.AsReadOnly()
            };
        }
    }
}
