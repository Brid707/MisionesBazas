using System;
using System.Security.Cryptography;
using System.Text;

namespace Model.Security
{
    /// <summary>
    /// Utility class for cryptographic hashing of sensitive user credentials.
    /// </summary>
    public static class PasswordHasher
    {
        /// <summary>
        /// Computes a hexadecimal SHA-256 hash string for the provided plain text.
        /// </summary>
        /// <param name="rawData">The plain text string to hash.</param>
        /// <returns>A lower-case hexadecimal string representing the SHA-256 hash, or an empty string if rawData is null.</returns>
        public static string ComputeSha256Hash(string rawData)
        {
            string hashResult = string.Empty;

            if (rawData != null)
            {
                using (SHA256 sha256 = SHA256.Create())
                {
                    byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                    StringBuilder stringBuilder = new StringBuilder();

                    for (int byteIndex = 0; byteIndex < bytes.Length; byteIndex++)
                    {
                        stringBuilder.Append(bytes[byteIndex].ToString("x2"));
                    }

                    hashResult = stringBuilder.ToString();
                }
            }

            return hashResult;
        }
    }
}
