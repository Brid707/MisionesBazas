using System;
using System.Threading;
using System.Threading.Tasks;
using Model.Services;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Observes one player image and releases its shared cache subscription when detached.
    /// </summary>
    public sealed class ProfileImageViewModel : ViewModelBase, IDisposable
    {
        private readonly IProfileImageCache _profileImageCache;
        private readonly int _profileOwnerUserId;
        private readonly SynchronizationContext _uiContext;
        private byte[] _profileImageBytes;
        private bool _isDisposed;

        public ProfileImageViewModel(int profileOwnerUserId, IProfileImageCache profileImageCache)
        {
            _profileOwnerUserId = profileOwnerUserId;
            _profileImageCache = profileImageCache;
            _uiContext = SynchronizationContext.Current;
            _profileImageCache.RegisterPlayer(profileOwnerUserId);
            _profileImageCache.ProfileImageChanged += OnImageChanged;
            _ = LoadImageAsync();
        }

        public byte[] ProfileImageBytes
        {
            get => _profileImageBytes;
            private set => SetProperty(ref _profileImageBytes, value);
        }

        private void OnImageChanged(int profileOwnerUserId)
        {
            if (profileOwnerUserId == _profileOwnerUserId && !_isDisposed)
            {
                _ = LoadImageAsync();
            }
        }

        private async Task LoadImageAsync()
        {
            try
            {
                byte[] imageBytes = await _profileImageCache.LoadProfileImageAsync(_profileOwnerUserId);
                ApplyImageOnUiThread(imageBytes);
            }
            catch (ProfileImageOperationException)
            {
                ApplyImageOnUiThread(null);
            }
        }

        private void ApplyImageOnUiThread(byte[] imageBytes)
        {
            if (!_isDisposed)
            {
                if (_uiContext == null)
                {
                    ProfileImageBytes = imageBytes;
                }
                else
                {
                    _uiContext.Post(_ => ApplyImageIfActive(imageBytes), null);
                }
            }
        }

        private void ApplyImageIfActive(byte[] imageBytes)
        {
            if (!_isDisposed)
            {
                ProfileImageBytes = imageBytes;
            }
        }

        public void Dispose()
        {
            if (!_isDisposed)
            {
                _isDisposed = true;
                _profileImageCache.ProfileImageChanged -= OnImageChanged;
                _profileImageCache.UnregisterPlayer(_profileOwnerUserId);
            }
        }
    }
}
