using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DTO;

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

        public UserLoginService(IUserLoginUseCase userLoginUseCase)
        {
            if (userLoginUseCase == null)
            {
                throw new ArgumentNullException(nameof(userLoginUseCase));
            }

            _userLoginUseCase = userLoginUseCase;
        }

        public void Login(string email, string password)
        {
            AuthenticatedUserData user = _userLoginUseCase.AuthenticateUser(email, password);
            bool isLoginSuccessful = user != null;
            User userDto = null;
            string responseMessage;

            if (isLoginSuccessful)
            {
                responseMessage = LoginSuccessMessage;
                userDto = new User
                {
                    IdUser = user.IdUser,
                    Username = user.Username,
                    Email = user.Email
                };
            }
            else
            {
                responseMessage = InvalidCredentialsMessage;
            }

            OperationContext.Current
                .GetCallbackChannel<IUserLoginCallback>()
                .LoginResult(isLoginSuccessful, responseMessage, userDto);
        }
    }
}
