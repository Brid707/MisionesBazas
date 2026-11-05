using System.ServiceModel.Channels;
using System.ServiceModel;


namespace Services.Security
{
    /// <summary>Reads the application session credential attached to a WCF request.</summary>
    internal static class AccountSessionHeader
    {
        private const string AccountSessionHeaderName = "AccountSessionToken";
        private const string AccountSessionHeaderNamespace = "urn:misiones-bazas:account-session";

        public static string ReadCurrentAccountSessionToken()
        {
            string accountSessionToken = null;
            if (OperationContext.Current != null)
            {
                MessageHeaders incomingHeaders = OperationContext.Current.IncomingMessageHeaders;
                int sessionHeaderIndex = incomingHeaders.FindHeader(
                    AccountSessionHeaderName, AccountSessionHeaderNamespace);
                if (sessionHeaderIndex >= 0)
                {
                    accountSessionToken = incomingHeaders.GetHeader<string>(sessionHeaderIndex);
                }
            }

            return accountSessionToken;
        }
    }
}
