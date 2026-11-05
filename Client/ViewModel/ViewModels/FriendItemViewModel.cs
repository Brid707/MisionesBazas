using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model representing a single friend card inside the social sidebar.
    /// </summary>
    public sealed class FriendItemViewModel : ViewModelBase
    {
        private bool _isOnline;

        public FriendItemViewModel(int userId, string username, bool isOnline)
        {
            UserId = userId;
            Username = username ?? string.Empty;
            _isOnline = isOnline;
        }

        public int UserId { get; }

        public string Username { get; }

        public bool IsOnline
        {
            get => _isOnline;
            set => SetProperty(ref _isOnline, value);
        }
    }
}
