using System;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.ILobbyService;

namespace Model.Services
{
    /// <summary>
    /// Manages client-side WCF duplex communication for lobby rooms and handles server push callbacks.
    /// </summary>
    [CallbackBehavior(ConcurrencyMode = ConcurrencyMode.Multiple, UseSynchronizationContext = false)]
    public sealed class LobbyClient : ILobbyClient, ILobbyServiceCallback
    {
        private LobbyServiceClient _client;

        public LobbyClient()
        {
            InitializeClient();
        }

        public event Action<LobbyPlayer> PlayerJoined;

        public event Action<int, string> PlayerLeft;

        public event Action<int, bool> PlayerReadyStatusChanged;

        public event Action<LobbyMessage> ChatMessageReceived;

        public event Action<int> GameStarted;

        public event Action<string> LobbyDisbanded;

        public event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        /// <summary>
        /// Sends an asynchronous request to create a new lobby room on the server.
        /// </summary>
        /// <param name="hostUserId">The unique identifier of the user hosting the lobby.</param>
        /// <param name="targetMissionCount">The configured target mission count.</param>
        /// <param name="playerLimit">The maximum number of players allowed in the room.</param>
        /// <returns>The <see cref="LobbyResult"/> from the server, or null if a network fault occurred.</returns>
        public async Task<LobbyResult> CreateLobbyAsync(int hostUserId, byte targetMissionCount, byte playerLimit)
        {
            LobbyResult result = null;
            LobbySettings settings = new LobbySettings
            {
                TargetMissionCount = targetMissionCount,
                PlayerLimit = playerLimit
            };

            try
            {
                EnsureClientIsOpen();
                result = await _client.CreateLobbyAsync(hostUserId, settings);
            }
            catch (EndpointNotFoundException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }

            return result;
        }

        /// <summary>
        /// Sends an asynchronous request to join an existing lobby room using its invitation code.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the room.</param>
        /// <param name="userId">The unique identifier of the user attempting to join.</param>
        /// <returns>The <see cref="LobbyResult"/> from the server, or null if a network fault occurred.</returns>
        public async Task<LobbyResult> JoinLobbyByCodeAsync(string lobbyCode, int userId)
        {
            LobbyResult result = null;

            try
            {
                EnsureClientIsOpen();
                result = await _client.JoinLobbyByCodeAsync(lobbyCode, userId);
            }
            catch (EndpointNotFoundException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }

            return result;
        }

        /// <summary>
        /// Notifies the server asynchronously that the specified user is leaving the lobby room.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the room.</param>
        /// <param name="userId">The unique identifier of the user leaving the room.</param>
        public async Task LeaveLobbyAsync(string lobbyCode, int userId)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.LeaveLobbyAsync(lobbyCode, userId);
            }
            catch (EndpointNotFoundException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }
        }

        /// <summary>
        /// Updates the readiness status of the specified user inside the lobby room asynchronously.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the room.</param>
        /// <param name="userId">The unique identifier of the user.</param>
        /// <param name="isReady">Indicates whether the user is marked as ready.</param>
        public async Task SetPlayerReadyStatusAsync(string lobbyCode, int userId, bool isReady)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.SetPlayerReadyStatusAsync(lobbyCode, userId, isReady);
            }
            catch (EndpointNotFoundException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }
        }

        /// <summary>
        /// Sends a chat message asynchronously to all participants in the specified lobby room.
        /// </summary>
        /// <param name="lobbyCode">The alphanumeric invitation code of the room.</param>
        /// <param name="senderUserId">The unique identifier of the message sender.</param>
        /// <param name="message">The text content of the chat message.</param>
        public async Task SendLobbyChatMessageAsync(string lobbyCode, int senderUserId, string message)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.SendLobbyChatMessageAsync(lobbyCode, senderUserId, message);
            }
            catch (EndpointNotFoundException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }
        }

        public void OnPlayerJoinedLobby(LobbyPlayer player)
        {
            PlayerJoined?.Invoke(player);
        }

        public void OnPlayerLeftLobby(int userId, string reason)
        {
            PlayerLeft?.Invoke(userId, reason);
        }

        public void OnPlayerReadyStatusChanged(int userId, bool isReady)
        {
            PlayerReadyStatusChanged?.Invoke(userId, isReady);
        }

        public void OnReceiveLobbyChatMessage(LobbyMessage message)
        {
            ChatMessageReceived?.Invoke(message);
        }

        public void OnGameStarting(int gameId)
        {
            GameStarted?.Invoke(gameId);
        }

        public void OnLobbyDisbanded(string reason)
        {
            LobbyDisbanded?.Invoke(reason);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void InitializeClient()
        {
            InstanceContext instanceContext = new InstanceContext(this);
            _client = new LobbyServiceClient(instanceContext);
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
                CloseOrAbortClient();
            }
        }

        private void CloseOrAbortClient()
        {
            try
            {
                bool canCloseGracefully = _client.State != CommunicationState.Closed &&
                                          _client.State != CommunicationState.Faulted;

                if (canCloseGracefully)
                {
                    _client.Close();
                }
                else
                {
                    _client.Abort();
                }
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                _client.Abort();
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                _client.Abort();
            }
            finally
            {
                _client = null;
            }
        }
    }
}
