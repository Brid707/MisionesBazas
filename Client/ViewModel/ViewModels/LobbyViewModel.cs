using System;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Windows.Input;
using Model.ILobbyService;
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
    public sealed class LobbyViewModel : ViewModelBase
    {
        private const string DefaultMissionsTarget = "5";
        private const string DefaultLobbyCode = "XXXXX";

        private readonly INavigationService _navigationService;
        private readonly SynchronizationContext _uiSyncContext;
        private readonly int _currentUserId;

        private string _missionsTarget;
        private string _lobbyCode;
        private bool _isReady;

        public LobbyViewModel(INavigationService navigationService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _uiSyncContext = SynchronizationContext.Current;
            _currentUserId = UserSession.Current.CurrentUser != null
                ? UserSession.Current.CurrentUser.IdUser
                : 0;

            _missionsTarget = DefaultMissionsTarget;
            _lobbyCode = DefaultLobbyCode;
            _isReady = false;
            Players = new ObservableCollection<LobbyPlayerItemViewModel>();

            BackCommand = new RelayCommand(ExecuteBack);
            ProfileCommand = new RelayCommand(ExecuteProfile);
            SettingsCommand = new RelayCommand(ExecuteSettings);
            ToggleReadyCommand = new RelayCommand(ExecuteToggleReady);

            LoadInitialLobbyState();
            SubscribeToLobbyEvents();
        }

        public ObservableCollection<LobbyPlayerItemViewModel> Players { get; }

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

        private void LoadInitialLobbyState()
        {
            Lobby activeLobby = LobbySession.Current.CurrentLobby;
            if (activeLobby != null)
            {
                LobbyCode = activeLobby.LobbyCode ?? DefaultLobbyCode;
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
            LobbyClient client = LobbySession.Current.Client;
            client.PlayerJoined += OnServerPlayerJoined;
            client.PlayerLeft += OnServerPlayerLeft;
            client.PlayerReadyStatusChanged += OnServerPlayerReadyStatusChanged;
            client.LobbyDisbanded += OnServerLobbyDisbanded;
        }

        private void UnsubscribeFromLobbyEvents()
        {
            LobbyClient client = LobbySession.Current.Client;
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
                LobbySession.Current.ClearLobby();
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

        private async void ExecuteBack()
        {
            UnsubscribeFromLobbyEvents();
            string codeToLeave = _lobbyCode;

            if (_currentUserId > 0 && !string.IsNullOrWhiteSpace(codeToLeave) && codeToLeave != DefaultLobbyCode)
            {
                await LobbySession.Current.Client.LeaveLobbyAsync(codeToLeave, _currentUserId);
            }

            LobbySession.Current.ClearLobby();
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

        private async void ExecuteToggleReady()
        {
            bool newReadyState = !IsReady;
            UpdateParticipantReadyState(_currentUserId, newReadyState);

            if (_currentUserId > 0 && !string.IsNullOrWhiteSpace(_lobbyCode) && _lobbyCode != DefaultLobbyCode)
            {
                await LobbySession.Current.Client.SetPlayerReadyStatusAsync(
                    _lobbyCode,
                    _currentUserId,
                    newReadyState);
            }
        }
    }
}
