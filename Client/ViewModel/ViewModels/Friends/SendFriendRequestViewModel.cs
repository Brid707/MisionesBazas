using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.IFriendsRequestService;
using Model.Session;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for searching players, dispatching friend invitations, and cancelling sent requests.
    /// </summary>
    public sealed class SendFriendRequestViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;
        private readonly IFriendshipSession _friendshipSession;
        private string _username;

        /// <summary>
        /// Initializes a new instance of the <see cref="SendFriendRequestViewModel"/> class using default session state.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views.</param>
        /// <param name="dialogService">Service for presenting modal validation feedback.</param>
        public SendFriendRequestViewModel(INavigationService navigationService, IDialogService dialogService)
            : this(navigationService, dialogService, FriendshipSession.Current)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SendFriendRequestViewModel"/> class with explicit dependencies.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views.</param>
        /// <param name="dialogService">Service for presenting modal validation feedback.</param>
        /// <param name="friendshipSession">Active social session providing friend request services.</param>
        public SendFriendRequestViewModel(
            INavigationService navigationService,
            IDialogService dialogService,
            IFriendshipSession friendshipSession)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _friendshipSession = friendshipSession ?? throw new ArgumentNullException(nameof(friendshipSession));
            _username = string.Empty;

            SentRequests = new ObservableCollection<FriendRequestItemViewModel>();

            BackCommand = new RelayCommand(ExecuteBack);
            SendCommand = new AsyncRelayCommand(ExecuteSendAsync);
            CancelSentRequestCommand = new AsyncRelayCommand(ExecuteCancelSentRequestAsync);

            _ = LoadSentRequestsAsync();
        }

        /// <summary>
        /// Gets the observable collection of pending outgoing friend requests sent by the current player.
        /// </summary>
        public ObservableCollection<FriendRequestItemViewModel> SentRequests { get; }

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

        private async Task LoadSentRequestsAsync()
        {
            int currentUserId = GetAuthenticatedUserId();

            if (currentUserId > 0)
            {
                IList<FriendRequest> requestsFromServer =
                    await _friendshipSession.RequestClient.GetSentFriendRequestByUserIdAsync(currentUserId);

                SentRequests.Clear();

                if (requestsFromServer != null)
                {
                    foreach (FriendRequest request in requestsFromServer)
                    {
                        if (request != null)
                        {
                            FriendRequestItemViewModel item = new FriendRequestItemViewModel(
                                request.SenderUserId,
                                request.SenderUsername,
                                request.ReceiverUserId,
                                request.ReceiverUsername,
                                request.RequestedAt);
                            SentRequests.Add(item);
                        }
                    }
                }
            }
        }

        private void ExecuteBack()
        {
            _navigationService.GoBack();
        }

        private async Task ExecuteSendAsync()
        {
            string trimmedUsername = _username?.Trim();

            if (string.IsNullOrWhiteSpace(trimmedUsername))
            {
                _dialogService.ShowWarning(MessageCode.EmptyFriendUsername);
            }
            else
            {
                int currentUserId = GetAuthenticatedUserId();

                if (currentUserId > 0)
                {
                    OperationResult result = await _friendshipSession.RequestClient.SendFriendRequestAsync(
                        currentUserId,
                        trimmedUsername);

                    if (result == null)
                    {
                        _dialogService.ShowError(MessageCode.ConnectionFailed);
                    }
                    else if (!result.IsSuccess)
                    {
                        _dialogService.ShowWarning(MessageCode.UnexpectedError);
                    }
                    else
                    {
                        Username = string.Empty;
                        await LoadSentRequestsAsync();
                    }
                }
                else
                {
                    _dialogService.ShowWarning(MessageCode.UnexpectedError);
                }
            }
        }

        private async Task ExecuteCancelSentRequestAsync(object parameter)
        {
            FriendRequestItemViewModel requestItem = parameter as FriendRequestItemViewModel;
            int currentUserId = GetAuthenticatedUserId();

            if (requestItem != null && currentUserId > 0)
            {
                OperationResult result = await _friendshipSession.RequestClient.CancelFriendRequestAsync(
                    currentUserId,
                    requestItem.ReceiverUserId);

                if (result == null)
                {
                    _dialogService.ShowError(MessageCode.ConnectionFailed);
                }
                else if (result.IsSuccess)
                {
                    SentRequests.Remove(requestItem);
                }
                else
                {
                    _dialogService.ShowWarning(MessageCode.UnexpectedError);
                }
            }
        }

        private static int GetAuthenticatedUserId()
        {
            int userId = 0;

            if (UserSession.Current.IsAuthenticated && UserSession.Current.CurrentUser != null)
            {
                userId = UserSession.Current.CurrentUser.IdUser;
            }

            return userId;
        }
    }
}
