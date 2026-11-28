using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.IFriendsRequestService;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
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
        private const string OperationAcceptRequest = "Accept";
        private const string OperationRejectRequest = "Reject";
        private const string LogLoadPendingRequestsUnavailable = "Could not load pending friend requests for UserId={UserId}: server returned null.";
        private const string LogFriendRequestDecisionUnavailable = "Friend request operation {Operation} for SenderUserId={SenderUserId} failed: service unavailable.";
        private const string LogFriendRequestDecisionRejected = "Friend request operation {Operation} for SenderUserId={SenderUserId} rejected with ErrorCode={ErrorCode}.";

        private readonly IFriendshipSession _friendshipSession;
        private readonly IDialogService _dialogService;
        private readonly ILoggerService _logger;
        private readonly SynchronizationContext _uiSyncContext;
        private bool _hasPendingRequests;

        /// <summary>Initializes social actions and profile navigation from the shared UI dependencies.</summary>
        public ManageFriendRequestViewModel(IFriendshipSession friendshipSession, ViewModelUiServices uiServices)
            : this(friendshipSession, uiServices.DialogService, uiServices.Logger)
        {
            PlayerProfiles = uiServices.PlayerProfiles;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestViewModel"/> class using default session state.
        /// </summary>
        /// <param name="logger">Structured logger for recording social operation failures.</param>
        public ManageFriendRequestViewModel(ILoggerService logger)
            : this(FriendshipSession.Current, null, logger)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestViewModel"/> class without an optional dialog service.
        /// </summary>
        /// <param name="friendshipSession">Active social session providing friend request services.</param>
        /// <param name="logger">Structured logger for recording social operation failures.</param>
        public ManageFriendRequestViewModel(IFriendshipSession friendshipSession, ILoggerService logger)
            : this(friendshipSession, null, logger)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestViewModel"/> class with explicit dependencies.
        /// </summary>
        /// <param name="friendshipSession">Active social session providing friend request services.</param>
        /// <param name="dialogService">Optional dialog service for displaying error alerts.</param>
        /// <param name="logger">Structured logger for recording social operation failures.</param>
        public ManageFriendRequestViewModel(
            IFriendshipSession friendshipSession,
            IDialogService dialogService,
            ILoggerService logger)
        {
            _friendshipSession = friendshipSession ?? throw new ArgumentNullException(nameof(friendshipSession));
            _dialogService = dialogService;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
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

        /// <summary>Gets the shared profile-opening actions for this screen.</summary>
        public PlayerProfileCommands PlayerProfiles { get; } = new PlayerProfileCommands(null, false);

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
                _logger.Warning(LogLoadPendingRequestsUnavailable, currentUserId);
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

                if (TryApplyRequestDecisionResult(result, requestItem, OperationAcceptRequest))
                {
                    _friendshipSession.NotifyFriendsListChanged();
                }
            }
        }

        private async Task ExecuteRejectRequestAsync(object parameter)
        {
            FriendRequestItemViewModel requestItem = parameter as FriendRequestItemViewModel;
            int currentUserId = GetAuthenticatedUserId();

            if (requestItem != null && currentUserId > 0)
            {
                OperationResult result = await _friendshipSession.RequestClient.RejectFriendRequestAsync(currentUserId,
                    requestItem.SenderUserId);

                TryApplyRequestDecisionResult(result, requestItem, OperationRejectRequest);
            }
        }

        private bool TryApplyRequestDecisionResult(
            OperationResult result,
            FriendRequestItemViewModel requestItem,
            string operationName)
        {
            if (result == null)
            {
                _logger.Error(LogFriendRequestDecisionUnavailable, operationName, requestItem.SenderUserId);
                _dialogService?.ShowError(MessageCode.ConnectionFailed);
                return false;
            }

            if (result.IsSuccess)
            {
                PendingRequests.Remove(requestItem);
                HasPendingRequests = PendingRequests.Count > 0;
                return true;
            }

            _logger.Warning(LogFriendRequestDecisionRejected, operationName, requestItem.SenderUserId, result.ErrorCode);
            _dialogService?.ShowWarning(MessageCode.UnexpectedError);
            return false;
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
