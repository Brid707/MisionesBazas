using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Input;

using Model.GameServices;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for configuring match rules, player limits, missions, and lobby privacy.
    /// </summary>
    public sealed class GameSettingsViewModel : ViewModelBase
    {
        private const int MinimumPlayerCount = 3;
        private const int HostRequiredServerCode = 106;
        private const int MatchInProgressServerCode = 105;
        private const int MaximumPlayerCount = 4;
        private const int MinimumMissionCount = 1;
        private const int MaximumMissionCount = 50;
        private const int DefaultMissionCount = 5;
        private const string LogLobbyOperationUnavailable = "Lobby operation {Operation} failed: service unavailable.";
        private const string LogLobbyOperationRejected = "Lobby operation {Operation} rejected with ErrorCode={ErrorCode}.";
        private const string OperationCreateLobby = "CreateLobby";
        private const string OperationUpdateLobbySettings = "UpdateLobbySettings";

        private readonly IDialogService _dialogService;
        private readonly ILobbySession _lobbySession;
        private readonly ILoggerService _logger;
        private int _selectedPlayerCount;
        private int _selectedMissionCount;
        private bool _isPrivate;

        public GameSettingsViewModel(IDialogService dialogService, ILobbySession lobbySession, ILoggerService logger)
        {
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));

            AvailablePlayerCounts = new List<int> { MinimumPlayerCount, MaximumPlayerCount };
            _selectedPlayerCount = MaximumPlayerCount;

            AvailableMissionCounts = new List<int>();
            for (int count = MinimumMissionCount; count <= MaximumMissionCount; count++)
            {
                AvailableMissionCounts.Add(count);
            }

            _selectedMissionCount = DefaultMissionCount;
            _isPrivate = true;
            LoadCurrentLobbyConfiguration();

            CloseCommand = new RelayCommand(ExecuteClose);
            ConfirmCommand = new AsyncRelayCommand(ExecuteConfirmAsync);
        }

        public event Action<bool> RequestClose;

        public List<int> AvailablePlayerCounts { get; }

        public int SelectedPlayerCount
        {
            get => _selectedPlayerCount;
            set => SetProperty(ref _selectedPlayerCount, value);
        }

        public List<int> AvailableMissionCounts { get; }

        public int SelectedMissionCount
        {
            get => _selectedMissionCount;
            set => SetProperty(ref _selectedMissionCount, value);
        }

        public bool IsPrivate
        {
            get => _isPrivate;
            set
            {
                SetProperty(ref _isPrivate, value);
                OnPropertyChanged(nameof(IsPublic));
            }
        }

        public bool IsPublic
        {
            get => !IsPrivate;
            set => IsPrivate = !value;
        }

        public ICommand CloseCommand { get; }

        public ICommand ConfirmCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke(false);
        }

        private async Task ExecuteConfirmAsync()
        {
            if (_lobbySession.HasActiveLobby)
            {
                await UpdateCurrentLobbyAsync();
            }
            else
            {
                await CreateNewLobbyAsync();
            }
        }

        private void LoadCurrentLobbyConfiguration()
        {
            Lobby activeLobby = _lobbySession.CurrentLobby;
            if (activeLobby != null)
            {
                SelectedPlayerCount = activeLobby.PlayerLimit;
                SelectedMissionCount = activeLobby.TargetMissionCount;
                IsPrivate = activeLobby.IsPrivate;
            }
        }

        private LobbySettings BuildSelectedLobbySettings()
        {
            return new LobbySettings
            {
                PlayerLimit = (byte)SelectedPlayerCount,
                TargetMissionCount = (byte)SelectedMissionCount,
                IsPrivate = IsPrivate
            };
        }

        private async Task UpdateCurrentLobbyAsync()
        {
            LobbyResult configurationUpdate = await _lobbySession.Client.UpdateLobbySettingsAsync(
                _lobbySession.CurrentLobby.LobbyCode, UserSession.Current.EnsureActiveUserId(),
                BuildSelectedLobbySettings());
            if (configurationUpdate?.IsSuccess == true && configurationUpdate.Lobby != null)
            {
                _lobbySession.SetLobby(configurationUpdate.Lobby);
                RequestClose?.Invoke(true);
            }
            else
            {
                ShowConfigurationRejection(configurationUpdate);
            }
        }

        private void ShowConfigurationRejection(LobbyResult configurationUpdate)
        {
            int configurationErrorCode = MessageCode.ConnectionFailed;
            if (configurationUpdate != null)
            {
                _logger.Warning(LogLobbyOperationRejected, OperationUpdateLobbySettings, configurationUpdate.ErrorCode);
                configurationErrorCode = MessageCode.LobbyConfigurationInvalid;
                if (configurationUpdate.ErrorCode == HostRequiredServerCode)
                {
                    configurationErrorCode = MessageCode.LobbyHostRequired;
                }
                else if (configurationUpdate.ErrorCode == MatchInProgressServerCode)
                {
                    configurationErrorCode = MessageCode.LobbyMatchInProgress;
                }
            }
            else
            {
                _logger.Error(LogLobbyOperationUnavailable, OperationUpdateLobbySettings);
            }

            _dialogService.ShowWarning(configurationErrorCode);
        }

        private async Task CreateNewLobbyAsync()
        {
            int hostUserId = UserSession.Current.EnsureActiveUserId();

            LobbyResult result = await _lobbySession.Client.CreateLobbyAsync(
                hostUserId, BuildSelectedLobbySettings());

            if (result == null)
            {
                _logger.Error(LogLobbyOperationUnavailable, OperationCreateLobby);
                _dialogService.ShowError(MessageCode.ConnectionFailed);
            }
            else if (!result.IsSuccess || result.Lobby == null)
            {
                _logger.Warning(LogLobbyOperationRejected, OperationCreateLobby, result.ErrorCode);
                _dialogService.ShowWarning(MessageCode.UnexpectedError);
            }
            else
            {
                _lobbySession.SetLobby(result.Lobby);
                RequestClose?.Invoke(true);
            }
        }
    }
}
