using System.ServiceModel;
using Application;
using Services.Contracts;
using Services.DTO;

namespace Services.Services
{
    /// <summary>
    /// Service implementation for user authentication and login operations via WCF.
    /// </summary>
    [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public sealed class UserLoginService : IUserLogin
    {
        private const string LoginSuccessMessage = "Login successful.";
        private const string InvalidCredentialsMessage = "Invalid email or password.";

        private readonly UserLoginUseCase _userLoginUseCase;

        /// <summary>
        /// Initializes a new instance of the <see cref="UserLoginService"/> class.
        /// </summary>
        public UserLoginService()
        {
            _userLoginUseCase = new UserLoginUseCase();
        }

        /// <summary>
        /// Attempts to authenticate a user with the specified email and hashed password.
        /// </summary>
        /// <param name="email">The user's email address.</param>
        /// <param name="password">The user's hashed password.</param>
        public void Login(string email, string password)
        {
            Application.Models.AuthenticatedUserData user = _userLoginUseCase.AuthenticateUser(email, password);
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
