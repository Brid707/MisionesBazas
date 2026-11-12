using System.ServiceModel.Channels;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using System.ServiceModel;

using Model.Session;

namespace Model.Security
{
    /// <summary>Attaches the signed-in account's server-issued token to outgoing WCF operations.</summary>
    public sealed class AccountSessionEndpointBehavior : IEndpointBehavior, IClientMessageInspector
    {
        private const string AccountSessionHeaderName = "AccountSessionToken";
        private const string AccountSessionHeaderNamespace = "urn:misiones-bazas:account-session";

        public object BeforeSendRequest(ref Message accountRequestMessage, IClientChannel accountChannel)
        {
            string accountSessionToken = UserSession.Current.CurrentUser?.AccountSessionToken ??
                UserSession.Current.CurrentUser?.GuestSessionToken;
            if (!string.IsNullOrEmpty(accountSessionToken))
            {
                accountRequestMessage.Headers.Add(MessageHeader.CreateHeader(
                    AccountSessionHeaderName, AccountSessionHeaderNamespace, accountSessionToken));
            }

            return null;
        }

        public void AfterReceiveReply(ref Message accountReplyMessage, object accountRequestCorrelationState)
        {
        }

        public void AddBindingParameters(ServiceEndpoint accountEndpoint, BindingParameterCollection bindingParameters)
        {
        }

        public void ApplyClientBehavior(ServiceEndpoint accountEndpoint, ClientRuntime clientRuntime)
        {
            clientRuntime.ClientMessageInspectors.Add(this);
        }

        public void ApplyDispatchBehavior(ServiceEndpoint accountEndpoint, EndpointDispatcher endpointDispatcher)
        {
        }

        public void Validate(ServiceEndpoint accountEndpoint)
        {
        }
    }
}
