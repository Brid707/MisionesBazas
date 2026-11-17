using System;
using System.ServiceModel;

using Application.Models;
using Application.Ports;
using Domain;
using Services.Contracts;
using Services.DataContracts;
using TrickTakingMissions.Logging.Abstractions.Ports;

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
        private const string MessageStorageUnavailable = "ChatStorageUnavailable";
        private const string MessageChatAccountBanned = "ChatAccountBanned";

        private const string LoginPersistenceFailureTemplate =
            "Storage error occurred during authentication for email {Email}.";
        private const string LoginCallbackCommunicationFailureTemplate =
            "Login callback communication faulted for email {Email}.";
        private const string LoginCallbackTimeoutFailureTemplate =
            "Login callback timed out for email {Email}.";

        private readonly IUserLoginUseCase _userLoginUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;
        private readonly ILoggerService _logger;

        public UserLoginService(IUserLoginUseCase userLoginUseCase, IAccountAccessPolicy accountAccessPolicy,
            ILoggerService logger)
        {
            if (userLoginUseCase == null)
            {
                throw new ArgumentNullException(nameof(userLoginUseCase));
            }

            _userLoginUseCase = userLoginUseCase;
            _accountAccessPolicy = accountAccessPolicy ?? throw new ArgumentNullException(nameof(accountAccessPolicy));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public void Login(string email, string password)
        {
            try
            {
                AuthenticateAndNotifyAccount(email, password);
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, LoginPersistenceFailureTemplate, email);
                NotifyLoginStorageFailure(email);
            }
            catch (TimeoutException ex)
            {
                _logger.Error(ex, LoginPersistenceFailureTemplate, email);
                NotifyLoginStorageFailure(email);
            }
        }

        private void NotifyLoginStorageFailure(string email)
        {
            SafeNotifyLoginResult(email, false, MessageStorageUnavailable, null);
        }

        private void SafeNotifyLoginResult(string email, bool isLoginSuccessful, string responseMessage, User user)
        {
            try
            {
                OperationContext.Current?
                    .GetCallbackChannel<IUserLoginCallback>()?
                    .LoginResult(isLoginSuccessful, responseMessage, user);
            }
            catch (CommunicationException)
            {
                _logger.Warning(LoginCallbackCommunicationFailureTemplate, email);
            }
            catch (TimeoutException)
            {
                _logger.Warning(LoginCallbackTimeoutFailureTemplate, email);
            }
        }

        private User CreateRestrictedLoginNotice(int accountUserId)
        {
            ChatAccountInfractionState accountBanState = _accountAccessPolicy.GetAccountBanState(accountUserId);
            ChatAccountBanType accountBanType = ChatAccountBanType.Temporary;
            if (accountBanState.IsChatAccountPermanentlyBanned)
            {
                accountBanType = ChatAccountBanType.Permanent;
            }

            return new User
            {
                ChatAccountBanNotice = new ChatAccountBanNotice
                {
                    ChatAccountBanType = accountBanType,
                    ChatAccountBanEndsAtUtc = accountBanState.ChatAccountBanEndsAtUtc,
                    EvaluatedAtUtc = DateTime.UtcNow
                }
            };
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
                    responseMessage = MessageChatAccountBanned;
                    userDto = CreateRestrictedLoginNotice(user.IdUser);
                }
            }

            SafeNotifyLoginResult(email, isLoginSuccessful, responseMessage, userDto);
        }
    }
}
