using System;
using System.Text.RegularExpressions;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing user account registration and credential validation.
    /// Decoupled from visual controls and localized presentation.
    /// </summary>
    public sealed class RegisterViewModel : ViewModelBase
    {
        private const int MinimumPasswordLength = 8;
        private const string SpecialCharacterPattern = @"[^a-zA-Z0-9]";
        private const string NumberPattern = @"[0-9]";

        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;

        private string _email;
        private string _username;
        private string _password;
        private string _passwordConfirm;
        private bool _isLoading;

        /// <summary>
        /// Initializes a new instance of the <see cref="RegisterViewModel"/> class with the required UI services.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views using integer view identifiers.</param>
        /// <param name="dialogService">Service for presenting localized messages to the user using integer codes.</param>
        public RegisterViewModel(INavigationService navigationService, IDialogService dialogService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

            BackCommand = new RelayCommand(ExecuteBack);
            SubmitCommand = new RelayCommand(ExecuteSubmit, CanExecuteSubmit);
        }

        /// <summary>
        /// Gets or sets the email address to register.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets or sets the chosen username.
        /// </summary>
        public string Username
        {
            get => _username;
            set => SetProperty(ref _username, value);
        }

        /// <summary>
        /// Gets or sets the registration password.
        /// </summary>
        public string Password
        {
            get => _password;
            set => SetProperty(ref _password, value);
        }

        /// <summary>
        /// Gets or sets the confirmation password.
        /// </summary>
        public string PasswordConfirm
        {
            get => _passwordConfirm;
            set => SetProperty(ref _passwordConfirm, value);
        }

        /// <summary>
        /// Indicates whether an asynchronous registration operation is in progress.
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
        /// Gets the command that returns to the previous view or home screen.
        /// </summary>
        public ICommand BackCommand { get; }

        /// <summary>
        /// Gets the command that validates credentials and submits registration to the server.
        /// </summary>
        public ICommand SubmitCommand { get; }

        private bool CanExecuteSubmit()
        {
            return !IsLoading;
        }

        private void ExecuteBack()
        {
            _navigationService.GoBack();
        }

        private void ExecuteSubmit()
        {
            string email = Email?.Trim() ?? string.Empty;
            string username = Username?.Trim() ?? string.Empty;
            string password = Password ?? string.Empty;
            string passwordConfirm = PasswordConfirm ?? string.Empty;

            if (IsRegistrationDataValid(email, username, password, passwordConfirm))
            {
                // TODO: Dispatch user registration to WCF service once registration contract is integrated.
                _dialogService.ShowInformation(MessageCode.RegisterSuccess);
                _navigationService.NavigateTo(ViewId.LoginPage);
            }
        }

        private bool IsRegistrationDataValid(string email, string username, string password, string passwordConfirm)
        {
            bool isValid = false;

            if (string.IsNullOrWhiteSpace(email))
            {
                _dialogService.ShowWarning(MessageCode.RegisterEmptyEmail);
            }
            else if (string.IsNullOrWhiteSpace(username))
            {
                _dialogService.ShowWarning(MessageCode.RegisterEmptyUsername);
            }
            else if (string.IsNullOrEmpty(password))
            {
                _dialogService.ShowWarning(MessageCode.RegisterEmptyPassword);
            }
            else if (string.IsNullOrEmpty(passwordConfirm))
            {
                _dialogService.ShowWarning(MessageCode.RegisterEmptyPasswordConfirmation);
            }
            else if (!IsValidEmailFormat(email))
            {
                _dialogService.ShowWarning(MessageCode.RegisterInvalidEmail);
            }
            else if (!IsPasswordComplexityMet(password))
            {
                // Warning is dispatched inside IsPasswordComplexityMet
            }
            else if (!password.Equals(passwordConfirm, StringComparison.Ordinal))
            {
                _dialogService.ShowWarning(MessageCode.RegisterPasswordMismatch);
            }
            else
            {
                isValid = true;
            }

            return isValid;
        }

        private bool IsValidEmailFormat(string email)
        {
            bool isEmailValid = false;

            if (!string.IsNullOrWhiteSpace(email))
            {
                string sanitizedEmail = email.Trim();
                int atIndex = sanitizedEmail.IndexOf('@');
                int dotIndex = sanitizedEmail.LastIndexOf('.');

                isEmailValid = atIndex > 0
                    && dotIndex > atIndex + 1
                    && dotIndex < sanitizedEmail.Length - 1
                    && !sanitizedEmail.Contains(" ")
                    && sanitizedEmail.IndexOf('@') == sanitizedEmail.LastIndexOf('@');
            }

            return isEmailValid;
        }

        private bool IsPasswordComplexityMet(string password)
        {
            bool isComplex = false;

            if (password.Length < MinimumPasswordLength)
            {
                _dialogService.ShowWarning(MessageCode.RegisterPasswordRuleLength);
            }
            else if (!Regex.IsMatch(password, SpecialCharacterPattern))
            {
                _dialogService.ShowWarning(MessageCode.RegisterPasswordRuleSpecialChar);
            }
            else if (!Regex.IsMatch(password, NumberPattern))
            {
                _dialogService.ShowWarning(MessageCode.RegisterPasswordRuleNumber);
            }
            else
            {
                isComplex = true;
            }

            return isComplex;
        }
    }
}
