using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing user password recovery initiation via email.
    /// </summary>
    public sealed class ForgotPasswordViewModel : ViewModelBase
    {
        private readonly IDialogService _dialogService;
        private string _email;

        /// <summary>
        /// Occurs when the dialog requests to close.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Occurs when a valid email address is submitted to proceed to verification code entry.
        /// </summary>
        public event Action<string> EmailSubmitted;

        /// <summary>
        /// Initializes a new instance of the <see cref="ForgotPasswordViewModel"/> class.
        /// </summary>
        /// <param name="dialogService">Service for displaying localized messages.</param>
        public ForgotPasswordViewModel(IDialogService dialogService)
        {
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

            CloseCommand = new RelayCommand(ExecuteClose);
            SendCommand = new RelayCommand(ExecuteSend);
        }

        /// <summary>
        /// Gets or sets the email entered by the user.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets the command that dismisses the recovery dialog.
        /// </summary>
        public ICommand CloseCommand { get; }

        /// <summary>
        /// Gets the command that validates the entered email and initiates code dispatch.
        /// </summary>
        public ICommand SendCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }

        private void ExecuteSend()
        {
            string trimmedEmail = Email?.Trim() ?? string.Empty;

            if (string.IsNullOrWhiteSpace(trimmedEmail))
            {
                _dialogService.ShowWarning(MessageCode.EmptyEmail);
            }
            else
            {
                EmailSubmitted?.Invoke(trimmedEmail);
            }
        }
    }
}
