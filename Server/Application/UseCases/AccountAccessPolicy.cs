using System;

using Application.Ports;
using Domain;

namespace Application
{
    /// <summary>
    /// Combines server-issued sessions with persisted account sanctions for account access decisions.
    /// </summary>
    public sealed class AccountAccessPolicy : IAccountAccessPolicy
    {
        private readonly IAuthenticatedAccountSessionRegistry _accountSessionRegistry;
        private readonly IChatInfractionRepository _chatInfractionRepository;

        public AccountAccessPolicy(IAuthenticatedAccountSessionRegistry accountSessionRegistry,
            IChatInfractionRepository chatInfractionRepository)
        {
            _accountSessionRegistry = accountSessionRegistry;
            _chatInfractionRepository = chatInfractionRepository;
        }

        public string CreateAllowedAccountSession(int accountUserId)
        {
            string accountSessionToken = null;
            if (!ChatInfractionRules.IsAccountBanned(
                _chatInfractionRepository.GetAccountInfractionState(accountUserId), DateTime.UtcNow))
            {
                accountSessionToken = _accountSessionRegistry.CreateAccountSession(accountUserId);
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
                accountUserId = 0;
            }

            return accountUserId;
        }

        public void RevokeAccountSessions(int accountUserId)
        {
            _accountSessionRegistry.RevokeAccountSessions(accountUserId);
        }
    }
}
