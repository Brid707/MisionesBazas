using System;
using System.Text.RegularExpressions;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for updating user credentials during password reset or recovery.
    /// </summary>
    public sealed class ChangePasswordViewModel : ViewModelBase
    {
        private const int MinimumPasswordLength = 8;
        private const string SpecialCharacterPattern = @"[^a-zA-Z0-9]";
        private const string NumberPattern = @"[0-9]";

        private readonly IDialogService _dialogService;
        private string _newPassword;
        private string _confirmPassword;

        /// <summary>
        /// Occurs when the dialog requests to close.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="ChangePasswordViewModel"/> class.
        /// </summary>
        /// <param name="dialogService">Service for presenting localized error and success messages.</param>
        public ChangePasswordViewModel(IDialogService dialogService)
        {
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

            CloseCommand = new RelayCommand(ExecuteClose);
            ConfirmCommand = new RelayCommand(ExecuteConfirm);
        }

        /// <summary>
        /// Gets or sets the new password string.
        /// </summary>
        public string NewPassword
        {
            get => _newPassword;
            set => SetProperty(ref _newPassword, value);
        }

        /// <summary>
        /// Gets or sets the confirmation of the new password.
        /// </summary>
        public string ConfirmPassword
        {
            get => _confirmPassword;
            set => SetProperty(ref _confirmPassword, value);
        }

        /// <summary>
        /// Gets the command that closes the dialog without saving changes.
        /// </summary>
        public ICommand CloseCommand { get; }

        /// <summary>
        /// Gets the command that validates and submits the new password.
        /// </summary>
        public ICommand ConfirmCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }

        private void ExecuteConfirm()
        {
            string password = NewPassword ?? string.Empty;
            string confirm = ConfirmPassword ?? string.Empty;

            if (IsPasswordValid(password, confirm))
            {
                // TODO: Dispatch updated password to WCF service once password update contract is available.
                RequestClose?.Invoke();
            }
        }

        private bool IsPasswordValid(string password, string confirm)
        {
            bool isValid = false;

            if (string.IsNullOrEmpty(password))
            {
                _dialogService.ShowWarning(MessageCode.RegisterEmptyPassword);
            }
            else if (string.IsNullOrEmpty(confirm))
            {
                _dialogService.ShowWarning(MessageCode.RegisterEmptyPasswordConfirmation);
            }
            else if (password.Length < MinimumPasswordLength)
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
            else if (!password.Equals(confirm, StringComparison.Ordinal))
            {
                _dialogService.ShowWarning(MessageCode.RegisterPasswordMismatch);
            }
            else
            {
                isValid = true;
            }

            return isValid;
        }
    }
}
