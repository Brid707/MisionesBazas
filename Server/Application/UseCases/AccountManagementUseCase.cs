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

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountManagementUseCase"/> class with the user repository.
        /// </summary>
        /// <param name="userRepository">The secondary port for user data persistence.</param>
        public AccountManagementUseCase(IUserRepository userRepository)
        {
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
        }

        /// <inheritdoc />
        public UserRegistrationOutcome RegisterUser(string username, string email, string passwordHash)
        {
            UserRegistrationOutcome outcome;

            string normalizedUsername = username?.Trim() ?? string.Empty;
            string normalizedEmail = email?.Trim() ?? string.Empty;
            string normalizedPasswordHash = passwordHash?.Trim() ?? string.Empty;

            if (!IsInputValid(normalizedUsername, normalizedEmail, normalizedPasswordHash))
            {
                outcome = CreateOutcome(false, ErrorCodeValidationFailed, MessageValidationFailed, null);
            }
            else
            {
                outcome = ProcessRegistration(normalizedUsername, normalizedEmail, normalizedPasswordHash);
            }

            return outcome;
        }

        private bool IsInputValid(string username, string email, string passwordHash)
        {
            return UserAccountRules.IsUsernameValid(username) &&
                   UserAccountRules.IsEmailValid(email) &&
                   UserAccountRules.IsPasswordHashValid(passwordHash);
        }

        private UserRegistrationOutcome ProcessRegistration(string username, string email, string passwordHash)
        {
            UserRegistrationOutcome outcome;

            try
            {
                UserAccount existingEmailUser = _userRepository.GetUserByEmail(email);
                if (existingEmailUser != null)
                {
                    outcome = CreateOutcome(false, ErrorCodeEmailAlreadyRegistered, MessageEmailAlreadyRegistered, null);
                }
                else
                {
                    UserAccount existingUsernameUser = _userRepository.GetUserByUsername(username);
                    if (existingUsernameUser != null)
                    {
                        outcome = CreateOutcome(false, ErrorCodeUsernameAlreadyRegistered, MessageUsernameAlreadyRegistered, null);
                    }
                    else
                    {
                        outcome = PersistNewUser(username, email, passwordHash);
                    }
                }
            }
            catch (InvalidOperationException)
            {
                outcome = CreateOutcome(false, ErrorCodePersistenceFailure, MessagePersistenceFailure, null);
            }

            return outcome;
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
            return CreateOutcome(true, ErrorCodeSuccess, MessageSuccess, createdUserId);
        }

        private static UserRegistrationOutcome CreateOutcome(bool isSuccess, int errorCode, string message, int? createdUserId)
        {
            return new UserRegistrationOutcome
            {
                IsSuccess = isSuccess,
                ErrorCode = errorCode,
                Message = message,
                CreatedUserId = createdUserId
            };
        }
    }
}
