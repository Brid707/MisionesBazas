using System;

using Application.Models;
using Application.Ports;
using Domain;

namespace Application.UseCases
{
    /// <summary>
    /// Coordinates user account registration workflows and validation against the persistence port.
    /// </summary>
    public sealed class AccountManagementUseCase : IAccountManagementUseCase
    {
        private const int ErrorCodeSuccess = 0;
        private const int ErrorCodePermanentlyBlockedEmail = 1022;
        private const int ErrorCodeValidationFailed = 101;
        private const int ErrorCodeEmailAlreadyRegistered = 1019;
        private const int ErrorCodeUsernameAlreadyRegistered = 1020;
        private const int ErrorCodePersistenceFailure = 201;

        private const byte ActiveUserStatus = 1;

        private const string MessageSuccess = "User registered successfully.";
        private const string MessageValidationFailed = "One or more registration fields failed validation.";
        private const string MessageEmailAlreadyRegistered = "The provided email is already registered.";
        private const string MessageUsernameAlreadyRegistered = "The provided username is already registered.";
        private const string MessagePersistenceFailure = "A database error occurred while registering the user.";

        private readonly IUserRepository _userRepository;
        private readonly IBlockedAccountEmailRepository _blockedAccountEmailRepository;

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountManagementUseCase"/> class with the user repository.
        /// </summary>
        /// <param name="userRepository">The secondary port for user data persistence.</param>
        /// <param name="blockedAccountEmailRepository">The persistent restriction check
        /// for registration emails.</param>
        public AccountManagementUseCase(IUserRepository userRepository,
            IBlockedAccountEmailRepository blockedAccountEmailRepository)
        {
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _blockedAccountEmailRepository = blockedAccountEmailRepository;
        }

        /// <inheritdoc />
        public UserRegistrationOutcome RegisterUser(string username, string email, string passwordHash)
        {
            UserRegistrationOutcome registrationOutcome;

            string normalizedUsername = username?.Trim() ?? string.Empty;
            string normalizedEmail = email?.Trim() ?? string.Empty;
            string normalizedPasswordHash = passwordHash?.Trim() ?? string.Empty;

            if (!IsInputValid(normalizedUsername, normalizedEmail, normalizedPasswordHash))
            {
                registrationOutcome = CreateRegistrationOutcome(
                false, ErrorCodeValidationFailed, MessageValidationFailed);
            }
            else
            {
                registrationOutcome = ProcessRegistration(normalizedUsername, normalizedEmail, normalizedPasswordHash);
            }

            return registrationOutcome;
        }

        private bool IsInputValid(string username, string email, string passwordHash)
        {
            return UserAccountRules.IsUsernameValid(username) &&
                   UserAccountRules.IsEmailValid(email) &&
                   UserAccountRules.IsPasswordHashValid(passwordHash);
        }

        private UserRegistrationOutcome ProcessRegistration(string username, string email, string passwordHash)
        {
            UserRegistrationOutcome registrationOutcome;

            try
            {
                if (_blockedAccountEmailRepository.IsAccountEmailPermanentlyBlocked(email))
                {
                    registrationOutcome = CreateRegistrationOutcome(
                    false, ErrorCodePermanentlyBlockedEmail, "AccountEmailPermanentlyBlocked");
                }
                else
                {
                    registrationOutcome = RegisterUnblockedEmail(username, email, passwordHash);
                }
            }
            catch (InvalidOperationException)
            {
                registrationOutcome = CreateRegistrationOutcome(
                false, ErrorCodePersistenceFailure, MessagePersistenceFailure);
            }

            return registrationOutcome;
        }

        private UserRegistrationOutcome RegisterUnblockedEmail(string username, string email, string passwordHash)
        {
            UserRegistrationOutcome registrationOutcome;
            if (_userRepository.GetUserByEmail(email) != null)
            {
                registrationOutcome = CreateRegistrationOutcome(
                    false, ErrorCodeEmailAlreadyRegistered, MessageEmailAlreadyRegistered);
            }
            else if (_userRepository.GetUserByUsername(username) != null)
            {
                registrationOutcome = CreateRegistrationOutcome(false, ErrorCodeUsernameAlreadyRegistered,
                    MessageUsernameAlreadyRegistered);
            }
            else
            {
                registrationOutcome = PersistNewUser(username, email, passwordHash);
            }

            return registrationOutcome;
        }

        private UserRegistrationOutcome PersistNewUser(string username, string email, string passwordHash)
        {
            UserAccount newUser = new UserAccount
            {
                Username = username,
                Email = email,
                PasswordHash = passwordHash,
                Status = ActiveUserStatus,
                CreatedAt = DateTime.UtcNow
            };

            int createdUserId = _userRepository.CreateUser(newUser, username);
            UserRegistrationOutcome registrationOutcome = CreateRegistrationOutcome(
                true, ErrorCodeSuccess, MessageSuccess);
            registrationOutcome.CreatedUserId = createdUserId;
            return registrationOutcome;
        }

        private static UserRegistrationOutcome CreateRegistrationOutcome(bool isSuccess, int errorCode, string message)
        {
            return new UserRegistrationOutcome
            {
                IsSuccess = isSuccess,
                ErrorCode = errorCode,
                Message = message
            };
        }
    }
}
