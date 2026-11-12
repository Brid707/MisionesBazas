using System;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.Services;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing interactions and navigation options from the primary game menu.
    /// </summary>
    public sealed class GameMenuViewModel : ViewModelBase, IDisposable
    {
        private const string LogDialogDisplayError = "Error displaying dialog ViewId={ViewId}.";

        private readonly INavigationService _navigationService;
        private readonly ILobbySession _lobbySession;
        private readonly ILoggerService _logger;
        private string _username;

        /// <summary>
        /// Initializes a new instance of the <see cref="GameMenuViewModel"/> class with the navigation service.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views and modal dialogs.</param>
        /// <param name="lobbySession">The active lobby state shared across the lobby flow.</param>
        /// <param name="logger">Structured logger for menu navigation failures.</param>
        public GameMenuViewModel(INavigationService navigationService, ILobbySession lobbySession,
            ILoggerService logger)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));

            LoadCurrentUsername();

            ProfileCommand = new RelayCommand(ExecuteProfile);
            ScoreBoardCommand = new RelayCommand(ExecuteScoreBoard);
            CreateRoomCommand = new RelayCommand(ExecuteCreateRoom);
            JoinLobbyCommand = new RelayCommand(ExecuteJoinLobby);
            HowToPlayCommand = new RelayCommand(ExecuteHowToPlay);
            SignOutCommand = new AsyncRelayCommand(ExecuteSignOutAsync);
        }

        /// <summary>
        /// Gets or sets the display username of the currently active player.
        /// </summary>
        public string Username
        {
            get => _username;
            set => SetProperty(ref _username, value);
        }

        /// <summary>
        /// Gets the command that navigates to the user's profile view.
        /// </summary>
        public ICommand ProfileCommand { get; }

        /// <summary>
        /// Gets the command that presents the scoreboard and leaderboard modal dialog.
        /// </summary>
        public ICommand ScoreBoardCommand { get; }

        /// <summary>
        /// Gets the command that displays game settings and creates a match lobby.
        /// </summary>
        public ICommand CreateRoomCommand { get; }

        /// <summary>
        /// Gets the command that prompts for a game code to join an existing lobby.
        /// </summary>
        public ICommand JoinLobbyCommand { get; }

        /// <summary>
        /// Gets the command that displays the game rules and guide dialog.
        /// </summary>
        public ICommand HowToPlayCommand { get; }

        /// <summary>
        /// Gets the command that clears the active user session and returns to the home screen.
        /// </summary>
        public ICommand SignOutCommand { get; }

        public ProfileImageViewModel CurrentPlayerProfileImage { get; private set; }

        public void ConfigureProfileImages(IProfileImageCache profileImageCache)
        {
            CurrentPlayerProfileImage?.Dispose();
            CurrentPlayerProfileImage = new ProfileImageViewModel(UserSession.Current.EnsureActiveUserId(),
                profileImageCache);
            OnPropertyChanged(nameof(CurrentPlayerProfileImage));
        }

        public void Dispose()
        {
            CurrentPlayerProfileImage?.Dispose();
        }

        private void LoadCurrentUsername()
        {
            UserSessionData currentUser = UserSession.Current.CurrentUser;
            if (currentUser != null && !string.IsNullOrWhiteSpace(currentUser.Username))
            {
                Username = currentUser.Username;
            }
            else
            {
                Username = string.Empty;
            }
        }

        private void ExecuteProfile()
        {
            _navigationService.NavigateTo(ViewId.Profile);
        }

        private void ExecuteScoreBoard()
        {
            ShowModalDialogSafely(ViewId.ScoreBoardDialog, null);
        }

        private void ExecuteCreateRoom()
        {
            _lobbySession.ClearLobby();
            ShowModalDialogSafely(ViewId.GameSettingsDialog, NavigateToActiveLobbyIfPresent);
        }

        private void ExecuteJoinLobby()
        {
            _lobbySession.ClearLobby();
            ShowModalDialogSafely(ViewId.EnterGameCodeDialog, NavigateToActiveLobbyIfPresent);
        }

        private void ExecuteHowToPlay()
        {
            ShowModalDialogSafely(ViewId.HowToPlayDialog, null);
        }

        private void NavigateToActiveLobbyIfPresent()
        {
            if (_lobbySession.HasActiveLobby)
            {
                _navigationService.NavigateTo(ViewId.Lobby);
            }
        }

        private void ShowModalDialogSafely(int dialogViewId, Action onDialogCompleted)
        {
            try
            {
                _navigationService.ShowDialog(dialogViewId);
                onDialogCompleted?.Invoke();
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, LogDialogDisplayError, dialogViewId);
            }
        }

        private async Task ExecuteSignOutAsync()
        {
            UserSessionData currentUser = UserSession.Current.CurrentUser;
            if (currentUser != null && currentUser.IdUser > 0)
            {
                await FriendshipSession.Current.Client.UnsubscribeSocialEventsAsync(currentUser.IdUser);
            }

            FriendshipSession.Current.ClearSession();
            UserSession.Current.ClearSession();
            _navigationService.NavigateTo(ViewId.HomeScreen);
        }
    }
}
