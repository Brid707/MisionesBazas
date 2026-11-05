using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.IFriendShipService;
using Model.Services;
using Model.Session;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing social interactions, friend lists, real-time status updates, and game invitations.
    /// </summary>
    public sealed class FriendsViewModel : ViewModelBase
    {
        private const int ServerErrorCodeLobbyFull = 104;

        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;
        private readonly IFriendshipSession _friendshipSession;
        private readonly ILobbySession _lobbySession;
        private readonly SynchronizationContext _uiSyncContext;
        private readonly List<FriendItemViewModel> _allFriends;

        private bool _isInLobby;
        private bool _isFilteringOnlineOnly;

        /// <summary>
        /// Initializes a new instance of the <see cref="FriendsViewModel"/> class using default session singletons.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views and modal dialogs.</param>
        public FriendsViewModel(INavigationService navigationService)
            : this(navigationService, null, FriendshipSession.Current, LobbySession.Current)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="FriendsViewModel"/> class with explicit dependencies.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views and modal dialogs.</param>
        /// <param name="dialogService">Optional service for displaying user alerts.</param>
        /// <param name="friendshipSession">Active social session providing friendship channels.</param>
        /// <param name="lobbySession">Active lobby session used when dispatching match invitations.</param>
        public FriendsViewModel(INavigationService navigationService, IDialogService dialogService,
            IFriendshipSession friendshipSession, ILobbySession lobbySession)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _dialogService = dialogService;
            _friendshipSession = friendshipSession ?? throw new ArgumentNullException(nameof(friendshipSession));
            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _uiSyncContext = SynchronizationContext.Current;

            _allFriends = new List<FriendItemViewModel>();
            Friends = new ObservableCollection<FriendItemViewModel>();
            GameInvitations = new ObservableCollection<GameInvitationItemViewModel>();
            _isInLobby = false;
            _isFilteringOnlineOnly = false;

            OpenManageFriendRequestsCommand = new AsyncRelayCommand(ExecuteOpenManageFriendRequestsAsync);
            AddFriendCommand = new RelayCommand(ExecuteAddFriend);
            ViewProfileCommand = new RelayCommand(ExecuteViewProfile);
            DeleteFriendCommand = new AsyncRelayCommand(ExecuteDeleteFriendAsync);
            InviteFriendCommand = new AsyncRelayCommand(ExecuteInviteFriendAsync);
            AcceptGameInvitationCommand = new AsyncRelayCommand(ExecuteAcceptGameInvitationAsync);
            RejectGameInvitationCommand = new RelayCommand(ExecuteRejectGameInvitation);
            FilterFriendsCommand = new AsyncRelayCommand(ExecuteFilterFriendsAsync);

            SubscribeToSocialEvents();
            _ = InitializeSocialStateAsync();
        }

        /// <summary>
        /// Gets the observable collection of friends currently displayed in the sidebar.
        /// </summary>
        public ObservableCollection<FriendItemViewModel> Friends { get; }

        /// <summary>
        /// Gets the observable collection of incoming match invitations displayed in the sidebar.
        /// </summary>
        public ObservableCollection<GameInvitationItemViewModel> GameInvitations { get; }

        /// <summary>
        /// Gets or sets a value indicating whether the friends bar is hosted inside an active match lobby.
        /// </summary>
        public bool IsInLobby
        {
            get => _isInLobby;
            set => SetProperty(ref _isInLobby, value);
        }

        /// <summary>
        /// Gets the command that displays the pending and incoming friend requests dialog.
        /// </summary>
        public ICommand OpenManageFriendRequestsCommand { get; }

        /// <summary>
        /// Gets the command that navigates to the page for dispatching new friend requests.
        /// </summary>
        public ICommand AddFriendCommand { get; }

        /// <summary>
        /// Gets the command that navigates to a selected user profile.
        /// </summary>
        public ICommand ViewProfileCommand { get; }

        /// <summary>
        /// Gets the command that removes a friendship connection.
        /// </summary>
        public ICommand DeleteFriendCommand { get; }

        /// <summary>
        /// Gets the command that invites a friend to join the current lobby match.
        /// </summary>
        public ICommand InviteFriendCommand { get; }

        /// <summary>
        /// Gets the command that accepts an incoming match invitation and joins the lobby.
        /// </summary>
        public ICommand AcceptGameInvitationCommand { get; }

        /// <summary>
        /// Gets the command that dismisses an incoming match invitation.
        /// </summary>
        public ICommand RejectGameInvitationCommand { get; }

        /// <summary>
        /// Gets the command that filters or refreshes the friends list.
        /// </summary>
        public ICommand FilterFriendsCommand { get; }

        private async Task InitializeSocialStateAsync()
        {
            int currentUserId = GetAuthenticatedUserId();

            if (IsValidUserId(currentUserId))
            {
                await _friendshipSession.Client.SubscribeSocialEventsAsync(currentUserId);
                await LoadFriendsListAsync();
            }
        }

        private async Task LoadFriendsListAsync()
        {
            int currentUserId = GetAuthenticatedUserId();

            if (IsValidUserId(currentUserId))
            {
                IList<Friend> friendsFromServer =await 
                    _friendshipSession.Client.GetFriendsListByUserIdAsync(currentUserId);

                _allFriends.Clear();

                if (friendsFromServer != null)
                {
                    foreach (Friend friend in friendsFromServer)
                    {
                        if (friend != null)
                        {
                            FriendItemViewModel item = new FriendItemViewModel(
                                friend.UserId,
                                friend.Username,
                                friend.IsOnline);
                            _allFriends.Add(item);
                        }
                    }
                }

                ApplyFriendsFilter();
            }
        }

        private void ApplyFriendsFilter()
        {
            Friends.Clear();

            foreach (FriendItemViewModel friendItem in _allFriends)
            {
                bool shouldInclude = !_isFilteringOnlineOnly || friendItem.IsOnline;
                if (shouldInclude)
                {
                    Friends.Add(friendItem);
                }
            }
        }

        private void SubscribeToSocialEvents()
        {
            IFriendshipClient client = _friendshipSession.Client;
            client.FriendStatusChanged -= OnServerFriendStatusChanged;
            client.FriendStatusChanged += OnServerFriendStatusChanged;
            client.FriendRemoved -= OnServerFriendRemoved;
            client.FriendRemoved += OnServerFriendRemoved;
            client.GameInvitationReceived -= OnServerGameInvitationReceived;
            client.GameInvitationReceived += OnServerGameInvitationReceived;
            _friendshipSession.FriendsListChanged -= OnSessionFriendsListChanged;
            _friendshipSession.FriendsListChanged += OnSessionFriendsListChanged;
        }

        private void OnSessionFriendsListChanged()
        {
            _ = LoadFriendsListAsync();
        }

        private void OnServerFriendStatusChanged(int friendUserId, bool isOnline)
        {
            FriendItemViewModel statusSnapshot = new FriendItemViewModel(friendUserId, string.Empty, isOnline);

            if (_uiSyncContext != null && SynchronizationContext.Current != _uiSyncContext)
            {
                _uiSyncContext.Post(ApplyFriendStatusUpdateCallback, statusSnapshot);
            }
            else
            {
                ApplyFriendStatusUpdate(statusSnapshot.UserId, statusSnapshot.IsOnline);
            }
        }

        private void ApplyFriendStatusUpdateCallback(object stateObject)
        {
            if (stateObject is FriendItemViewModel statusSnapshot)
            {
                ApplyFriendStatusUpdate(statusSnapshot.UserId, statusSnapshot.IsOnline);
            }
        }

        private void ApplyFriendStatusUpdate(int friendUserId, bool isOnline)
        {
            FriendItemViewModel matchingFriend = FindFriendById(friendUserId);

            if (matchingFriend != null)
            {
                matchingFriend.IsOnline = isOnline;
                if (_isFilteringOnlineOnly)
                {
                    ApplyFriendsFilter();
                }
            }
            else
            {
                _ = LoadFriendsListAsync();
            }
        }

        private void OnServerFriendRemoved(int friendUserId)
        {
            if (_uiSyncContext != null && SynchronizationContext.Current != _uiSyncContext)
            {
                _uiSyncContext.Post(RemoveFriendFromListCallback, friendUserId);
            }
            else
            {
                RemoveFriendFromList(friendUserId);
            }
        }

        private void RemoveFriendFromListCallback(object stateObject)
        {
            if (stateObject is int friendUserId)
            {
                RemoveFriendFromList(friendUserId);
            }
        }

        private void RemoveFriendFromList(int friendUserId)
        {
            FriendItemViewModel matchingFriend = FindFriendById(friendUserId);

            if (matchingFriend != null)
            {
                _allFriends.Remove(matchingFriend);
                Friends.Remove(matchingFriend);
            }
        }

        private void OnServerGameInvitationReceived(GameInvitation gameInvitation)
        {
            if (gameInvitation != null)
            {
                GameInvitationItemViewModel invitationItem = new GameInvitationItemViewModel(
                    gameInvitation.SenderUserId,
                    gameInvitation.SenderUsername,
                    gameInvitation.LobbyCode,
                    gameInvitation.TargetMissionCount,
                    gameInvitation.CurrentPlayerCount,
                    gameInvitation.PlayerLimit);

                if (_uiSyncContext != null && SynchronizationContext.Current != _uiSyncContext)
                {
                    _uiSyncContext.Post(AddGameInvitationCallback, invitationItem);
                }
                else
                {
                    AddOrReplaceGameInvitation(invitationItem);
                }
            }
        }

        private void AddGameInvitationCallback(object stateObject)
        {
            if (stateObject is GameInvitationItemViewModel invitationItem)
            {
                AddOrReplaceGameInvitation(invitationItem);
            }
        }

        private void AddOrReplaceGameInvitation(GameInvitationItemViewModel newInvitation)
        {
            GameInvitationItemViewModel existing = null;

            foreach (GameInvitationItemViewModel item in GameInvitations)
            {
                if (item.SenderUserId == newInvitation.SenderUserId &&
                    string.Equals(item.LobbyCode, newInvitation.LobbyCode, StringComparison.OrdinalIgnoreCase))
                {
                    existing = item;
                }
            }

            if (existing != null)
            {
                GameInvitations.Remove(existing);
            }

            GameInvitations.Add(newInvitation);
        }

        private FriendItemViewModel FindFriendById(int friendUserId)
        {
            FriendItemViewModel found = null;

            foreach (FriendItemViewModel item in _allFriends)
            {
                if (item.UserId == friendUserId)
                {
                    found = item;
                }
            }

            return found;
        }

        private async Task ExecuteOpenManageFriendRequestsAsync()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.ManageFriendRequestDialog);
                await LoadFriendsListAsync();
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Log this exception to a proper logging framework instead of writing to the console.
                Console.WriteLine($"[FriendsViewModel] Error opening friend requests dialog: {ex.Message}");
            }
        }

        private void ExecuteAddFriend()
        {
            _navigationService.NavigateTo(ViewId.SendFriendRequest);
        }

        private void ExecuteViewProfile()
        {
            _navigationService.NavigateTo(ViewId.Profile);
        }

        private async Task ExecuteDeleteFriendAsync(object parameter)
        {
            FriendItemViewModel targetFriend = parameter as FriendItemViewModel;
            int currentUserId = GetAuthenticatedUserId();

            if (targetFriend != null && IsValidUserId(currentUserId))
            {
                OperationResult result = await _friendshipSession.Client.RemoveFriendAsync(currentUserId,
                    targetFriend.UserId);

                if (result == null)
                {
                    _dialogService?.ShowError(MessageCode.ConnectionFailed);
                }
                else if (result.IsSuccess)
                {
                    _allFriends.Remove(targetFriend);
                    Friends.Remove(targetFriend);
                }
                else
                {
                    _dialogService?.ShowWarning(MessageCode.UnexpectedError);
                }
            }
        }

        private async Task ExecuteInviteFriendAsync(object parameter)
        {
            FriendItemViewModel targetFriend = parameter as FriendItemViewModel;
            int currentUserId = GetAuthenticatedUserId();
            Model.GameServices.Lobby activeLobby = _lobbySession.CurrentLobby;
            bool canSendInvitation = targetFriend != null && IsValidUserId(currentUserId) 
                && _lobbySession.HasActiveLobby && activeLobby != null;

            if (canSendInvitation)
            {
                string senderUsername;
                int currentPlayerCount = activeLobby.Players != null 
                    ? activeLobby.Players.Length 
                    : 1;

                if (UserSession.Current.CurrentUser != null)
                {
                    senderUsername = UserSession.Current.CurrentUser.Username;
                }
                else
                {
                    senderUsername = string.Empty;
                }

                GameInvitation invitation = new GameInvitation
                {
                    SenderUserId = currentUserId,
                    SenderUsername = senderUsername,
                    ReceiverUserId = targetFriend.UserId,
                    LobbyCode = activeLobby.LobbyCode,
                    TargetMissionCount = activeLobby.TargetMissionCount,
                    CurrentPlayerCount = currentPlayerCount,
                    PlayerLimit = activeLobby.PlayerLimit
                };

                await _friendshipSession.Client.SendGameInvitationAsync(invitation);
            }
        }

        private async Task ExecuteAcceptGameInvitationAsync(object parameter)
        {
            GameInvitationItemViewModel invitationItem = parameter as GameInvitationItemViewModel;
            int currentUserId = UserSession.Current.EnsureActiveUserId();

            if (invitationItem != null && !string.IsNullOrWhiteSpace(invitationItem.LobbyCode))
            {
                _lobbySession.ClearLobby();
                Model.GameServices.LobbyResult result = await _lobbySession.Client.JoinLobbyByCodeAsync(
                    invitationItem.LobbyCode.Trim().ToUpperInvariant(), currentUserId);

                if (result == null)
                {
                    _dialogService?.ShowError(MessageCode.ConnectionFailed);
                }
                else if (!result.IsSuccess || result.Lobby == null)
                {
                    int messageCode = result.ErrorCode == ServerErrorCodeLobbyFull
                        ? MessageCode.EnterGameCodeLobbyAlreadyFull
                        : MessageCode.EnterGameCodeInvalidCode;
                    _dialogService?.ShowWarning(messageCode);
                    GameInvitations.Remove(invitationItem);
                }
                else
                {
                    _lobbySession.SetLobby(result.Lobby);
                    GameInvitations.Remove(invitationItem);
                    _navigationService.NavigateTo(ViewId.Lobby);
                }
            }
        }

        private void ExecuteRejectGameInvitation(object parameter)
        {
            if (parameter is GameInvitationItemViewModel invitationItem)
            {
                GameInvitations.Remove(invitationItem);
            }
        }

        private async Task ExecuteFilterFriendsAsync()
        {
            _isFilteringOnlineOnly = !_isFilteringOnlineOnly;
            await LoadFriendsListAsync();
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

        private bool IsValidUserId(int userId)
        {
            return userId > 0;
        }
    }
}
