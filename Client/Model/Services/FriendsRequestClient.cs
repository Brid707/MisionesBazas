using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.IFriendsRequestService;

namespace Model.Services
{
    /// <summary>
    /// Manages client-side WCF request-reply communication for friend request operations.
    /// </summary>
    public sealed class FriendsRequestClient : IFriendsRequestClient
    {
        private FriendsRequestServiceClient _client;

        public FriendsRequestClient()
        {
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
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
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
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
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
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
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
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
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
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
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
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(_client);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
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
                GameChannelCloser.CloseChannel(_client);
                _client = null;
            }
        }
    }
}
