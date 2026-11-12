using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing verification code entry and password recovery validation.
    /// </summary>
    public sealed class RecoverPasswordViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;

        private string _email;
        private string _code;
        private bool _isResending;

        /// <summary>
        /// Occurs when the view requests returning to the initial email input step.
        /// </summary>
        public event Action RequestBack;

        /// <summary>
        /// Occurs when the dialog requests to close entirely.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="RecoverPasswordViewModel"/> class with the required UI services.
        /// </summary>
        /// <param name="navigationService">Service for presenting dialogs.</param>
        /// <param name="dialogService">Service for displaying localized messages.</param>
        /// <param name="email">The email address of the account being recovered.</param>
        public RecoverPasswordViewModel(INavigationService navigationService, IDialogService dialogService, string email = "")
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _email = email ?? string.Empty;

            BackCommand = new RelayCommand(ExecuteBack);
            CloseCommand = new RelayCommand(ExecuteClose);
            ResendCodeCommand = new RelayCommand(ExecuteResendCode, CanExecuteResendCode);
            ConfirmCodeCommand = new RelayCommand(ExecuteConfirmCode);
        }

        /// <summary>
        /// Indicates whether a recovery code resend operation is currently in progress.
        /// </summary>
        public bool IsResending
        {
            get => _isResending;
            set
            {
                if (SetProperty(ref _isResending, value))
                {
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        /// <summary>
        /// Gets or sets the target account email address.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets or sets the verification code entered by the user.
        /// </summary>
        public string Code
        {
            get => _code;
            set => SetProperty(ref _code, value);
        }

        /// <summary>
        /// Gets the command that navigates back to the email input step.
        /// </summary>
        public ICommand BackCommand { get; }

        /// <summary>
        /// Gets the command that dismisses the recovery flow.
        /// </summary>
        public ICommand CloseCommand { get; }

        /// <summary>
        /// Gets the command that triggers a new recovery code dispatch.
        /// </summary>
        public ICommand ResendCodeCommand { get; }

        /// <summary>
        /// Gets the command that validates the entered verification code and opens the password reset dialog.
        /// </summary>
        public ICommand ConfirmCodeCommand { get; }

        private bool CanExecuteResendCode()
        {
            return !_isResending;
        }

        private void ExecuteBack()
        {
            RequestBack?.Invoke();
        }

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }

        private void ExecuteResendCode()
        {
            // TODO: Dispatch code resend request via backend service.
        }

        private void ExecuteConfirmCode()
        {
            try
            {
                // TODO: Validate verification code with server before opening password reset dialog.
                _navigationService.ShowDialog(ViewId.ChangePasswordDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
                Console.WriteLine($"[RecoverPasswordViewModel] Error opening ChangePassword dialog: {ex.Message}");
            }
        }
    }
}
