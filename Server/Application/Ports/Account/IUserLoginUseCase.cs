using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Defines the primary driving port for user authentication and login operations.
    /// </summary>
    public interface IUserLoginUseCase
    {
        /// <summary>
        /// Authenticates a user given their email address and hashed password.
        /// </summary>
        /// <param name="email">The user's registered email address.</param>
        /// <param name="passwordHash">The SHA-256 hash of the password.</param>
        /// <returns>An <see cref="AuthenticatedUserData"/> object if credentials match; otherwise, null.</returns>
        AuthenticatedUserData AuthenticateUser(string email, string passwordHash);

        /// <summary>
        /// Verifies whether the provided credentials correspond to an authentic user.
        /// </summary>
        /// <param name="email">The user's email address.</param>
        /// <param name="passwordHash">The hashed password.</param>
        /// <returns>True if authentication succeeds; otherwise, false.</returns>
        bool IsLoginSuccessful(string email, string passwordHash);
    }
}
