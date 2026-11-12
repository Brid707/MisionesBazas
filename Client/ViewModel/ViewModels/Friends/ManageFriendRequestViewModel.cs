using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading;
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
    /// ViewModel for managing incoming friend requests, handling approvals and rejections.
    /// </summary>
    public sealed class ManageFriendRequestViewModel : ViewModelBase
    {
        private readonly IFriendshipSession _friendshipSession;
        private readonly IDialogService _dialogService;
        private readonly SynchronizationContext _uiSyncContext;
        private bool _hasPendingRequests;

        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestViewModel"/> class using default session state.
        /// </summary>
        public ManageFriendRequestViewModel()
            : this(FriendshipSession.Current, null)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestViewModel"/> class with explicit dependencies.
        /// </summary>
        /// <param name="friendshipSession">Active social session providing friend request services.</param>
        /// <param name="dialogService">Optional dialog service for displaying error alerts.</param>
        public ManageFriendRequestViewModel(IFriendshipSession friendshipSession, IDialogService dialogService = null)
        {
            _friendshipSession = friendshipSession ?? throw new ArgumentNullException(nameof(friendshipSession));
            _dialogService = dialogService;
            _uiSyncContext = SynchronizationContext.Current;

            PendingRequests = new ObservableCollection<FriendRequestItemViewModel>();
            _hasPendingRequests = false;

            CloseCommand = new RelayCommand(ExecuteClose);
            AcceptRequestCommand = new AsyncRelayCommand(ExecuteAcceptRequestAsync);
            RejectRequestCommand = new AsyncRelayCommand(ExecuteRejectRequestAsync);
            LoadRequestsCommand = new AsyncRelayCommand(LoadPendingRequestsAsync);

            _friendshipSession.Client.FriendRequestReceived += OnServerFriendRequestReceived;
            _ = LoadPendingRequestsAsync();
        }

        /// <summary>
        /// Occurs when the dialog window requests to close.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Gets the observable collection of pending incoming friend requests.
        /// </summary>
        public ObservableCollection<FriendRequestItemViewModel> PendingRequests { get; }

        /// <summary>
        /// Gets or sets a value indicating whether there are pending friend requests to display.
        /// </summary>
        public bool HasPendingRequests
        {
            get => _hasPendingRequests;
            set
            {
                if (SetProperty(ref _hasPendingRequests, value))
                {
                    OnPropertyChanged(nameof(HasNoPendingRequests));
                }
            }
        }

        /// <summary>
        /// Gets a value indicating whether the pending requests collection is empty.
        /// </summary>
        public bool HasNoPendingRequests => !_hasPendingRequests;

        /// <summary>
        /// Gets the command that dismisses the friend request management dialog.
        /// </summary>
        public ICommand CloseCommand { get; }

        /// <summary>
        /// Gets the command that accepts an incoming friend request.
        /// </summary>
        public ICommand AcceptRequestCommand { get; }

        /// <summary>
        /// Gets the command that rejects an incoming friend request.
        /// </summary>
        public ICommand RejectRequestCommand { get; }

        /// <summary>
        /// Gets the command that reloads pending friend requests from the backend.
        /// </summary>
        public ICommand LoadRequestsCommand { get; }

        private async Task LoadPendingRequestsAsync()
        {
            int currentUserId = GetAuthenticatedUserId();

            if (currentUserId > 0)
            {
                IList<FriendRequest> requestsFromServer =
                    await _friendshipSession.RequestClient.GetPendingFriendRequestByUserIdAsync(currentUserId);

                PendingRequests.Clear();

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
                            PendingRequests.Add(item);
                        }
                    }
                }

                HasPendingRequests = PendingRequests.Count > 0;
            }
            else
            {
                PendingRequests.Clear();
                HasPendingRequests = false;
            }
        }

        private void OnServerFriendRequestReceived(Model.IFriendShipService.FriendRequest incomingRequest)
        {
            if (incomingRequest != null)
            {
                FriendRequestItemViewModel item = new FriendRequestItemViewModel(
                    incomingRequest.SenderUserId,
                    incomingRequest.SenderUsername,
                    incomingRequest.ReceiverUserId,
                    incomingRequest.ReceiverUsername,
                    incomingRequest.RequestedAt);

                if (_uiSyncContext != null && SynchronizationContext.Current != _uiSyncContext)
                {
                    _uiSyncContext.Post(AddIncomingRequestOnUiThread, item);
                }
                else
                {
                    AddIncomingRequest(item);
                }
            }
        }

        private void AddIncomingRequestOnUiThread(object state)
        {
            if (state is FriendRequestItemViewModel item)
            {
                AddIncomingRequest(item);
            }
        }

        private void AddIncomingRequest(FriendRequestItemViewModel item)
        {
            bool alreadyExists = false;

            foreach (FriendRequestItemViewModel existing in PendingRequests)
            {
                if (existing.SenderUserId == item.SenderUserId)
                {
                    alreadyExists = true;
                }
            }

            if (!alreadyExists)
            {
                PendingRequests.Add(item);
                HasPendingRequests = PendingRequests.Count > 0;
            }
        }

        private void ExecuteClose()
        {
            _friendshipSession.Client.FriendRequestReceived -= OnServerFriendRequestReceived;
            RequestClose?.Invoke();
        }

        private async Task ExecuteAcceptRequestAsync(object parameter)
        {
            FriendRequestItemViewModel requestItem = parameter as FriendRequestItemViewModel;
            int currentUserId = GetAuthenticatedUserId();

            if (requestItem != null && currentUserId > 0)
            {
                OperationResult result = await _friendshipSession.RequestClient.AcceptFriendRequestAsync(
                    currentUserId,
                    requestItem.SenderUserId);

                if (result == null)
                {
                    _dialogService?.ShowError(MessageCode.ConnectionFailed);
                }
                else if (result.IsSuccess)
                {
                    PendingRequests.Remove(requestItem);
                    HasPendingRequests = PendingRequests.Count > 0;
                    _friendshipSession.NotifyFriendsListChanged();
                }
                else
                {
                    _dialogService?.ShowWarning(MessageCode.UnexpectedError);
                }
            }
        }

        private async Task ExecuteRejectRequestAsync(object parameter)
        {
            FriendRequestItemViewModel requestItem = parameter as FriendRequestItemViewModel;
            int currentUserId = GetAuthenticatedUserId();

            if (requestItem != null && currentUserId > 0)
            {
                OperationResult result = await _friendshipSession.RequestClient.RejectFriendRequestAsync(
                    currentUserId,
                    requestItem.SenderUserId);

                if (result == null)
                {
                    _dialogService?.ShowError(MessageCode.ConnectionFailed);
                }
                else if (result.IsSuccess)
                {
                    PendingRequests.Remove(requestItem);
                    HasPendingRequests = PendingRequests.Count > 0;
                }
                else
                {
                    _dialogService?.ShowWarning(MessageCode.UnexpectedError);
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
