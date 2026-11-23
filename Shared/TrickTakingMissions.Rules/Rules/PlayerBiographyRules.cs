using System.Xml;

namespace TrickTakingMissions.Rules.Rules
{
    /// <summary>Defines the UTF-16 biography capacity matching PlayerProfile.Biography NVARCHAR(300).</summary>
    public static class PlayerBiographyRules
    {
        public const int MaximumBiographyLength = 300;

        public static bool IsBiographyValid(string biography)
        {
            bool isValidBiography = biography != null && biography.Length <= MaximumBiographyLength;
            if (isValidBiography)
            {
                for (int characterIndex = 0; isValidBiography && characterIndex < biography.Length; characterIndex++)
                {
                    isValidBiography = IsBiographyCharacterValid(biography, characterIndex);
                }
            }
            return isValidBiography;
        }

        private static bool IsBiographyCharacterValid(string biography, int characterIndex)
        {
            char character = biography[characterIndex];
            bool isValidCharacter = XmlConvert.IsXmlChar(character);
            if (char.IsHighSurrogate(character))
            {
                isValidCharacter = characterIndex + 1 < biography.Length &&
                    char.IsLowSurrogate(biography[characterIndex + 1]);
            }
            else if (char.IsLowSurrogate(character))
            {
                isValidCharacter = characterIndex > 0 && char.IsHighSurrogate(biography[characterIndex - 1]);
            }
            return isValidCharacter;
        }
    }
}
