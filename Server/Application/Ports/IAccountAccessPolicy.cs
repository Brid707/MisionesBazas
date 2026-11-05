namespace Application.Ports
{
    /// <summary>
    /// Checks persisted account bans and authenticated sessions before permitting protected operations.
    /// </summary>
    public interface IAccountAccessPolicy
    {
        string CreateAllowedAccountSession(int accountUserId);

        bool IsAccountOperationAllowed(int accountUserId, string accountSessionToken);

        int ResolveAllowedAccountUserId(string accountSessionToken);

        void RevokeAccountSessions(int accountUserId);
    }
}
