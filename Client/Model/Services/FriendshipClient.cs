using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.IFriendShipService;

namespace Model.Services
{
    /// <summary>
    /// Manages client-side WCF duplex communication for social operations and handles server push callbacks.
    /// </summary>
    [CallbackBehavior(ConcurrencyMode = ConcurrencyMode.Multiple, UseSynchronizationContext = false)]
    public sealed class FriendshipClient : IFriendshipClient, IFriendshipServiceCallback
    {
        private FriendshipServiceClient _client;

        public FriendshipClient()
        {
            InitializeClient();
        }

        public event Action<FriendRequest> FriendRequestReceived;

        public event Action<int, bool> FriendStatusChanged;

        public event Action<int> FriendRemoved;

        public event Action<GameInvitation> GameInvitationReceived;

        public event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        public async Task SubscribeSocialEventsAsync(int userId)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.SubscribeSocialEventsAsync(userId);
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
        }

        public async Task UnsubscribeSocialEventsAsync(int userId)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.UnsubscribeSocialEventsAsync(userId);
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
        }

        public async Task<IList<Friend>> GetFriendsListByUserIdAsync(int userId)
        {
            IList<Friend> friendsList = new List<Friend>();

            try
            {
                EnsureClientIsOpen();
                Friend[] serverFriends = await _client.GetFriendsListByUserIdAsync(userId);

                if (serverFriends != null)
                {
                    friendsList = new List<Friend>(serverFriends);
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

            return friendsList;
        }

        public async Task<OperationResult> RemoveFriendAsync(int userId, int friendUserId)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.RemoveFriendAsync(userId, friendUserId);
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

        public async Task<OperationResult> BlockPlayerAsync(int blockerUserId, int targetUserId)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.BlockPlayerAsync(blockerUserId, targetUserId);
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

        public async Task<OperationResult> UnblockPlayerAsync(int blockerUserId, int targetUserId)
        {
            OperationResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.UnblockPlayerAsync(blockerUserId, targetUserId);
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

        public async Task SendGameInvitationAsync(GameInvitation gameInvitation)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.SendGameInvitationAsync(gameInvitation);
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
        }

        public void OnReceiveFriendRequest(FriendRequest friendRequest)
        {
            FriendRequestReceived?.Invoke(friendRequest);
        }

        public void OnFriendStatusChanged(int friendUserId, bool isOnline)
        {
            FriendStatusChanged?.Invoke(friendUserId, isOnline);
        }

        public void OnFriendRemoved(int friendUserId)
        {
            FriendRemoved?.Invoke(friendUserId);
        }

        public void OnReceiveGameInvitation(GameInvitation gameInvitation)
        {
            GameInvitationReceived?.Invoke(gameInvitation);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void InitializeClient()
        {
            InstanceContext instanceContext = new InstanceContext(this);
            _client = new FriendshipServiceClient(instanceContext);
        }

        private void EnsureClientIsOpen()
        {
            bool shouldReinitialize = _client == null || _client.State == CommunicationState.Faulted 
                || _client.State == CommunicationState.Closed;

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
