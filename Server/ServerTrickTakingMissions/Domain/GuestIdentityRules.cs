using System;

namespace Domain
{
    /// <summary>
    /// Encapsulates the domain convention used to identify and name temporary guest players.
    /// </summary>
    public static class GuestIdentityRules
    {
        public const string GuestUsernamePrefix = "Guest_";

        private const int SuffixModulus = 10000;

        /// <summary>
        /// Determines whether the given user identifier represents a temporary guest player.
        /// </summary>
        /// <param name="userId">The user identifier to evaluate.</param>
        /// <returns>True if the identifier belongs to a guest; otherwise, false.</returns>
        public static bool IsGuestUserId(int userId)
        {
            return userId < 0;
        }

        /// <summary>
        /// Builds the display name assigned to a guest player from its temporary identifier.
        /// </summary>
        /// <param name="userId">The temporary guest identifier.</param>
        /// <returns>The guest display name.</returns>
        public static string BuildGuestUsername(int userId)
        {
            int suffix = Math.Abs(userId) % SuffixModulus;

            return GuestUsernamePrefix + suffix.ToString("D4");
        }
    }
}
