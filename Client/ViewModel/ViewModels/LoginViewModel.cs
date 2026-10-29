using System;
using System.ServiceModel;
using System.Windows.Input;
using Model.Security;
using Model.Session;
using Model.UserLoginService;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for handling user login logic, decoupled from WPF UI controls.
    /// Implements <see cref="IUserLoginCallback"/> to receive asynchronous authentication responses from WCF.
    /// </summary>
    public sealed class LoginViewModel : ViewModelBase, IUserLoginCallback
    {
        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;

        private string _email;
        private string _password;
        private bool _isLoading;

        /// <summary>
        /// Initializes a new instance of the <see cref="LoginViewModel"/> class with the required UI services.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views using integer view identifiers.</param>
        /// <param name="dialogService">Service for presenting localized messages to the user using integer codes.</param>
        public LoginViewModel(INavigationService navigationService, IDialogService dialogService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

            LoginCommand = new RelayCommand(ExecuteLogin, CanExecuteLogin);
            BackCommand = new RelayCommand(ExecuteBack);
            ForgotPasswordCommand = new RelayCommand(ExecuteForgotPassword);
        }

        /// <summary>
        /// Gets or sets the user email entered in the view.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets or sets the user password.
        /// </summary>
        public string Password
        {
            get => _password;
            set => SetProperty(ref _password, value);
        }

        /// <summary>
        /// Indicates whether an authentication request is currently in progress.
        /// </summary>
        public bool IsLoading
        {
            get => _isLoading;
            set
            {
                if (SetProperty(ref _isLoading, value))
                {
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        /// <summary>
        /// Gets the command that initiates the authentication process.
        /// </summary>
        public ICommand LoginCommand { get; }

        /// <summary>
        /// Gets the command that navigates back to the home screen or closes the modal window.
        /// </summary>
        public ICommand BackCommand { get; }

        /// <summary>
        /// Gets the command that displays the password recovery dialog.
        /// </summary>
        public ICommand ForgotPasswordCommand { get; }

        /// <summary>
        /// Handles the authentication response dispatched by the login service callback.
        /// </summary>
        /// <param name="success">Indicates whether credentials were authenticated successfully.</param>
        /// <param name="message">The outcome message provided by the server.</param>
        /// <param name="user">The authenticated user profile, or null if login failed.</param>
        public void LoginResult(bool success, string message, UserDTO user)
        {
            IsLoading = false;

            if (success)
            {
                if (user != null)
                {
                    UserSession.Current.SetUser(new UserSessionData
                    {
                        IdUser = user.IdUser,
                        Username = user.Username,
                        Email = user.Email
                    });
                }

                _navigationService.NavigateTo(ViewId.GameMenu);
            }
            else
            {
                _dialogService.ShowWarning(MessageCode.InvalidCredentials);
            }
        }

        private bool CanExecuteLogin()
        {
            return !IsLoading;
        }

        private void ExecuteLogin()
        {
            string email = Email?.Trim() ?? string.Empty;
            string password = Password ?? string.Empty;

            if (IsLoginInputValid(email, password))
            {
                try
                {
                    IsLoading = true;
                    string passwordHash = PasswordHasher.ComputeSha256Hash(password);
                    InstanceContext context = new InstanceContext(this);
                    UserLoginClient client = new UserLoginClient(context);

                    client.Login(email, passwordHash);
                }
                catch (EndpointNotFoundException ex)
                {
                    IsLoading = false;
                    // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                    Console.WriteLine($"[LoginViewModel] Connection failed: {ex.Message}");
                    _dialogService.ShowError(MessageCode.ConnectionFailed);
                }
                catch (TimeoutException ex)
                {
                    IsLoading = false;
                    // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                    Console.WriteLine($"[LoginViewModel] Request timed out: {ex.Message}");
                    _dialogService.ShowError(MessageCode.RequestTimeout);
                }
                catch (CommunicationException ex)
                {
                    IsLoading = false;
                    // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                    Console.WriteLine($"[LoginViewModel] Communication error: {ex.Message}");
                    _dialogService.ShowError(MessageCode.CommunicationError);
                }
            }
        }

        private bool IsLoginInputValid(string email, string password)
        {
            bool isValid = false;

            if (string.IsNullOrWhiteSpace(email))
            {
                _dialogService.ShowWarning(MessageCode.EmptyEmail);
            }
            else if (string.IsNullOrEmpty(password))
            {
                _dialogService.ShowWarning(MessageCode.EmptyPassword);
            }
            else
            {
                isValid = true;
            }

            return isValid;
        }

        private void ExecuteBack()
        {
            _navigationService.GoBack();
        }

        private void ExecuteForgotPassword()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.ForgotPasswordDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[LoginViewModel] Error displaying forgot password dialog: {ex.Message}");
            }
        }
    }
}
