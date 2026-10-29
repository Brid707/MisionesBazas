using System;
using System.Windows.Input;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing incoming friend requests, handling approvals and rejections.
    /// </summary>
    public sealed class ManageFriendRequestViewModel : ViewModelBase
    {
        private bool _hasPendingRequests;

        /// <summary>
        /// Occurs when the dialog window requests to close.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestViewModel"/> class.
        /// </summary>
        public ManageFriendRequestViewModel()
        {
            _hasPendingRequests = true;

            CloseCommand = new RelayCommand(ExecuteClose);
            AcceptRequestCommand = new RelayCommand(ExecuteAcceptRequest);
            RejectRequestCommand = new RelayCommand(ExecuteRejectRequest);
            LoadRequestsCommand = new RelayCommand(ExecuteLoadRequests);
        }

        /// <summary>
        /// Gets or sets a value indicating whether there are pending friend requests to display.
        /// </summary>
        public bool HasPendingRequests
        {
            get => _hasPendingRequests;
            set => SetProperty(ref _hasPendingRequests, value);
        }

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

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }

        private void ExecuteAcceptRequest()
        {
            // TODO: Accept friend request via backend service once connected.
        }

        private void ExecuteRejectRequest()
        {
            // TODO: Reject friend request via backend service once connected.
        }

        private void ExecuteLoadRequests()
        {
            // TODO: Load pending friend requests from backend service once connected.
        }
    }
}
