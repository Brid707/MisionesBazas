using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.IFriendsRequestService;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    /// <summary>
    /// Manages client-side WCF request-reply communication for friend request operations.
    /// </summary>
    public sealed class FriendsRequestClient : IFriendsRequestClient
    {
        private const string GetPendingOperationName = "GetPendingFriendRequestByUserIdAsync";
        private const string GetSentOperationName = "GetSentFriendRequestByUserIdAsync";
        private const string SendRequestOperationName = "SendFriendRequestAsync";
        private const string AcceptRequestOperationName = "AcceptFriendRequestAsync";
        private const string RejectRequestOperationName = "RejectFriendRequestAsync";
        private const string CancelRequestOperationName = "CancelFriendRequestAsync";

        private readonly ILoggerService _logger;
        private readonly WcfFaultHandler _faultHandler;
        private FriendsRequestServiceClient _client;

        public FriendsRequestClient(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _faultHandler = new WcfFaultHandler(_logger, RaiseConnectionError);
            InitializeClient();
        }

        public event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        public async Task<IList<FriendRequest>> GetPendingFriendRequestByUserIdAsync(int userId)
        {
            IList<FriendRequest> requests = new List<FriendRequest>();

            try
            {
                EnsureClientIsOpen();
                FriendRequest[] serverRequests = await _client.GetPendingFriendRequestByUserIdAsync(userId);

                if (serverRequests != null)
                {
                    requests = new List<FriendRequest>(serverRequests);
                }
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, GetPendingOperationName, _client);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, GetPendingOperationName, _client);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, GetPendingOperationName, _client);
            }

            return requests;
        }

        public async Task<IList<FriendRequest>> GetSentFriendRequestByUserIdAsync(int userId)
        {
            IList<FriendRequest> requests = new List<FriendRequest>();

            try
            {
                EnsureClientIsOpen();
                FriendRequest[] serverRequests = await _client.GetSentFriendRequestByUserIdAsync(userId);

                if (serverRequests != null)
                {
                    requests = new List<FriendRequest>(serverRequests);
                }
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, GetSentOperationName, _client);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, GetSentOperationName, _client);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, GetSentOperationName, _client);
            }

            return requests;
        }

        public async Task<OperationResult> SendFriendRequestAsync(int senderUserId, string targetUserName)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.SendFriendRequestAsync(senderUserId, targetUserName);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, SendRequestOperationName, _client);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, SendRequestOperationName, _client);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, SendRequestOperationName, _client);
            }

            return result;
        }

        public async Task<OperationResult> AcceptFriendRequestAsync(int receiverUserId, int senderUserId)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.AcceptFriendRequestAsync(receiverUserId, senderUserId);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, AcceptRequestOperationName, _client);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, AcceptRequestOperationName, _client);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, AcceptRequestOperationName, _client);
            }

            return result;
        }

        public async Task<OperationResult> RejectFriendRequestAsync(int receiverUserId, int senderUserId)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.RejectFriendRequestAsync(receiverUserId, senderUserId);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, RejectRequestOperationName, _client);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, RejectRequestOperationName, _client);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, RejectRequestOperationName, _client);
            }

            return result;
        }

        public async Task<OperationResult> CancelFriendRequestAsync(int senderUserId, int receiverUserId)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.CancelFriendRequestAsync(senderUserId, receiverUserId);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, CancelRequestOperationName, _client);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, CancelRequestOperationName, _client);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, CancelRequestOperationName, _client);
            }

            return result;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void InitializeClient()
        {
            _client = new FriendsRequestServiceClient();
        }

        private void EnsureClientIsOpen()
        {
            bool shouldReinitialize = _client == null ||
                                      _client.State == CommunicationState.Faulted ||
                                      _client.State == CommunicationState.Closed;

            if (shouldReinitialize)
            {
                InitializeClient();
            }
        }

        private void Dispose(bool isDisposing)
        {
            if (isDisposing && _client != null)
            {
                GameChannelCloser.CloseChannel(_client, _logger);
                _client = null;
            }
        }

        private void RaiseConnectionError(AuthenticationErrorType errorType)
        {
            ConnectionErrorOccurred?.Invoke(errorType);
        }
    }
}
