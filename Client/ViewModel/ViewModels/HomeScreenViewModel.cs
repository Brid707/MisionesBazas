using System;
using System.Windows.Input;
using Model.Session;
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
        private readonly INavigationService _navigationService;

        /// <summary>
        /// Initializes a new instance of the <see cref="HomeScreenViewModel"/> class with the navigation service.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views using integer view identifiers.</param>
        public HomeScreenViewModel(INavigationService navigationService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));

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
            int randomValue = Math.Abs(Guid.NewGuid().GetHashCode());
            int guestId = -((randomValue % 9000) + 1000);
            int guestSuffix = Math.Abs(guestId % 10000);

            UserSession.Current.SetUser(new UserSessionData
            {
                IdUser = guestId,
                Username = $"Guest_{guestSuffix:D4}",
                Email = string.Empty
            });

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
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[HomeScreenViewModel] Error opening language selector: {ex.Message}");
            }
        }
    }
}
