using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DataContracts;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Services.Services
{
    /// <summary>
    /// Implements the <see cref="IAccountManagementService"/> WCF contract for user registration and account operations.
    /// </summary>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public sealed class AccountManagementService : IAccountManagementService
    {
        private const int ErrorCodeValidationFailed = 101;
        private const int ErrorCodeInternalFault = 201;

        private const string MessageNullPayload = "User registration payload cannot be null.";
        private const string MessageUnexpectedFault = "An unexpected server fault occurred while processing" +
            " registration.";

        private const string RegisterUserNullPayloadTemplate =
            "User registration request rejected: payload is null.";
        private const string UnexpectedRegistrationFaultTemplate =
            "Unexpected server fault during registration for username {Username} (Email: {Email}).";

        private readonly IAccountManagementUseCase _accountManagementUseCase;
        private readonly ILoggerService _logger;

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountManagementService"/> class with the account use case.
        /// </summary>
        /// <param name="accountManagementUseCase">The use case orchestrating account operations.</param>
        /// <param name="logger">The logger used to record service operations and faults.</param>
        public AccountManagementService(IAccountManagementUseCase accountManagementUseCase, ILoggerService logger)
        {
            _accountManagementUseCase = accountManagementUseCase ??
                throw new ArgumentNullException(nameof(accountManagementUseCase));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <inheritdoc />
        public OperationResult RegisterUser(UserRegister user)
        {
            OperationResult result;

            if (user == null)
            {
                _logger.Warning(RegisterUserNullPayloadTemplate);
                result = new OperationResult
                {
                    IsSuccess = false,
                    ErrorCode = ErrorCodeValidationFailed,
                    Message = MessageNullPayload
                };
            }
            else
            {
                try
                {
                    UserRegistrationOutcome outcome = _accountManagementUseCase.RegisterUser(
                        user.Username,
                        user.Email,
                        user.PasswordHash);

                    result = new OperationResult
                    {
                        IsSuccess = outcome.IsSuccess,
                        ErrorCode = outcome.ErrorCode,
                        Message = outcome.Message
                    };
                }
                catch (InvalidOperationException ex)
                {
                    result = HandleRegistrationFault(ex, user);
                }
                catch (TimeoutException ex)
                {
                    result = HandleRegistrationFault(ex, user);
                }
            }

            return result;
        }

        private OperationResult HandleRegistrationFault(Exception ex, UserRegister user)
        {
            _logger.Error(ex, UnexpectedRegistrationFaultTemplate, user.Username, user.Email);
            return new OperationResult
            {
                IsSuccess = false,
                ErrorCode = ErrorCodeInternalFault,
                Message = MessageUnexpectedFault
            };
        }
    }
}
