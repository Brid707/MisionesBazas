using System;
using System.Windows.Input;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing interactions on the initial home screen.
    /// Exposes commands for navigating to authentication views, guest access, and language selection.
    /// </summary>
    public sealed class HomeScreenViewModel : ViewModelBase
    {
        private const string LogOpenLanguageSelectorError = "Error opening language selector dialog.";

        private readonly INavigationService _navigationService;
        private readonly ILoggerService _logger;

        /// <summary>
        /// Initializes a new instance of the <see cref="HomeScreenViewModel"/> class with the navigation service.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views using integer view identifiers.</param>
        /// <param name="logger">Structured logger for recording home screen navigation errors.</param>
        public HomeScreenViewModel(INavigationService navigationService, ILoggerService logger)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));

            SignUpCommand = new RelayCommand(ExecuteSignUp);
            LoginCommand = new RelayCommand(ExecuteLogin);
            GuestCommand = new RelayCommand(ExecuteGuest);
            SelectLanguageCommand = new RelayCommand(ExecuteSelectLanguage);
        }

        /// <summary>
        /// Gets the command that navigates to the account registration view.
        /// </summary>
        public ICommand SignUpCommand { get; }

        /// <summary>
        /// Gets the command that navigates to the user login view.
        /// </summary>
        public ICommand LoginCommand { get; }

        /// <summary>
        /// Gets the command that navigates directly into the game menu as a guest player.
        /// </summary>
        public ICommand GuestCommand { get; }

        /// <summary>
        /// Gets the command that presents the modal language selector dialog.
        /// </summary>
        public ICommand SelectLanguageCommand { get; }

        private void ExecuteSignUp()
        {
            _navigationService.NavigateTo(ViewId.RegisterPage);
        }

        private void ExecuteLogin()
        {
            _navigationService.NavigateTo(ViewId.LoginPage);
        }

        private void ExecuteGuest()
        {
            UserSession.Current.EnsureActiveUserId();
            _navigationService.NavigateTo(ViewId.GameMenu);
        }

        private void ExecuteSelectLanguage()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.SelectLanguageDialog);
                _navigationService.NavigateTo(ViewId.HomeScreen);
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, LogOpenLanguageSelectorError);
            }
        }
    }
}
