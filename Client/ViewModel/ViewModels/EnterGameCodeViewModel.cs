using System;
using System.Threading.Tasks;
using System.Windows.Input;

using Model.GameServices;
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
        private const int ServerErrorCodeLobbyFull = 104;
        private const int ServerErrorCodeKickedParticipantReentryDenied = 107;

        private readonly IDialogService _dialogService;
        private readonly ILobbySession _lobbySession;
        private string _gameCode;

        public EnterGameCodeViewModel(IDialogService dialogService, ILobbySession lobbySession)
        {
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _gameCode = string.Empty;

            CloseCommand = new RelayCommand(ExecuteClose);
            JoinCommand = new AsyncRelayCommand(ExecuteJoinAsync);
        }

        public event Action<bool> RequestClose;

        public string GameCode
        {
            get => _gameCode;
            set => SetProperty(ref _gameCode, value);
        }

        public ICommand CloseCommand { get; }

        public ICommand JoinCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke(false);
        }

        private async Task ExecuteJoinAsync()
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

        private static int ResolveLobbyEntryRejection(int serverErrorCode)
        {
            int rejectionMessageCode;
            switch (serverErrorCode)
            {
                case ServerErrorCodeLobbyFull:
                    rejectionMessageCode = MessageCode.EnterGameCodeLobbyAlreadyFull;
                    break;
                case ServerErrorCodeKickedParticipantReentryDenied:
                    rejectionMessageCode = MessageCode.LobbyKickedParticipantReentryDenied;
                    break;
                default:
                    rejectionMessageCode = MessageCode.EnterGameCodeInvalidCode;
                    break;
            }

            return rejectionMessageCode;
        }

        private async Task TryJoinLobbyAsync()
        {
            int userId = UserSession.Current.EnsureActiveUserId();
            string normalizedCode = _gameCode.Trim().ToUpperInvariant();

            LobbyResult result = await _lobbySession.Client.JoinLobbyByCodeAsync(normalizedCode, userId);

            if (result == null)
            {
                _dialogService.ShowError(MessageCode.ConnectionFailed);
            }
            else if (!result.IsSuccess || result.Lobby == null)
            {
                int messageToDisplay = ResolveLobbyEntryRejection(result.ErrorCode);

                _dialogService.ShowWarning(messageToDisplay);
            }
            else
            {
                _lobbySession.SetLobby(result.Lobby);
                RequestClose?.Invoke(true);
            }
        }
    }
}
