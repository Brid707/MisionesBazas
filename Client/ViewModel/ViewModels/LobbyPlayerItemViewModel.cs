using System;
using System.Windows.Input;
using Model.Services;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model representing a single participant slot inside the game lobby view.
    /// </summary>
    public sealed class LobbyPlayerItemViewModel : ViewModelBase, IDisposable
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

        public ProfileImageViewModel ProfileImage { get; private set; }

        public int IdUser { get; }

        public string Username { get; }

        public bool IsHost { get; }

        public bool IsCurrentPlayer { get; set; }

        /// <summary>
        /// Indicates whether this row offers host participant actions.
        /// </summary>
        public bool CanBeKickedByCurrentHost { get; set; }

        /// <summary>
        /// Requests removal of this participant after checking the current host permission.
        /// </summary>
        public ICommand KickPlayerCommand { get; set; }

        public bool IsOtherPlayer => !IsCurrentPlayer;

        public bool IsReady
        {
            get => _isReady;
            set => SetProperty(ref _isReady, value);
        }
        public void AttachProfileImage(IProfileImageCache profileImageCache)
        {
            ProfileImage?.Dispose();
            ProfileImage = new ProfileImageViewModel(IdUser, profileImageCache);
            OnPropertyChanged(nameof(ProfileImage));
        }

        public void Dispose()
        {
            ProfileImage?.Dispose();
        }

    }
}
