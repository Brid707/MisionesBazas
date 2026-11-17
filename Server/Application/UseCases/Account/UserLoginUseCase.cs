using System;

using Application.Models;
using Application.Ports;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Application
{
    /// <summary>
    /// Orchestrates authentication operations for users, implementing the <see cref="IUserLoginUseCase"/> port.
    /// </summary>
    public sealed class UserLoginUseCase : IUserLoginUseCase
    {
        private const string LoginRejectedInvalidParametersTemplate =
            "Authentication rejected due to missing or empty credentials.";
        private const string LoginRejectedUserNotFoundTemplate =
            "Authentication failed: no account exists with email {Email}.";
        private const string LoginRejectedInvalidCredentialsTemplate =
            "Authentication failed: invalid password credentials provided for email {Email}.";
        private const string UserAuthenticatedSuccessfullyTemplate =
            "User {Username} (id {UserId}) authenticated successfully.";

        private readonly IUserRepository _userRepository;
        private readonly ILoggerService _logger;

        public UserLoginUseCase(IUserRepository userRepository, ILoggerService logger)
        {
            if (userRepository == null)
            {
                throw new ArgumentNullException(nameof(userRepository));
            }

            _userRepository = userRepository;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public AuthenticatedUserData AuthenticateUser(string email, string passwordHash)
        {
            AuthenticatedUserData authenticatedUser = null;

            if (IsValidParameter(email) && IsValidParameter(passwordHash))
            {
                UserAccount user = _userRepository.GetUserByEmail(email);
                if (user == null)
                {
                    _logger.Warning(LoginRejectedUserNotFoundTemplate, email);
                }
                else if (!string.Equals(user.PasswordHash, passwordHash, StringComparison.OrdinalIgnoreCase))
                {
                    _logger.Warning(LoginRejectedInvalidCredentialsTemplate, email);
                }
                else
                {
                    _userRepository.UpdateLastLogin(user.IdUser);
                    _logger.Information(UserAuthenticatedSuccessfullyTemplate, user.Username, user.IdUser);
                    authenticatedUser = new AuthenticatedUserData
                    {
                        IdUser = user.IdUser,
                        Username = user.Username,
                        Email = user.Email
                    };
                }
            }
            else
            {
                _logger.Warning(LoginRejectedInvalidParametersTemplate);
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
