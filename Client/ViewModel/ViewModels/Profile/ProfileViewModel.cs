using System;
using System.ComponentModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.Services;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Models;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for displaying and updating user profile statistics and details.
    /// </summary>
    public sealed class ProfileViewModel : ViewModelBase
    {
        private const string LogProfileImageOperationFailed =
            "Profile image update failed with FailureCode={FailureCode} (Feedback={FeedbackCode}).";

        private readonly INavigationService _navigationService;
        private readonly ILoggerService _logger;
        private readonly IProfileImagePicker _profileImagePicker;
        private readonly IProfileImageCache _profileImageCache;
        private bool _isProfileImageUploading;
        private ProfileImageFeedback _profileImageFeedbackCode;
        private ProfileImageViewModel _profileImage;

        private string _username;
        private string _email;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProfileViewModel"/> class.
        /// </summary>
        /// <param name="navigationLogging">Grouped navigation and logging services.</param>
        /// <param name="profileImagePicker">Selects the local file through a presentation adapter.</param>
        /// <param name="profileInteractions">Provides profile image and account data adapters.</param>
        public ProfileViewModel(ViewModelNavigationLogging navigationLogging, IProfileImagePicker profileImagePicker,
            ProfileInteractionDependencies profileInteractions)
        {
            if (navigationLogging == null)
            {
                throw new ArgumentNullException(nameof(navigationLogging));
            }

            _navigationService = navigationLogging.NavigationService;
            _logger = navigationLogging.Logger;

            _profileImagePicker = profileImagePicker ?? throw new ArgumentNullException(nameof(profileImagePicker));
            _profileImageCache = profileInteractions.ProfileImages;
            BiographyEditor = new ProfileBiographyViewModel(profileInteractions.PlayerProfileClient,
                UserSession.Current.CurrentUser?.AccountSessionToken);
            BiographyEditor.PropertyChanged += OnBiographyEditorPropertyChanged;
            ChangeProfilePhotoCommand = new AsyncRelayCommand(ChangeProfilePhotoAsync, CanChangeProfilePhoto);
            LoadCurrentProfile();

            CloseCommand = new RelayCommand(ExecuteClose);
        }

        /// <summary>
        /// Gets or sets the display username of the profile.
        /// </summary>
        public string Username
        {
            get => _username;
            set => SetProperty(ref _username, value);
        }

        /// <summary>
        /// Gets or sets the user's registered email address.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets the command that navigates back from the profile view.
        /// </summary>
        public ICommand CloseCommand { get; }

        public ProfileBiographyViewModel BiographyEditor { get; }

        public ICommand ChangeProfilePhotoCommand { get; }

        public ProfileImageViewModel ProfileImage
        {
            get => _profileImage;
            private set => SetProperty(ref _profileImage, value);
        }

        public bool IsProfileImageUploading
        {
            get => _isProfileImageUploading;
            private set
            {
                SetProperty(ref _isProfileImageUploading, value);
                CommandManager.InvalidateRequerySuggested();
            }
        }

        public ProfileImageFeedback ProfileImageFeedbackCode
        {
            get => _profileImageFeedbackCode;
            private set => SetProperty(ref _profileImageFeedbackCode, value);
        }

        public void ActivateProfileImage()
        {
            if (ProfileImage == null)
            {
                ProfileImage = new ProfileImageViewModel(UserSession.Current.CurrentUser?.IdUser ?? 0,
                    _profileImageCache);
            }
        }

        public void DeactivateProfileImage()
        {
            ProfileImage?.Dispose();
            ProfileImage = null;
        }

        private bool CanChangeProfilePhoto()
        {
            return !IsProfileImageUploading && UserSession.Current.CurrentUser?.IdUser > 0 &&
                !string.IsNullOrEmpty(UserSession.Current.CurrentUser.AccountSessionToken);
        }

        private async Task ChangeProfilePhotoAsync()
        {
            IsProfileImageUploading = true;
            ProfileImageFeedbackCode = ProfileImageFeedback.None;
            try
            {
                ProfileImageSelection profileImageSelection = await _profileImagePicker.PickProfileImageAsync();
                ProfileImageFeedbackCode = profileImageSelection.SelectionFeedback;
                if (profileImageSelection.SelectedProfileImageBytes != null &&
                    profileImageSelection.SelectionFeedback == ProfileImageFeedback.None)
                {
                    ProfileImageFeedbackCode = ProfileImageFeedback.Uploading;
                    await _profileImageCache.ChangeOwnProfileImageAsync(
                        profileImageSelection.SelectedProfileImageBytes);
                    ProfileImageFeedbackCode = ProfileImageFeedback.UploadSucceeded;
                }
            }
            catch (ProfileImageOperationException ex)
            {
                ProfileImageFeedback feedbackCode = ParseProfileImageFailureCode(ex.FailureCode);
                _logger.Warning(LogProfileImageOperationFailed, ex.FailureCode, feedbackCode);
                ProfileImageFeedbackCode = feedbackCode;
            }
            finally
            {
                IsProfileImageUploading = false;
            }
        }

        private static ProfileImageFeedback ParseProfileImageFailureCode(string failureCode)
        {
            ProfileImageFeedback profileImageFeedback;
            bool isKnownFailureCode = Enum.TryParse(failureCode, out profileImageFeedback);
            return isKnownFailureCode ? profileImageFeedback : ProfileImageFeedback.OperationFailed;
        }

        private void LoadCurrentProfile()
        {
            UserSessionData currentUser = UserSession.Current.CurrentUser;
            if (currentUser != null)
            {
                Username = currentUser.Username;
                Email = currentUser.Email;
            }
            else
            {
                Username = string.Empty;
                Email = string.Empty;
            }

        }

        private void OnBiographyEditorPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == nameof(ProfileBiographyViewModel.ProfileDetails) &&
                BiographyEditor.ProfileDetails != null)
            {
                Username = BiographyEditor.ProfileDetails.Username;
                Email = BiographyEditor.ProfileDetails.Email;
            }
        }

        private void ExecuteClose()
        {
            _navigationService.GoBack();
        }
    }
}
