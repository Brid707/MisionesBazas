using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.GameServices;
using Model.Services;
using Model.Session;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing room state, live participant list, player readiness, and navigation from the lobby.
    /// </summary>
    public sealed class LobbyViewModel : ViewModelBase, IDisposable
    {
        private const byte WaitingLobbyStatus = 1;
        private const int MinimumPlayersToStart = 3;
        private const string PlayerKickedReason = "Player was kicked by the host.";

        private const string DefaultMissionsTarget = "5";

        private readonly INavigationService _navigationService;
        private readonly ILobbySession _lobbySession;
        private readonly ILobbyClient _lobbyClient;
        private readonly SynchronizationContext _uiSyncContext;
        private readonly int _currentUserId;

        private string _missionsTarget;
        private string _lobbyCode;
        private bool _isReady;
        private IProfileImageCache _profileImageCache;
        private bool _isDisposed;
        private long _lastAppliedLobbyVersion;
        private bool _hasLobbyConnectionFailure;
        private bool _hasLobbyStartFailure;
        private bool _hasLobbyHostChanged;
        private string _currentLobbyHostUsername;
        private int _lastConfirmedHostUserId;

        public LobbyViewModel(INavigationService navigationService, ILobbySession lobbySession,
            IChatModerationPresenter chatModerationPresenter)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _lobbyClient = lobbySession.Client;
            _uiSyncContext = SynchronizationContext.Current;
            _currentUserId = UserSession.Current.EnsureActiveUserId();

            _missionsTarget = DefaultMissionsTarget;
            _lobbyCode = string.Empty;
            _isReady = false;
            Players = new ObservableCollection<LobbyPlayerItemViewModel>();
            Players.CollectionChanged += OnLobbyParticipantsChanged;

            BackCommand = new AsyncRelayCommand(ExecuteBackAsync);
            ProfileCommand = new RelayCommand(ExecuteProfile);
            SettingsCommand = new RelayCommand(ExecuteSettings, CanEditLobbySettings);
            StartGameCommand = new AsyncRelayCommand(ExecuteStartGameAsync, CanStartGame);
            ToggleReadyCommand = new AsyncRelayCommand(ExecuteToggleReadyAsync);

            Chat = new LobbyChatViewModel(lobbySession, navigationService, chatModerationPresenter);
            LoadInitialLobbyState();
            SubscribeToLobbyEvents();
        }

        /// <summary>
        /// Notifies the view that the local participant was removed by the host.
        /// </summary>
        public event EventHandler CurrentPlayerKicked;

        public bool CanEditCurrentLobby => _lobbySession.CurrentLobby?.HostUserId == _currentUserId &&
            !_hasLobbyConnectionFailure;

        public bool CanStartCurrentLobby => CanEditCurrentLobby &&
            _lobbySession.CurrentLobby?.Status == WaitingLobbyStatus &&
            Players.Count >= MinimumPlayersToStart &&
            Players.All(participant => participant.IsReady || participant.IsHost);

        public bool HasLobbyConnectionFailure
        {
            get => _hasLobbyConnectionFailure;
            private set => SetProperty(ref _hasLobbyConnectionFailure, value);
        }

        public bool HasLobbyStartFailure
        {
            get => _hasLobbyStartFailure;
            private set => SetProperty(ref _hasLobbyStartFailure, value);
        }

        public bool HasLobbyHostChanged
        {
            get => _hasLobbyHostChanged;
            private set => SetProperty(ref _hasLobbyHostChanged, value);
        }

        public string CurrentLobbyHostUsername
        {
            get => _currentLobbyHostUsername;
            private set => SetProperty(ref _currentLobbyHostUsername, value);
        }

        public int MaximumLobbyPlayerCount => _lobbySession.CurrentLobby?.PlayerLimit ?? 0;

        public ProfileImageViewModel CurrentPlayerProfileImage { get; private set; }

        public LobbyChatViewModel Chat { get; }

        public ObservableCollection<LobbyPlayerItemViewModel> Players { get; }

        public IEnumerable<int> VacantLobbyPlayerSlots => Enumerable.Range(0,
            Math.Max(0, (_lobbySession.CurrentLobby?.PlayerLimit ?? 0) - Players.Count));

        public string MissionsTarget
        {
            get => _missionsTarget;
            set => SetProperty(ref _missionsTarget, value);
        }

        public string LobbyCode
        {
            get => _lobbyCode;
            set => SetProperty(ref _lobbyCode, value);
        }

        public bool IsReady
        {
            get => _isReady;
            set => SetProperty(ref _isReady, value);
        }

        public ICommand BackCommand { get; }

        public ICommand ProfileCommand { get; }

        public ICommand SettingsCommand { get; }

        public ICommand StartGameCommand { get; }

        public ICommand ToggleReadyCommand { get; }

        public void ConfigureProfileImages(IProfileImageCache profileImageCache)
        {
            _profileImageCache = profileImageCache;
            CurrentPlayerProfileImage?.Dispose();
            CurrentPlayerProfileImage = new ProfileImageViewModel(_currentUserId, profileImageCache);
            OnPropertyChanged(nameof(CurrentPlayerProfileImage));
            Chat.ConfigureProfileImages(profileImageCache);
            foreach (LobbyPlayerItemViewModel player in Players)
            {
                player.AttachProfileImage(profileImageCache);
            }
        }

        public void Dispose()
        {
            _isDisposed = true;
            Players.CollectionChanged -= OnLobbyParticipantsChanged;
            UnsubscribeFromLobbyEvents();
            Chat.Dispose();
            CurrentPlayerProfileImage?.Dispose();
            foreach (LobbyPlayerItemViewModel player in Players)
            {
                player.Dispose();
            }
        }

        private void OnLobbyParticipantsChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            OnPropertyChanged(nameof(VacantLobbyPlayerSlots));
        }

        private void LoadInitialLobbyState()
        {
            ApplyConfirmedLobbyState(_lobbySession.CurrentLobby);
        }

        private void OnServerLobbyStateChanged(object sender, LobbyStateChangedEventArgs e)
        {
            DispatchToUiThread(() => ApplyConfirmedLobbyState(e.ConfirmedLobby));
        }

        private void ApplyConfirmedLobbyState(Lobby confirmedLobby)
        {
            if (confirmedLobby != null && confirmedLobby.StateVersion >= _lastAppliedLobbyVersion)
            {
                HasLobbyHostChanged = _lastConfirmedHostUserId != 0 &&
                    _lastConfirmedHostUserId != confirmedLobby.HostUserId;
                _lastConfirmedHostUserId = confirmedLobby.HostUserId;
                _lastAppliedLobbyVersion = confirmedLobby.StateVersion;
                _lobbySession.SetLobby(confirmedLobby);
                LobbyCode = confirmedLobby.LobbyCode;
                MissionsTarget = confirmedLobby.TargetMissionCount.ToString(CultureInfo.InvariantCulture);
                SynchronizeLobbyPlayers(confirmedLobby);
                CurrentLobbyHostUsername = Players.FirstOrDefault(participant => participant.IsHost)?.Username;
                OnPropertyChanged(nameof(MaximumLobbyPlayerCount));
                OnPropertyChanged(nameof(VacantLobbyPlayerSlots));
                OnPropertyChanged(nameof(CanEditCurrentLobby));
                OnPropertyChanged(nameof(CanStartCurrentLobby));
                CommandManager.InvalidateRequerySuggested();
            }
        }

        private void SynchronizeLobbyPlayers(Lobby confirmedLobby)
        {
            foreach (LobbyPlayerItemViewModel player in Players)
            {
                player.Dispose();
            }
            Players.Clear();
            foreach (LobbyPlayer participant in confirmedLobby.Players)
            {
                AddOrUpdateParticipantItem(participant);
            }
        }

        private void OnLobbyConnectionFailed(AuthenticationErrorType connectionFailure)
        {
            DispatchToUiThread(MarkLobbyConnectionFailure);
        }

        private void MarkLobbyConnectionFailure()
        {
            HasLobbyConnectionFailure = true;
            OnPropertyChanged(nameof(CanEditCurrentLobby));
            OnPropertyChanged(nameof(CanStartCurrentLobby));
            CommandManager.InvalidateRequerySuggested();
        }

        private bool CanEditLobbySettings()
        {
            return CanEditCurrentLobby;
        }

        private bool CanStartGame()
        {
            return CanStartCurrentLobby;
        }

        private void SubscribeToLobbyEvents()
        {
            ILobbyClient client = _lobbyClient;
            client.PlayerLeft += OnServerPlayerLeft;
            client.LobbyStateChanged += OnServerLobbyStateChanged;
            client.ConnectionErrorOccurred += OnLobbyConnectionFailed;
            client.LobbyDisbanded += OnServerLobbyDisbanded;
            client.GameStarted += OnServerGameStarted;
        }

        private void UnsubscribeFromLobbyEvents()
        {
            ILobbyClient client = _lobbyClient;
            client.PlayerLeft -= OnServerPlayerLeft;
            client.LobbyStateChanged -= OnServerLobbyStateChanged;
            client.ConnectionErrorOccurred -= OnLobbyConnectionFailed;
            client.LobbyDisbanded -= OnServerLobbyDisbanded;
            client.GameStarted -= OnServerGameStarted;
        }

        private void OnServerGameStarted(int gameId)
        {
            DispatchToUiThread(HandleGameStarted);
        }

        private void HandleGameStarted()
        {
            if (!_isDisposed)
            {
                UnsubscribeFromLobbyEvents();
                SyncSessionLobbyPlayers();
                _navigationService.NavigateTo(ViewId.GameMatch);
            }
        }

        private void OnServerPlayerLeft(int participantUserId, string departureReason)
        {
            if (participantUserId == _currentUserId && departureReason == PlayerKickedReason)
            {
                DispatchToUiThread(HandleCurrentPlayerKick);
            }
        }

        private void HandleCurrentPlayerKick()
        {
            if (!_isDisposed)
            {
                UnsubscribeFromLobbyEvents();
                _lobbySession.ClearLobby();
                CurrentPlayerKicked?.Invoke(this, EventArgs.Empty);
                _navigationService.NavigateTo(ViewId.GameMenu);
            }
        }

        private bool CanKickLobbyPlayer(int targetUserId)
        {
            return !_isDisposed && CanEditCurrentLobby && targetUserId != _currentUserId &&
                _lobbySession.CurrentLobby?.Status == WaitingLobbyStatus &&
                Players.Any(participant => participant.IdUser == targetUserId && !participant.IsHost);
        }

        private async Task KickLobbyPlayerAsync(int targetUserId)
        {
            if (CanKickLobbyPlayer(targetUserId))
            {
                await _lobbyClient.KickPlayerAsync(_lobbyCode, _currentUserId, targetUserId);
            }
        }

        private void OnServerLobbyDisbanded(string reason)
        {
            DispatchToUiThread(() =>
            {
                UnsubscribeFromLobbyEvents();
                _lobbySession.ClearLobby();
                _navigationService.NavigateTo(ViewId.GameMenu);
            });
        }

        private void AddOrUpdateParticipantItem(LobbyPlayer participant)
        {
            LobbyPlayerItemViewModel existing = Players.FirstOrDefault(item => item.IdUser == participant.IdUser);
            bool isLocalPlayer = participant.IdUser == _currentUserId;

            if (existing == null)
            {
                LobbyPlayerItemViewModel newItem = new LobbyPlayerItemViewModel(
                    participant.IdUser,
                    participant.Username,
                    participant.IsHost)
                {
                    CanBeKickedByCurrentHost = CanEditCurrentLobby && !isLocalPlayer && !participant.IsHost &&
                        _lobbySession.CurrentLobby?.Status == WaitingLobbyStatus,
                    KickPlayerCommand = new AsyncRelayCommand(
                        () => KickLobbyPlayerAsync(participant.IdUser),
                        () => CanKickLobbyPlayer(participant.IdUser)),
                    IsCurrentPlayer = isLocalPlayer,
                    IsReady = participant.IsReady
                };
                if (_profileImageCache != null)
                {
                    newItem.AttachProfileImage(_profileImageCache);
                }
                Players.Add(newItem);
            }
            else
            {
                existing.IsReady = participant.IsReady;
            }

            if (isLocalPlayer)
            {
                IsReady = participant.IsReady;
            }

            SyncSessionLobbyPlayers();
        }

        private void RemoveParticipantItem(int userId)
        {
            LobbyPlayerItemViewModel existing = Players.FirstOrDefault(item => item.IdUser == userId);
            if (existing != null)
            {
                existing.Dispose();
                Players.Remove(existing);
                SyncSessionLobbyPlayers();
            }
        }

        private void SyncSessionLobbyPlayers()
        {
            Lobby activeLobby = _lobbySession.CurrentLobby;
            if (activeLobby != null)
            {
                LobbyPlayer[] updatedPlayers = new LobbyPlayer[Players.Count];
                for (int index = 0; index < Players.Count; index++)
                {
                    LobbyPlayerItemViewModel item = Players[index];
                    updatedPlayers[index] = new LobbyPlayer
                    {
                        IdUser = item.IdUser,
                        Username = item.Username,
                        IsHost = item.IsHost,
                        IsReady = item.IsReady
                    };
                }

                activeLobby.Players = updatedPlayers;
            }
        }

        private void UpdateParticipantReadyState(int userId, bool isReady)
        {
            LobbyPlayerItemViewModel existing = Players.FirstOrDefault(item => item.IdUser == userId);
            if (existing != null)
            {
                existing.IsReady = isReady;
            }

            if (userId == _currentUserId)
            {
                IsReady = isReady;
            }

            OnPropertyChanged(nameof(CanStartCurrentLobby));
            CommandManager.InvalidateRequerySuggested();
        }

        private void DispatchToUiThread(Action uiAction)
        {
            if (_uiSyncContext != null && SynchronizationContext.Current != _uiSyncContext)
            {
                _uiSyncContext.Post(_ => uiAction(), null);
            }
            else
            {
                uiAction();
            }
        }

        private async Task ExecuteBackAsync()
        {
            UnsubscribeFromLobbyEvents();
            string codeToLeave = _lobbyCode;

            if (!string.IsNullOrWhiteSpace(codeToLeave))
            {
                await _lobbyClient.LeaveLobbyAsync(codeToLeave, _currentUserId);
            }

            _lobbySession.ClearLobby();
            _navigationService.NavigateTo(ViewId.GameMenu);
        }

        private void ExecuteProfile()
        {
            _navigationService.NavigateTo(ViewId.Profile);
        }

        private void ExecuteSettings()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.GameSettingsDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[LobbyViewModel] Error opening settings dialog: {ex.Message}");
            }
        }

        private async Task ExecuteStartGameAsync()
        {
            if (CanStartGame() && !string.IsNullOrWhiteSpace(_lobbyCode))
            {
                HasLobbyStartFailure = false;
                bool isStartConfirmed = await _lobbyClient.StartGameFromLobbyAsync(_lobbyCode, _currentUserId);
                HasLobbyStartFailure = !isStartConfirmed;
            }
        }

        private async Task ExecuteToggleReadyAsync()
        {
            bool newReadyState = !IsReady;
            UpdateParticipantReadyState(_currentUserId, newReadyState);

            if (!string.IsNullOrWhiteSpace(_lobbyCode))
            {
                await _lobbyClient.SetPlayerReadyStatusAsync(
                    _lobbyCode,
                    _currentUserId,
                    newReadyState);
            }
        }
    }
}
