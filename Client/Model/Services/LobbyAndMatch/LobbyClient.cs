using System;
using System.ServiceModel;
using System.Threading.Tasks;
using Gameplay;
using Model.GameServices;
using Model.Security;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    /// <summary>
    /// Manages client-side WCF duplex communication for lobby rooms and handles server push callbacks.
    /// </summary>
    [CallbackBehavior(ConcurrencyMode = ConcurrencyMode.Multiple, UseSynchronizationContext = false)]
    public sealed class LobbyClient : ILobbyClient, ILobbyServiceCallback
    {
        private const string ChannelDisconnectedTemplate = "Lobby duplex channel disconnected unexpectedly.";
        private const string CloseFaultTemplate =
            "Communication fault ({ExceptionType}) while closing lobby channel; aborting.";
        private const string CloseTimeoutTemplate =
            "Timed out ({ExceptionType}) while closing lobby channel; aborting.";
        private const string MatchStartRejectedTemplate = "Match start rejected with {ExceptionType}.";
        private const string CreateLobbyOperationName = "CreateLobbyAsync";
        private const string UpdateLobbySettingsOperationName = "UpdateLobbySettingsAsync";
        private const string AuthorizeReentryOperationName = "AuthorizeKickedPlayerReentryAsync";
        private const string JoinLobbyOperationName = "JoinLobbyByCodeAsync";
        private const string LeaveLobbyOperationName = "LeaveLobbyAsync";
        private const string KickPlayerOperationName = "KickPlayerAsync";
        private const string SetPlayerReadyOperationName = "SetPlayerReadyStatusAsync";
        private const string SendChatMessageOperationName = "SendLobbyChatMessageAsync";
        private const string StartGameOperationName = "StartGameFromLobbyAsync";

        private readonly ILoggerService _logger;
        private readonly WcfFaultHandler _faultHandler;
        private readonly LobbyMatchClient _matchClient;
        private LobbyServiceClient _client;
        private bool _isLobbyClientDisposed;

        public LobbyClient(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _faultHandler = new WcfFaultHandler(_logger, RaiseConnectionError);
            _matchClient = new LobbyMatchClient(() => _client, EnsureClientIsOpen, _logger);
            _matchClient.MatchStateChanged += version => MatchStateChanged?.Invoke(version);
            InitializeClient();
        }

        public event EventHandler<LobbyStateChangedEventArgs> LobbyStateChanged;

        public event Action<LobbyPlayer> PlayerJoined;

        public event Action<int, string> PlayerLeft;

        public event Action<int, bool> PlayerReadyStatusChanged;

        public event Action<LobbyMessage> ChatMessageReceived;

        public event EventHandler<ChatAccountBanAppliedEventArgs> ChatAccountBanApplied;

        public event Action<int> GameStarted;

        public event Action<string> LobbyDisbanded;

        public event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        public event Action<long> MatchStateChanged;

        /// <summary>
        /// Sends an asynchronous request to create a new lobby room on the server.
        /// </summary>
        /// <param name="hostUserId">The unique identifier of the user hosting the lobby.</param>
        /// <param name="lobbySettings">The selected missions, capacity and privacy.</param>
        /// <returns>The <see cref="LobbyResult"/> from the server, or null if a network fault occurred.</returns>
        public async Task<LobbyResult> CreateLobbyAsync(int hostUserId, LobbySettings lobbySettings)
        {
            LobbyResult result = null;
            try
            {
                EnsureClientIsOpen();
                result = await _client.CreateLobbyAsync(hostUserId, lobbySettings);
                PreserveGuestCredential(result);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, CreateLobbyOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, CreateLobbyOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, CreateLobbyOperationName);
            }

            return result;
        }

        /// <inheritdoc />
        public async Task<LobbyResult> UpdateLobbySettingsAsync(string lobbyCode, int requesterUserId,
            LobbySettings lobbySettings)
        {
            LobbyResult configurationUpdate = null;
            try
            {
                EnsureClientIsOpen();
                configurationUpdate = await _client.UpdateLobbySettingsAsync(lobbyCode, requesterUserId, lobbySettings);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, UpdateLobbySettingsOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, UpdateLobbySettingsOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, UpdateLobbySettingsOperationName);
            }

            return configurationUpdate;
        }

        /// <inheritdoc />
        public async Task<LobbyResult> AuthorizeKickedPlayerReentryAsync(
            string lobbyCode, int hostUserId, int targetUserId)
        {
            LobbyResult reentryAuthorization = null;
            try
            {
                EnsureClientIsOpen();
                reentryAuthorization = await _client.AuthorizeKickedPlayerReentryAsync(
                    lobbyCode, hostUserId, targetUserId);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, AuthorizeReentryOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, AuthorizeReentryOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, AuthorizeReentryOperationName);
            }

            return reentryAuthorization;
        }

        /// <summary>Raises the local event for a server-confirmed room snapshot.</summary>
        public void OnLobbyStateChanged(Lobby confirmedLobby)
        {
            LobbyStateChanged?.Invoke(this, new LobbyStateChangedEventArgs(confirmedLobby));
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
                PreserveGuestCredential(result);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, JoinLobbyOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, JoinLobbyOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, JoinLobbyOperationName);
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
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, LeaveLobbyOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, LeaveLobbyOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, LeaveLobbyOperationName);
            }
        }

        /// <summary>Requests removal through the existing authenticated lobby operation.</summary>
        public async Task KickPlayerAsync(string lobbyCode, int hostUserId, int targetUserId)
        {
            try
            {
                EnsureClientIsOpen();
                await _client.KickPlayerByUserIdAsync(lobbyCode, hostUserId, targetUserId);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, KickPlayerOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, KickPlayerOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, KickPlayerOperationName);
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
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, SetPlayerReadyOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, SetPlayerReadyOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, SetPlayerReadyOperationName);
            }
        }

        /// <summary>Returns processing confirmation; retries must reuse the same submission identifier.</summary>
        public async Task<LobbyChatMessageSubmissionOutcome> SendLobbyChatMessageAsync(
            LobbyChatMessageSubmission chatMessageSubmission)
        {
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = null;
            try
            {
                EnsureClientIsOpen();
                chatMessageSubmissionOutcome = await _client.SendLobbyChatMessageAsync(chatMessageSubmission);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, SendChatMessageOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, SendChatMessageOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, SendChatMessageOperationName);
            }

            return chatMessageSubmissionOutcome;
        }

        public async Task<bool> StartGameFromLobbyAsync(string lobbyCode, int hostUserId)
        {
            bool isStartConfirmed = false;
            try
            {
                EnsureClientIsOpen();
                await _client.StartGameFromLobbyAsync(lobbyCode, hostUserId);
                isStartConfirmed = true;
            }
            catch (FaultException ex)
            {
                _logger.Warning(MatchStartRejectedTemplate, ex.GetType().Name);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFault(ex, StartGameOperationName);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFault(ex, StartGameOperationName);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFault(ex, StartGameOperationName);
            }
            return isStartConfirmed;
        }

        public void OnChatAccountBanApplied(ChatAccountBanNotice chatAccountBanNotice)
        {
            ChatAccountBanApplied?.Invoke(this, new ChatAccountBanAppliedEventArgs(chatAccountBanNotice));
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
            _client.Endpoint.EndpointBehaviors.Add(new AccountSessionEndpointBehavior());
            _client.InnerChannel.Faulted += OnLobbyChannelDisconnected;
            _client.InnerChannel.Closed += OnLobbyChannelDisconnected;
        }

        private void OnLobbyChannelDisconnected(object sender, EventArgs e)
        {
            if (!_isLobbyClientDisposed)
            {
                _logger.Warning(ChannelDisconnectedTemplate);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }
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
            _isLobbyClientDisposed = true;
            if (isDisposing)
            {
                _matchClient?.Dispose();
                if (_client != null)
                {
                    CloseOrAbortClient();
                }
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
            catch (CommunicationException ex)
            {
                _logger.Warning(CloseFaultTemplate, ex.GetType().Name);
                _client.Abort();
            }
            catch (TimeoutException ex)
            {
                _logger.Warning(CloseTimeoutTemplate, ex.GetType().Name);
                _client.Abort();
            }
            finally
            {
                _client = null;
            }
        }

        private void RaiseConnectionError(AuthenticationErrorType errorType)
        {
            ConnectionErrorOccurred?.Invoke(errorType);
        }

        public void OnMatchStateChanged(long matchStateVersion)
        {
            _matchClient.NotifyMatchStateChanged(matchStateVersion);
        }

        public bool IsMatchParticipantConnected(Guid matchId, int missionAttemptId)
        {
            return _matchClient.IsMatchParticipantConnected(matchId, missionAttemptId);
        }

        public Task<MissionPreparationConfirmation> IdentifyHeartNineOwnerAsync(
            HeartNineIdentificationSubmission submission, int participantUserId)
        {
            return _matchClient.IdentifyHeartNineOwnerAsync(submission, participantUserId);
        }

        public Task<MissionPreparationConfirmation> AssignMissionTrickDistributionAsync(
            MissionTrickDistributionSubmission submission, int participantUserId)
        {
            return _matchClient.AssignMissionTrickDistributionAsync(submission, participantUserId);
        }

        public Task<MissionPreparationConfirmation> AssignMissionRoleAsync(
            MissionRoleAssignmentSubmission submission, int participantUserId)
        {
            return _matchClient.AssignMissionRoleAsync(submission, participantUserId);
        }

        public Task<MissionPreparationConfirmation> RespondToBlindObjectivesAsync(
            BlindObjectiveResponseSubmission submission, int participantUserId)
        {
            return _matchClient.RespondToBlindObjectivesAsync(submission, participantUserId);
        }

        public Task<PlayerMatchSnapshot> GetPlayerMatchAsync(string lobbyCode, int participantUserId)
        {
            return _matchClient.GetPlayerMatchAsync(lobbyCode, participantUserId);
        }

        public Task<RadioCommunicationConfirmation> SubmitRadioCommunicationAsync(
            RadioCommunicationSubmission submission, int participantUserId)
        {
            return _matchClient.SubmitRadioCommunicationAsync(submission, participantUserId);
        }

        public Task<CardPlayDecision> PlayCardAsync(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            return _matchClient.PlayCardAsync(cardPlaySubmission, participantUserId);
        }

        public Task<MissionObjectiveDraftDecision> ProcessObjectiveDraftActionAsync(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            return _matchClient.ProcessObjectiveDraftActionAsync(submission, participantUserId);
        }

        public Task<MissionRetryDecision> ConfirmMissionRetryAsync(
            MissionRetrySubmission submission, int participantUserId)
        {
            return _matchClient.ConfirmMissionRetryAsync(submission, participantUserId);
        }

        public Task<DistressSignalConfirmation> SubmitDistressSignalAsync(
            DistressSignalSubmission submission, int participantUserId)
        {
            return _matchClient.SubmitDistressSignalAsync(submission, participantUserId);
        }

        private static void PreserveGuestCredential(LobbyResult entryDecision)
        {
            if (entryDecision != null && !string.IsNullOrEmpty(entryDecision.GuestSessionToken) &&
                UserSession.Current.CurrentUser != null)
            {
                UserSession.Current.CurrentUser.GuestSessionToken = entryDecision.GuestSessionToken;
            }
        }
    }
}
