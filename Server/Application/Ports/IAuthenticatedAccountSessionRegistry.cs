namespace Application.Ports
{
    /// <summary>
    /// Issues and resolves application sessions without trusting client-supplied account identifiers.
    /// </summary>
    public interface IAuthenticatedAccountSessionRegistry
    {
        string CreateAccountSession(int accountUserId);

        int ResolveAccountUserId(string accountSessionToken);

        void RevokeAccountSessions(int accountUserId);
    }
}
