using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.ILobbyService;
using Model.Session;
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
        private const int MaximumPlayerCount = 4;
        private const int MinimumMissionCount = 1;
        private const int MaximumMissionCount = 50;
        private const int DefaultMissionCount = 5;

        private readonly IDialogService _dialogService;
        private int _selectedPlayerCount;
        private int _selectedMissionCount;
        private bool _isPrivate;
        private bool _isBusy;

        public GameSettingsViewModel()
            : this(null)
        {
        }

        public GameSettingsViewModel(IDialogService dialogService)
        {
            _dialogService = dialogService;
            AvailablePlayerCounts = new List<int> { MinimumPlayerCount, MaximumPlayerCount };
            _selectedPlayerCount = MaximumPlayerCount;

            AvailableMissionCounts = new List<int>();
            for (int count = MinimumMissionCount; count <= MaximumMissionCount; count++)
            {
                AvailableMissionCounts.Add(count);
            }

            _selectedMissionCount = DefaultMissionCount;
            _isPrivate = true;

            CloseCommand = new RelayCommand(ExecuteClose);
            ConfirmCommand = new RelayCommand(ExecuteConfirm, CanExecuteConfirm);
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
            set => SetProperty(ref _isPrivate, value);
        }

        public ICommand CloseCommand { get; }

        public ICommand ConfirmCommand { get; }

        private bool CanExecuteConfirm()
        {
            return !_isBusy;
        }

        private void ExecuteClose()
        {
            RequestClose?.Invoke(false);
        }

        private async void ExecuteConfirm()
        {
            if (LobbySession.Current.HasActiveLobby)
            {
                RequestClose?.Invoke(true);
            }
            else
            {
                await CreateNewLobbyAsync();
            }
        }

        private async Task CreateNewLobbyAsync()
        {
            SetBusyState(true);
            try
            {
                int hostUserId = ResolveActiveUserId();

                LobbyResult result = await LobbySession.Current.Client.CreateLobbyAsync(
                    hostUserId,
                    (byte)_selectedMissionCount,
                    (byte)_selectedPlayerCount);

                if (result == null)
                {
                    _dialogService?.ShowError(MessageCode.ConnectionFailed);
                }
                else if (!result.IsSuccess || result.Lobby == null)
                {
                    _dialogService?.ShowWarning(MessageCode.UnexpectedError);
                }
                else
                {
                    LobbySession.Current.SetLobby(result.Lobby);
                    RequestClose?.Invoke(true);
                }
            }
            finally
            {
                SetBusyState(false);
            }
        }

        private static int ResolveActiveUserId()
        {
            int userId = UserSession.Current.CurrentUser != null
                ? UserSession.Current.CurrentUser.IdUser
                : 0;

            if (userId == 0)
            {
                int randomValue = Math.Abs(Guid.NewGuid().GetHashCode());
                userId = -((randomValue % 9000) + 1000);
                int guestSuffix = Math.Abs(userId % 10000);

                UserSession.Current.SetUser(new UserSessionData
                {
                    IdUser = userId,
                    Username = $"Guest_{guestSuffix:D4}",
                    Email = string.Empty
                });
            }

            return userId;
        }

        private void SetBusyState(bool isBusy)
        {
            _isBusy = isBusy;
            CommandManager.InvalidateRequerySuggested();
        }
    }
}
