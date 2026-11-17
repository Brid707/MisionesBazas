using System;

using Application.Ports;
using Domain;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Application
{
    /// <summary>
    /// Combines server-issued sessions with persisted account sanctions for account access decisions.
    /// </summary>
    public sealed class AccountAccessPolicy : IAccountAccessPolicy
    {
        private const string SessionCreatedTemplate =
            "Account session created successfully for user {UserId}.";
        private const string SessionCreationRejectedBannedAccountTemplate =
            "Account session creation rejected because user {UserId} has an active ban.";
        private const string OperationRejectedBannedAccountTemplate =
            "Account operation rejected because user {UserId} has an active ban.";
        private const string SessionsRevokedTemplate =
            "Account sessions revoked for user {UserId}.";

        private readonly IAuthenticatedAccountSessionRegistry _accountSessionRegistry;
        private readonly IChatInfractionRepository _chatInfractionRepository;
        private readonly ILoggerService _logger;

        public AccountAccessPolicy(IAuthenticatedAccountSessionRegistry accountSessionRegistry,
            IChatInfractionRepository chatInfractionRepository, ILoggerService logger)
        {
            _accountSessionRegistry = accountSessionRegistry;
            _chatInfractionRepository = chatInfractionRepository;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public ChatAccountInfractionState GetAccountBanState(int accountUserId)
        {
            return _chatInfractionRepository.GetAccountInfractionState(accountUserId);
        }

        public string CreateAllowedAccountSession(int accountUserId)
        {
            string accountSessionToken = null;
            if (!ChatInfractionRules.IsAccountBanned(
                _chatInfractionRepository.GetAccountInfractionState(accountUserId), DateTime.UtcNow))
            {
                accountSessionToken = _accountSessionRegistry.CreateAccountSession(accountUserId);
                _logger.Information(SessionCreatedTemplate, accountUserId);
            }
            else
            {
                _logger.Warning(SessionCreationRejectedBannedAccountTemplate, accountUserId);
            }

            return accountSessionToken;
        }

        public bool IsAccountOperationAllowed(int accountUserId, string accountSessionToken)
        {
            return accountUserId > 0 && ResolveAllowedAccountUserId(accountSessionToken) == accountUserId;
        }

        public int ResolveAllowedAccountUserId(string accountSessionToken)
        {
            int accountUserId = _accountSessionRegistry.ResolveAccountUserId(accountSessionToken);
            if (accountUserId > 0 && ChatInfractionRules.IsAccountBanned(
                _chatInfractionRepository.GetAccountInfractionState(accountUserId), DateTime.UtcNow))
            {
                _logger.Warning(OperationRejectedBannedAccountTemplate, accountUserId);
                accountUserId = 0;
            }

            return accountUserId;
        }

        public void RevokeAccountSessions(int accountUserId)
        {
            _accountSessionRegistry.RevokeAccountSessions(accountUserId);
            _logger.Information(SessionsRevokedTemplate, accountUserId);
        }
    }
}
