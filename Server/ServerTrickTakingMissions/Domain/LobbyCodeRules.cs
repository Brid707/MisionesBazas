using System;
using System.Linq;

namespace Domain
{
    /// <summary>
    /// Encapsulates pure domain rules for generating, normalizing, and validating lobby room invitation codes.
    /// </summary>
    public static class LobbyCodeRules
    {
        public const int CodeLength = 5;
        private const string AllowedCharacters = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

        private static readonly Random CodeGenerator = new Random();
        private static readonly object GeneratorSyncRoot = new object();

        /// <summary>
        /// Generates a candidate alphanumeric lobby code excluding visually ambiguous characters.
        /// </summary>
        /// <returns>A newly generated uppercase lobby invitation code of length <see cref="CodeLength"/>.</returns>
        public static string GenerateCode()
        {
            char[] buffer = new char[CodeLength];

            lock (GeneratorSyncRoot)
            {
                for (int index = 0; index < CodeLength; index++)
                {
                    int charIndex = CodeGenerator.Next(AllowedCharacters.Length);
                    buffer[index] = AllowedCharacters[charIndex];
                }
            }

            return new string(buffer);
        }

        /// <summary>
        /// Normalizes a raw lobby code string by trimming whitespace and converting to uppercase invariant culture.
        /// </summary>
        /// <param name="rawCode">The raw input code provided by a user or client.</param>
        /// <returns>The normalized code string, or an empty string if the input is null or whitespace.</returns>
        public static string NormalizeCode(string rawCode)
        {
            return string.IsNullOrWhiteSpace(rawCode)
                ? string.Empty
                : rawCode.Trim().ToUpperInvariant();
        }

        /// <summary>
        /// Determines whether the provided lobby code satisfies the official length and character set invariants.
        /// </summary>
        /// <param name="lobbyCode">The lobby code to validate.</param>
        /// <returns>True if the code matches the domain format rules; otherwise, false.</returns>
        public static bool IsCodeFormatValid(string lobbyCode)
        {
            string normalizedCode = NormalizeCode(lobbyCode);
            bool hasValidLength = normalizedCode.Length == CodeLength;
            bool hasValidCharacters = hasValidLength && normalizedCode.All(IsAllowedCharacter);

            return hasValidCharacters;
        }

        private static bool IsAllowedCharacter(char character)
        {
            return AllowedCharacters.IndexOf(character) >= 0;
        }
    }
}
