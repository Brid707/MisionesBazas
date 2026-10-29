using System;
using System.Windows.Input;
using Model.Session;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing interactions and navigation options from the primary game menu.
    /// </summary>
    public sealed class GameMenuViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;

        /// <summary>
        /// Initializes a new instance of the <see cref="GameMenuViewModel"/> class with the navigation service.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views and modal dialogs.</param>
        public GameMenuViewModel(INavigationService navigationService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));

            ProfileCommand = new RelayCommand(ExecuteProfile);
            ScoreBoardCommand = new RelayCommand(ExecuteScoreBoard);
            CreateRoomCommand = new RelayCommand(ExecuteCreateRoom);
            JoinLobbyCommand = new RelayCommand(ExecuteJoinLobby);
            HowToPlayCommand = new RelayCommand(ExecuteHowToPlay);
            SignOutCommand = new RelayCommand(ExecuteSignOut);
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

        private void ExecuteProfile()
        {
            _navigationService.NavigateTo(ViewId.Profile);
        }

        private void ExecuteScoreBoard()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.ScoreBoardDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[GameMenuViewModel] Error showing ScoreBoard dialog: {ex.Message}");
            }
        }

        private void ExecuteCreateRoom()
        {
            try
            {
                LobbySession.Current.ClearLobby();
                _navigationService.ShowDialog(ViewId.GameSettingsDialog);

                if (LobbySession.Current.HasActiveLobby)
                {
                    _navigationService.NavigateTo(ViewId.Lobby);
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[GameMenuViewModel] Error showing GameSettings dialog: {ex.Message}");
            }
        }

        private void ExecuteJoinLobby()
        {
            try
            {
                LobbySession.Current.ClearLobby();
                _navigationService.ShowDialog(ViewId.EnterGameCodeDialog);

                if (LobbySession.Current.HasActiveLobby)
                {
                    _navigationService.NavigateTo(ViewId.Lobby);
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[GameMenuViewModel] Error showing EnterGameCode dialog: {ex.Message}");
            }
        }

        private void ExecuteHowToPlay()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.HowToPlayDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[GameMenuViewModel] Error showing HowToPlay dialog: {ex.Message}");
            }
        }

        private void ExecuteSignOut()
        {
            UserSession.Current.ClearSession();
            _navigationService.NavigateTo(ViewId.HomeScreen);
        }
    }
}
