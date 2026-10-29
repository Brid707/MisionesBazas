using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for searching players and sending friend invitations.
    /// </summary>
    public sealed class SendFriendRequestViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;
        private string _username;

        /// <summary>
        /// Initializes a new instance of the <see cref="SendFriendRequestViewModel"/> class.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views.</param>
        /// <param name="dialogService">Service for presenting modal validation feedback.</param>
        public SendFriendRequestViewModel(INavigationService navigationService, IDialogService dialogService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _username = string.Empty;

            BackCommand = new RelayCommand(ExecuteBack);
            SendCommand = new RelayCommand(ExecuteSend);
            CancelSentRequestCommand = new RelayCommand(ExecuteCancelSentRequest);
        }

        /// <summary>
        /// Gets or sets the target player's username to which the friend request will be sent.
        /// </summary>
        public string Username
        {
            get => _username;
            set => SetProperty(ref _username, value);
        }

        /// <summary>
        /// Gets the command that navigates back to the preceding view.
        /// </summary>
        public ICommand BackCommand { get; }

        /// <summary>
        /// Gets the command that validates input and dispatches a friend request to the target player.
        /// </summary>
        public ICommand SendCommand { get; }

        /// <summary>
        /// Gets the command that cancels an existing pending outgoing request.
        /// </summary>
        public ICommand CancelSentRequestCommand { get; }

        private void ExecuteBack()
        {
            _navigationService.GoBack();
        }

        private void ExecuteSend()
        {
            if (string.IsNullOrWhiteSpace(_username))
            {
                _dialogService.ShowWarning(MessageCode.EmptyFriendUsername);
            }
            else
            {
                // TODO: Dispatch friend request through backend service once connected.
                Username = string.Empty;
            }
        }

        private void ExecuteCancelSentRequest()
        {
            // TODO: Cancel pending sent friend request via backend service once connected.
        }
    }
}
