using System;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.Services;
using Model.PlayerProfileService;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>Loads public profile data and photos without exposing email or editing controls.</summary>
    public sealed class PlayerProfileViewModel : ViewModelBase, IDisposable
    {
        private const string FeedbackKeyPrefix = "Profile_";
        private readonly IPlayerProfileClient _profileClient;
        private readonly IProfileImageCache _profileImageCache;
        private readonly PublicPlayerProfileLookup _profileLookup;
        private bool _isBusy;
        private bool _isDisposed;
        private PublicPlayerProfileDetails _profileDetails;
        private ProfileImageViewModel _profileImage;
        private string _feedbackResourceKey = "Profile_NotLoaded";

        public PlayerProfileViewModel(IPlayerProfileClient profileClient, IProfileImageCache profileImageCache,
            PublicPlayerProfileLookup profileLookup)
        {
            _profileClient = profileClient;
            _profileImageCache = profileImageCache;
            _profileLookup = profileLookup;
            ReloadProfileCommand = new AsyncRelayCommand(LoadPublicProfileAsync, CanReloadProfile);
            CloseCommand = new RelayCommand(RequestClose);
        }

        public event EventHandler CloseRequested;

        public ICommand ReloadProfileCommand { get; }

        public ICommand CloseCommand { get; }

        public PublicPlayerProfileDetails ProfileDetails
        {
            get => _profileDetails;
            private set => SetProperty(ref _profileDetails, value);
        }

        public ProfileImageViewModel ProfileImage
        {
            get => _profileImage;
            private set => SetProperty(ref _profileImage, value);
        }

        public string FeedbackResourceKey
        {
            get => _feedbackResourceKey;
            private set => SetProperty(ref _feedbackResourceKey, value);
        }

        public bool IsBusy
        {
            get => _isBusy;
            private set
            {
                SetProperty(ref _isBusy, value);
                CommandManager.InvalidateRequerySuggested();
            }
        }

        private bool CanReloadProfile()
        {
            return !IsBusy && !_isDisposed && _profileLookup.ProfileOwnerUserId >= 0;
        }

        public async Task LoadPublicProfileAsync()
        {
            if (_profileLookup.ProfileOwnerUserId < 0)
            {
                FeedbackResourceKey = "Profile_GuestHasNoPublicProfile";
            }
            else if (CanReloadProfile())
            {
                IsBusy = true;
                FeedbackResourceKey = "Profile_Loading";
                try
                {
                    PlayerProfileClientResult profileResult =
                        await _profileClient.GetPublicProfileAsync(_profileLookup);
                    ApplyPublicProfile(profileResult);
                }
                finally
                {
                    IsBusy = false;
                }
            }
        }

        private void ApplyPublicProfile(PlayerProfileClientResult profileResult)
        {
            if (!_isDisposed)
            {
                if (profileResult.IsSuccessful && profileResult.PublicProfile != null)
                {
                    ProfileDetails = profileResult.PublicProfile;
                    ProfileImage?.Dispose();
                    ProfileImage = new ProfileImageViewModel(ProfileDetails.ProfileOwnerUserId, _profileImageCache);
                    FeedbackResourceKey = "Profile_PublicReadOnly";
                }
                else
                {
                    FeedbackResourceKey = FeedbackKeyPrefix + profileResult.FailureReason;
                }
            }
        }

        private void RequestClose()
        {
            CloseRequested?.Invoke(this, EventArgs.Empty);
        }

        public void Dispose()
        {
            _isDisposed = true;
            ProfileImage?.Dispose();
        }
    }
}
