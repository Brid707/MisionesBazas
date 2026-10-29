using System;
using Application.Models;
using Application.Ports;

namespace Application
{
    /// <summary>
    /// Orchestrates authentication operations for users, implementing the <see cref="IUserLoginUseCase"/> port.
    /// </summary>
    public sealed class UserLoginUseCase : IUserLoginUseCase
    {
        private readonly IUserRepository _userRepository;

        public UserLoginUseCase(IUserRepository userRepository)
        {
            if (userRepository == null)
            {
                throw new ArgumentNullException(nameof(userRepository));
            }

            _userRepository = userRepository;
        }

        public AuthenticatedUserData AuthenticateUser(string email, string passwordHash)
        {
            AuthenticatedUserData authenticatedUser = null;

            if (IsValidParameter(email) && IsValidParameter(passwordHash))
            {
                try
                {
                    UserAccount user = _userRepository.GetUserByEmail(email);
                    if (user != null &&
                        string.Equals(user.PasswordHash, passwordHash, StringComparison.OrdinalIgnoreCase))
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
