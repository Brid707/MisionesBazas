using System;
using Application.Models;
using Persistence.Entities;
using Persistence.Repository;

namespace Application
{
    /// <summary>
    /// Encapsulates the business logic and orchestrates authentication operations for users.
    /// </summary>
    public sealed class UserLoginUseCase
    {
        private readonly UserRepository _userRepository;

        /// <summary>
        /// Initializes a new instance of the <see cref="UserLoginUseCase"/> class.
        /// </summary>
        public UserLoginUseCase()
        {
            _userRepository = new UserRepository();
        }

        /// <summary>
        /// Authenticates a user given their email address and hashed password.
        /// </summary>
        /// <param name="email">The user's registered email address.</param>
        /// <param name="passwordHash">The SHA-256 hash of the password.</param>
        /// <returns>An <see cref="AuthenticatedUserData"/> object if credentials match; otherwise, null.</returns>
        public AuthenticatedUserData AuthenticateUser(string email, string passwordHash)
        {
            AuthenticatedUserData authenticatedUser = null;

            if (IsValidParameter(email) && IsValidParameter(passwordHash))
            {
                try
                {
                    User user = _userRepository.GetUserByEmail(email);
                    if (user != null && string.Equals(user.PasswordHash, passwordHash, StringComparison.OrdinalIgnoreCase))
                    {
                        _userRepository.UpdateLastLogin(user.IdUser);
                        authenticatedUser = new AuthenticatedUserData
                        {
                            IdUser = user.IdUser,
                            Username = user.Username,
                            Email = user.Email
                        };
                    }
                }
                catch (InvalidOperationException)
                {
                    // TODO: Implement logging for the exception once logging infrastructure is available.
                    authenticatedUser = null;
                }
            }

            return authenticatedUser;
        }

        /// <summary>
        /// Verifies whether the provided credentials correspond to an authentic user.
        /// </summary>
        /// <param name="email">The user's email address.</param>
        /// <param name="passwordHash">The hashed password.</param>
        /// <returns>True if authentication succeeds; otherwise, false.</returns>
        public bool IsLoginSuccessful(string email, string passwordHash)
        {
            AuthenticatedUserData user = AuthenticateUser(email, passwordHash);
            return user != null;
        }

        private bool IsValidParameter(string parameter)
        {
            return !string.IsNullOrWhiteSpace(parameter);
        }
    }
}
