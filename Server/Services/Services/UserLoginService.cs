using System.Data.SqlClient;
using System.ServiceModel;
using System;

using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DataContracts;

namespace Services.Services
{
    /// <summary>
    /// Service implementation for user authentication and login operations via WCF.
    /// </summary>
    [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public sealed class UserLoginService : IUserLoginService
    {
        private const string LoginSuccessMessage = "Login successful.";
        private const string InvalidCredentialsMessage = "Invalid email or password.";

        private readonly IUserLoginUseCase _userLoginUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;

        public UserLoginService(IUserLoginUseCase userLoginUseCase, IAccountAccessPolicy accountAccessPolicy)
        {
            if (userLoginUseCase == null)
            {
                throw new ArgumentNullException(nameof(userLoginUseCase));
            }

            _userLoginUseCase = userLoginUseCase;
            _accountAccessPolicy = accountAccessPolicy;
        }

        public void Login(string email, string password)
        {
            try
            {
                AuthenticateAndNotifyAccount(email, password);
            }
            catch (SqlException)
            {
                OperationContext.Current.GetCallbackChannel<IUserLoginCallback>()
                    .LoginResult(false, "ChatStorageUnavailable", null);
            }
        }

        private void AuthenticateAndNotifyAccount(string email, string password)
        {
            AuthenticatedUserData user = _userLoginUseCase.AuthenticateUser(email, password);
            string accountSessionToken = null;
            if (user != null)
            {
                accountSessionToken = _accountAccessPolicy.CreateAllowedAccountSession(user.IdUser);
            }

            bool isLoginSuccessful = !string.IsNullOrEmpty(accountSessionToken);
            User userDto = null;
            string responseMessage;

            if (isLoginSuccessful)
            {
                responseMessage = LoginSuccessMessage;
                userDto = new User
                {
                    IdUser = user.IdUser,
                    Username = user.Username,
                    Email = user.Email,
                    AccountSessionToken = accountSessionToken
                };
            }
            else
            {
                responseMessage = InvalidCredentialsMessage;
                if (user != null)
                {
                    responseMessage = "ChatAccountBanned";
                }
            }

            OperationContext.Current
                .GetCallbackChannel<IUserLoginCallback>()
                .LoginResult(isLoginSuccessful, responseMessage, userDto);
        }
    }
}
