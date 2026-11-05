using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Threading;
using System.Windows.Input;
using System;

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
        private const string DefaultMissionsTarget = "5";

        private readonly INavigationService _navigationService;
        private readonly ILobbySession _lobbySession;
        private readonly ILobbyClient _lobbyClient;
        private readonly SynchronizationContext _uiSyncContext;
        private readonly int _currentUserId;

        private string _missionsTarget;
        private string _lobbyCode;
        private bool _isReady;

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
            SettingsCommand = new RelayCommand(ExecuteSettings);
            ToggleReadyCommand = new AsyncRelayCommand(ExecuteToggleReadyAsync);

            Chat = new LobbyChatViewModel(lobbySession, navigationService, chatModerationPresenter);
            LoadInitialLobbyState();
            SubscribeToLobbyEvents();
        }

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

        public ICommand ToggleReadyCommand { get; }

        public void Dispose()
        {
            Players.CollectionChanged -= OnLobbyParticipantsChanged;
            UnsubscribeFromLobbyEvents();
            Chat.Dispose();
        }

        private void OnLobbyParticipantsChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            OnPropertyChanged(nameof(VacantLobbyPlayerSlots));
        }

        private void LoadInitialLobbyState()
        {
            Lobby activeLobby = _lobbySession.CurrentLobby;
            if (activeLobby != null)
            {
                LobbyCode = activeLobby.LobbyCode ?? string.Empty;
                MissionsTarget = activeLobby.TargetMissionCount.ToString(CultureInfo.InvariantCulture);

                if (activeLobby.Players != null)
                {
                    foreach (LobbyPlayer participant in activeLobby.Players)
                    {
                        AddOrUpdateParticipantItem(participant);
                    }
                }
            }
        }

        private void SubscribeToLobbyEvents()
        {
            ILobbyClient client = _lobbyClient;
            client.PlayerJoined += OnServerPlayerJoined;
            client.PlayerLeft += OnServerPlayerLeft;
            client.PlayerReadyStatusChanged += OnServerPlayerReadyStatusChanged;
            client.LobbyDisbanded += OnServerLobbyDisbanded;
        }

        private void UnsubscribeFromLobbyEvents()
        {
            ILobbyClient client = _lobbyClient;
            client.PlayerJoined -= OnServerPlayerJoined;
            client.PlayerLeft -= OnServerPlayerLeft;
            client.PlayerReadyStatusChanged -= OnServerPlayerReadyStatusChanged;
            client.LobbyDisbanded -= OnServerLobbyDisbanded;
        }

        private void OnServerPlayerJoined(LobbyPlayer player)
        {
            if (player != null)
            {
                DispatchToUiThread(() => AddOrUpdateParticipantItem(player));
            }
        }

        private void OnServerPlayerLeft(int userId, string reason)
        {
            DispatchToUiThread(() => RemoveParticipantItem(userId));
        }

        private void OnServerPlayerReadyStatusChanged(int userId, bool isReady)
        {
            DispatchToUiThread(() => UpdateParticipantReadyState(userId, isReady));
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
                    IsCurrentPlayer = isLocalPlayer,
                    IsReady = participant.IsReady
                };
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
        }

        private void RemoveParticipantItem(int userId)
        {
            LobbyPlayerItemViewModel existing = Players.FirstOrDefault(item => item.IdUser == userId);
            if (existing != null)
            {
                Players.Remove(existing);
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
