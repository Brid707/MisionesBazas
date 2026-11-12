using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.ServiceModel;

namespace Services.Security
{
    /// <summary>Requires a private credential to reclaim an existing guest identity on another channel.</summary>
    internal static class GuestParticipantCredentials
    {
        private const int MaximumGuestSessions = 4096;
        private static readonly Dictionary<int, string> s_credentialsByGuestId = new Dictionary<int, string>();

        internal static void EnsureGuestAllowed(int guestUserId)
        {
            string presentedCredential = AccountSessionHeader.ReadCurrentAccountSessionToken();
            lock (s_credentialsByGuestId)
            {
                if (s_credentialsByGuestId.TryGetValue(guestUserId, out string expectedCredential))
                {
                    if (!string.Equals(expectedCredential, presentedCredential, StringComparison.Ordinal))
                    {
                        throw new FaultException("ParticipantNotAllowed");
                    }
                }
                else
                {
                    if (s_credentialsByGuestId.Count >= MaximumGuestSessions)
                    {
                        throw new FaultException("GuestCapacityReached");
                    }
                    s_credentialsByGuestId.Add(guestUserId, CreateCredential());
                }
            }
        }

        internal static string GetCredential(int guestUserId)
        {
            string guestCredential;
            lock (s_credentialsByGuestId)
            {
                s_credentialsByGuestId.TryGetValue(guestUserId, out guestCredential);
            }
            return guestCredential;
        }

        private static string CreateCredential()
        {
            var credentialBytes = new byte[32];
            using (RandomNumberGenerator randomGenerator = RandomNumberGenerator.Create())
            {
                randomGenerator.GetBytes(credentialBytes);
            }
            return Convert.ToBase64String(credentialBytes);
        }
    }
}
