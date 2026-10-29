using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing social interactions, friend lists, and friend invitations.
    /// </summary>
    public sealed class FriendsViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;
        private bool _isInLobby;

        /// <summary>
        /// Initializes a new instance of the <see cref="FriendsViewModel"/> class.
        /// </summary>
        /// <param name="navigationService">Service for navigating between views and modal dialogs.</param>
        public FriendsViewModel(INavigationService navigationService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _isInLobby = false;

            OpenManageFriendRequestsCommand = new RelayCommand(ExecuteOpenManageFriendRequests);
            AddFriendCommand = new RelayCommand(ExecuteAddFriend);
            ViewProfileCommand = new RelayCommand(ExecuteViewProfile);
            DeleteFriendCommand = new RelayCommand(ExecuteDeleteFriend);
            InviteFriendCommand = new RelayCommand(ExecuteInviteFriend);
            FilterFriendsCommand = new RelayCommand(ExecuteFilterFriends);
        }

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
        /// Gets the command that filters or refreshes the friends list.
        /// </summary>
        public ICommand FilterFriendsCommand { get; }

        private void ExecuteOpenManageFriendRequests()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.ManageFriendRequestDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Console.WriteLine with project logger once logging infrastructure is available.
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

        private void ExecuteDeleteFriend()
        {
            // TODO: Delete friend logic via backend service once connected.
        }

        private void ExecuteInviteFriend()
        {
            // TODO: Dispatch match invitation via backend service once connected.
        }

        private void ExecuteFilterFriends()
        {
            // TODO: Filter or toggle online/offline friends list once connected.
        }
    }
}
