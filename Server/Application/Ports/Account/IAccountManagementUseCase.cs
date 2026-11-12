using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Defines the inbound application port for managing user accounts, including registration.
    /// </summary>
    public interface IAccountManagementUseCase
    {
        /// <summary>
        /// Registers a new user account with initial profile and experience state.
        /// </summary>
        /// <param name="username">The requested unique username.</param>
        /// <param name="email">The email address of the new user.</param>
        /// <param name="passwordHash">The pre-hashed password credential.</param>
        /// <returns>A <see cref="UserRegistrationOutcome"/> summarizing the result of the registration attempt.</returns>
        UserRegistrationOutcome RegisterUser(string username, string email, string passwordHash);
    }
}
