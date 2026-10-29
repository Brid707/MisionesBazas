using System;
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
    /// ViewModel for validating and processing match invitation code inputs.
    /// </summary>
    public sealed class EnterGameCodeViewModel : ViewModelBase
    {
        private readonly IDialogService _dialogService;
        private string _gameCode;
        private bool _isBusy;

        public EnterGameCodeViewModel(IDialogService dialogService)
        {
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _gameCode = string.Empty;

            CloseCommand = new RelayCommand(ExecuteClose);
            JoinCommand = new RelayCommand(ExecuteJoin, CanExecuteJoin);
        }

        public event Action<bool> RequestClose;

        public string GameCode
        {
            get => _gameCode;
            set => SetProperty(ref _gameCode, value);
        }

        public ICommand CloseCommand { get; }

        public ICommand JoinCommand { get; }

        private bool CanExecuteJoin()
        {
            return !_isBusy;
        }

        private void ExecuteClose()
        {
            RequestClose?.Invoke(false);
        }

        private async void ExecuteJoin()
        {
            if (string.IsNullOrWhiteSpace(_gameCode))
            {
                _dialogService.ShowWarning(MessageCode.EnterGameCodeEmptyCode);
            }
            else
            {
                await TryJoinLobbyAsync();
            }
        }

        private async Task TryJoinLobbyAsync()
        {
            SetBusyState(true);
            try
            {
                int userId = ResolveActiveUserId();
                string normalizedCode = _gameCode.Trim().ToUpperInvariant();

                LobbyResult result = await LobbySession.Current.Client.JoinLobbyByCodeAsync(
                    normalizedCode,
                    userId);

                if (result == null)
                {
                    _dialogService.ShowError(MessageCode.ConnectionFailed);
                }
                else if (!result.IsSuccess || result.Lobby == null)
                {
                    _dialogService.ShowWarning(MessageCode.EnterGameCodeInvalidCode);
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
