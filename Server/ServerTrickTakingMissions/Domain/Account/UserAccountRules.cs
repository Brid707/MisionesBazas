using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace Domain
{
    /// <summary>
    /// Encapsulates pure domain rules for validating user account registration credentials and constraints.
    /// </summary>
    public static class UserAccountRules
    {
        public const int MinimumUsernameLength = 3;
        public const int MaximumUsernameLength = 50;
        public const int MaximumEmailLength = 150;
        public const int Sha256HashLength = 64;

        private const string UsernamePattern = @"^[a-zA-Z0-9_\-]+$";
        private const string EmailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";

        /// <summary>
        /// Validates that a username complies with domain length and allowed character rules.
        /// </summary>
        /// <param name="username">The username to evaluate.</param>
        /// <returns>True if the username complies with all invariants; otherwise, false.</returns>
        public static bool IsUsernameValid(string username)
        {
            bool isValid = false;

            if (!string.IsNullOrWhiteSpace(username))
            {
                string trimmedUsername = username.Trim();
                if (trimmedUsername.Length >= MinimumUsernameLength &&
                    trimmedUsername.Length <= MaximumUsernameLength &&
                    Regex.IsMatch(trimmedUsername, UsernamePattern))
                {
                    isValid = true;
                }
            }

            return isValid;
        }

        /// <summary>
        /// Validates that an email string matches the domain formatting and length rules.
        /// </summary>
        /// <param name="email">The email string to evaluate.</param>
        /// <returns>True if the email matches length and format requirements; otherwise, false.</returns>
        public static bool IsEmailValid(string email)
        {
            bool isValid = false;

            if (!string.IsNullOrWhiteSpace(email))
            {
                string trimmedEmail = email.Trim();
                if (trimmedEmail.Length <= MaximumEmailLength &&
                    Regex.IsMatch(trimmedEmail, EmailPattern))
                {
                    isValid = true;
                }
            }

            return isValid;
        }

        /// <summary>
        /// Validates that the password hash represents a valid 64-character hexadecimal SHA-256 digest.
        /// </summary>
        /// <param name="passwordHash">The hexadecimal hash string to evaluate.</param>
        /// <returns>True if the hash is non-empty and contains exactly 64 hexadecimal characters; otherwise, false.</returns>
        public static bool IsPasswordHashValid(string passwordHash)
        {
            bool isValid = false;

            if (!string.IsNullOrWhiteSpace(passwordHash))
            {
                string trimmedHash = passwordHash.Trim();
                if (trimmedHash.Length == Sha256HashLength &&
                    trimmedHash.All(Uri.IsHexDigit))
                {
                    isValid = true;
                }
            }

            return isValid;
        }
    }
}
