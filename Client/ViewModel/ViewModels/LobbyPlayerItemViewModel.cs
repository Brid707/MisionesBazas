using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model representing a single participant slot inside the game lobby view.
    /// </summary>
    public sealed class LobbyPlayerItemViewModel : ViewModelBase
    {
        private bool _isReady;

        public LobbyPlayerItemViewModel(
            int idUser,
            string username,
            bool isHost)
        {
            IdUser = idUser;
            Username = username ?? string.Empty;
            IsHost = isHost;
        }

        public int IdUser { get; }

        public string Username { get; }

        public bool IsHost { get; }

        public bool IsCurrentPlayer { get; set; }

        public bool IsOtherPlayer => !IsCurrentPlayer;

        public bool IsReady
        {
            get => _isReady;
            set => SetProperty(ref _isReady, value);
        }
    }
}
