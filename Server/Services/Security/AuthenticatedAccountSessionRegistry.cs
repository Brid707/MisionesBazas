using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Security.Cryptography;
using System;

using Application.Ports;

namespace Services.Security
{
    /// <summary>Stores unpredictable account tokens in server memory; server restarts require a new login.</summary>
    public sealed class AuthenticatedAccountSessionRegistry : IAuthenticatedAccountSessionRegistry
    {
        private const int AccountSessionTokenByteCount = 32;
        private const int AccountSessionLifetimeHours = 12;
        private readonly ConcurrentDictionary<string, AuthenticatedAccountSession> _authenticatedAccountSessions =
            new ConcurrentDictionary<string, AuthenticatedAccountSession>(StringComparer.Ordinal);

        public string CreateAccountSession(int accountUserId)
        {
            RemoveExpiredAccountSessions();
            byte[] accountSessionTokenBytes = new byte[AccountSessionTokenByteCount];
            using (RandomNumberGenerator accountSessionTokenGenerator = RandomNumberGenerator.Create())
            {
                accountSessionTokenGenerator.GetBytes(accountSessionTokenBytes);
            }

            string accountSessionToken = Convert.ToBase64String(accountSessionTokenBytes);
            _authenticatedAccountSessions[accountSessionToken] = new AuthenticatedAccountSession
            {
                AccountUserId = accountUserId,
                AccountSessionExpiresAtUtc = DateTime.UtcNow.AddHours(AccountSessionLifetimeHours)
            };
            return accountSessionToken;
        }

        public int ResolveAccountUserId(string accountSessionToken)
        {
            int accountUserId = 0;
            if (!string.IsNullOrEmpty(accountSessionToken) &&
                _authenticatedAccountSessions.TryGetValue(accountSessionToken,
                    out AuthenticatedAccountSession accountSession))
            {
                if (accountSession.AccountSessionExpiresAtUtc > DateTime.UtcNow)
                {
                    accountUserId = accountSession.AccountUserId;
                }
                else
                {
                    _authenticatedAccountSessions.TryRemove(accountSessionToken, out AuthenticatedAccountSession _);
                }
            }

            return accountUserId;
        }

        public void RevokeAccountSessions(int accountUserId)
        {
            foreach (KeyValuePair<string, AuthenticatedAccountSession> accountSession in _authenticatedAccountSessions)
            {
                if (accountSession.Value.AccountUserId == accountUserId)
                {
                    _authenticatedAccountSessions.TryRemove(accountSession.Key, out AuthenticatedAccountSession _);
                }
            }
        }

        private void RemoveExpiredAccountSessions()
        {
            foreach (KeyValuePair<string, AuthenticatedAccountSession> accountSession in _authenticatedAccountSessions)
            {
                if (accountSession.Value.AccountSessionExpiresAtUtc <= DateTime.UtcNow)
                {
                    _authenticatedAccountSessions.TryRemove(accountSession.Key, out AuthenticatedAccountSession _);
                }
            }
        }
    }
}
