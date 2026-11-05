using System;


namespace Services.Security
{
    /// <summary>Associates a server-issued token with its authenticated account and UTC expiration.</summary>
    internal sealed class AuthenticatedAccountSession
    {
        public int AccountUserId { get; set; }

        public DateTime AccountSessionExpiresAtUtc { get; set; }
    }
}
