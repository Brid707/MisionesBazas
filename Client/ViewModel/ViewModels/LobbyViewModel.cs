using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing room state, player readiness, and navigation from the game lobby.
    /// </summary>
    public sealed class LobbyViewModel : ViewModelBase
    {
        private const string DefaultMissionsTarget = "5";
        private const string DefaultLobbyCode = "XXXXX";

        private readonly INavigationService _navigationService;
        private string _missionsTarget;
        private string _lobbyCode;
        private bool _isReady;

        /// <summary>
        /// Initializes a new instance of the <see cref="LobbyViewModel"/> class.
        /// </summary>
        /// <param name="navigationService">Service for navigating views and opening modal dialogs.</param>
        public LobbyViewModel(INavigationService navigationService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _missionsTarget = DefaultMissionsTarget;
            _lobbyCode = DefaultLobbyCode;
            _isReady = false;

            BackCommand = new RelayCommand(ExecuteBack);
            ProfileCommand = new RelayCommand(ExecuteProfile);
            SettingsCommand = new RelayCommand(ExecuteSettings);
            ToggleReadyCommand = new RelayCommand(ExecuteToggleReady);
        }

        /// <summary>
        /// Gets or sets the target mission count displayed in the lobby header.
        /// </summary>
        public string MissionsTarget
        {
            get => _missionsTarget;
            set => SetProperty(ref _missionsTarget, value);
        }

        /// <summary>
        /// Gets or sets the room invitation code.
        /// </summary>
        public string LobbyCode
        {
            get => _lobbyCode;
            set => SetProperty(ref _lobbyCode, value);
        }

        /// <summary>
        /// Gets or sets a value indicating whether the current player is marked as ready to start.
        /// </summary>
        public bool IsReady
        {
            get => _isReady;
            set => SetProperty(ref _isReady, value);
        }

        /// <summary>
        /// Gets the command that returns to the game menu.
        /// </summary>
        public ICommand BackCommand { get; }

        /// <summary>
        /// Gets the command that navigates to the player profile.
        /// </summary>
        public ICommand ProfileCommand { get; }

        /// <summary>
        /// Gets the command that opens the game settings dialog for room owners.
        /// </summary>
        public ICommand SettingsCommand { get; }

        /// <summary>
        /// Gets the command that toggles the current player's readiness state.
        /// </summary>
        public ICommand ToggleReadyCommand { get; }

        private void ExecuteBack()
        {
            _navigationService.GoBack();
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

        private void ExecuteToggleReady()
        {
            IsReady = !IsReady;
        }
    }
}
