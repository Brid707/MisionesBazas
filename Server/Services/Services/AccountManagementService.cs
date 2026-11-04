using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DTO;

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
        private const string MessageUnexpectedFault = "An unexpected server fault occurred while processing registration.";

        private readonly IAccountManagementUseCase _accountManagementUseCase;

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountManagementService"/> class with the account use case.
        /// </summary>
        /// <param name="accountManagementUseCase">The use case orchestrating account operations.</param>
        public AccountManagementService(IAccountManagementUseCase accountManagementUseCase)
        {
            _accountManagementUseCase = accountManagementUseCase ?? throw new ArgumentNullException(nameof(accountManagementUseCase));
        }

        /// <inheritdoc />
        public OperationResult RegisterUser(UserRegister user)
        {
            OperationResult result;

            if (user == null)
            {
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
                catch (Exception)
                {
                    result = new OperationResult
                    {
                        IsSuccess = false,
                        ErrorCode = ErrorCodeInternalFault,
                        Message = MessageUnexpectedFault
                    };
                }
            }

            return result;
        }
    }
}
