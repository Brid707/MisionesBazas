using System;
using Model.GameServices;
using Model.Services;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presents a confirmed chat message and observes its sender's shared profile image.
    /// </summary>
    public sealed class LobbyChatMessageViewModel : ViewModelBase, IDisposable
    {
        private readonly LobbyMessage _publishedChatMessage;

        public LobbyChatMessageViewModel(LobbyMessage publishedChatMessage)
        {
            _publishedChatMessage = publishedChatMessage ??
                throw new ArgumentNullException(nameof(publishedChatMessage));
        }

        public string SenderUsername => _publishedChatMessage.SenderUsername;

        public string Message => _publishedChatMessage.Message;

        public ProfileImageViewModel ProfileImage { get; private set; }

        public void AttachProfileImage(IProfileImageCache profileImageCache)
        {
            ProfileImage?.Dispose();
            ProfileImage = new ProfileImageViewModel(_publishedChatMessage.SenderUserId, profileImageCache);
            OnPropertyChanged(nameof(ProfileImage));
        }

        public void Dispose()
        {
            ProfileImage?.Dispose();
        }
    }
}
