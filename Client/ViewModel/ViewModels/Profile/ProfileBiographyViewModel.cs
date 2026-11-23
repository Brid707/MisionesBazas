using System.Threading.Tasks;
using System.Windows.Input;
using Model.Services;
using PlayerProfiles;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>Owns profile load/edit state while retaining drafts after database or network failures.</summary>
    public sealed class ProfileBiographyViewModel : ViewModelBase
    {
        private const string ProfileFeedbackPrefix = "Profile_";
        private readonly IPlayerProfileClient _profileClient;
        private readonly string _accountSessionToken;
        private bool _isBusy;
        private bool _hasLoadedProfile;
        private bool _isBiographyEditing;
        private bool _hasUnconfirmedSave;
        private string _biography = string.Empty;
        private string _biographyDraft = string.Empty;
        private string _feedbackResourceKey;
        private PlayerProfileDetails _profileDetails;

        public ProfileBiographyViewModel(IPlayerProfileClient profileClient, string accountSessionToken)
        {
            _profileClient = profileClient;
            _accountSessionToken = accountSessionToken;
            _feedbackResourceKey = IsRegisteredAccount ? "Profile_NotLoaded" : "Profile_GuestReadOnly";
            ReloadProfileCommand = new AsyncRelayCommand(LoadOwnProfileAsync, CanReloadProfile);
            EditBiographyCommand = new RelayCommand(BeginBiographyEditing, CanBeginBiographyEditing);
            CancelBiographyCommand = new RelayCommand(CancelBiographyEditing, CanCancelBiographyEditing);
            SaveBiographyCommand = new AsyncRelayCommand(SaveBiographyAsync, CanSaveBiography);
        }

        public ICommand ReloadProfileCommand { get; }

        public ICommand EditBiographyCommand { get; }

        public ICommand CancelBiographyCommand { get; }

        public ICommand SaveBiographyCommand { get; }

        public bool IsRegisteredAccount => !string.IsNullOrWhiteSpace(_accountSessionToken);

        public int MaximumBiographyLength => PlayerBiographyRules.MaximumBiographyLength;

        public PlayerProfileDetails ProfileDetails
        {
            get => _profileDetails;
            private set => SetProperty(ref _profileDetails, value);
        }

        public string Biography
        {
            get => _biography;
            private set => SetProperty(ref _biography, value);
        }

        public string BiographyDraft
        {
            get => _biographyDraft;
            set
            {
                SetProperty(ref _biographyDraft, value);
                CommandManager.InvalidateRequerySuggested();
            }
        }

        public bool IsBiographyEditing
        {
            get => _isBiographyEditing;
            private set => SetProperty(ref _isBiographyEditing, value);
        }

        public bool HasLoadedProfile
        {
            get => _hasLoadedProfile;
            private set => SetProperty(ref _hasLoadedProfile, value);
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

        public string FeedbackResourceKey
        {
            get => _feedbackResourceKey;
            private set => SetProperty(ref _feedbackResourceKey, value);
        }

        public async Task LoadOwnProfileAsync()
        {
            if (CanReloadProfile())
            {
                IsBusy = true;
                FeedbackResourceKey = "Profile_Loading";
                try
                {
                    PlayerProfileClientResult profileResult = await _profileClient.GetOwnProfileAsync(
                        _accountSessionToken);
                    ApplyProfileRead(profileResult);
                }
                finally
                {
                    IsBusy = false;
                }
            }
        }

        private void ApplyProfileRead(PlayerProfileClientResult profileResult)
        {
            if (profileResult.IsSuccessful && profileResult.Profile != null)
            {
                ProfileDetails = profileResult.Profile;
                Biography = ProfileDetails.Biography ?? string.Empty;
                HasLoadedProfile = true;
                FeedbackResourceKey = "Profile_StatisticsPending";
                ResolveUnconfirmedSave();
            }
            else
            {
                FeedbackResourceKey = ProfileFeedbackPrefix + profileResult.FailureReason;
            }
        }

        private void ResolveUnconfirmedSave()
        {
            if (_hasUnconfirmedSave)
            {
                _hasUnconfirmedSave = false;
                if (Biography == BiographyDraft)
                {
                    IsBiographyEditing = false;
                    FeedbackResourceKey = "Profile_SaveSucceeded";
                }
                else
                {
                    FeedbackResourceKey = "Profile_DraftPreserved";
                }
            }
        }

        private bool CanReloadProfile()
        {
            return IsRegisteredAccount && !IsBusy;
        }

        private bool CanBeginBiographyEditing()
        {
            return IsRegisteredAccount && HasLoadedProfile && !IsBusy && !IsBiographyEditing;
        }

        private bool CanCancelBiographyEditing()
        {
            return IsBiographyEditing && !IsBusy && !_hasUnconfirmedSave;
        }

        private bool CanSaveBiography()
        {
            return IsRegisteredAccount && IsBiographyEditing && !IsBusy && !_hasUnconfirmedSave &&
                PlayerBiographyRules.IsBiographyValid(BiographyDraft) && BiographyDraft != Biography;
        }

        private void BeginBiographyEditing()
        {
            if (CanBeginBiographyEditing())
            {
                BiographyDraft = Biography;
                IsBiographyEditing = true;
                CommandManager.InvalidateRequerySuggested();
            }
        }

        private void CancelBiographyEditing()
        {
            if (CanCancelBiographyEditing())
            {
                BiographyDraft = Biography;
                IsBiographyEditing = false;
                FeedbackResourceKey = _hasUnconfirmedSave ? "Profile_SaveUnconfirmed" : "Profile_StatisticsPending";
                CommandManager.InvalidateRequerySuggested();
            }
        }

        private async Task SaveBiographyAsync()
        {
            if (CanSaveBiography())
            {
                IsBusy = true;
                FeedbackResourceKey = "Profile_Saving";
                try
                {
                    PlayerProfileClientResult saveResult = await _profileClient.UpdateOwnBiographyAsync(
                        new ProfileBiographyUpdate
                        {
                            AccountSessionToken = _accountSessionToken,
                            Biography = BiographyDraft
                        });
                    ApplyBiographySave(saveResult);
                }
                finally
                {
                    IsBusy = false;
                }
            }
        }

        private void ApplyBiographySave(PlayerProfileClientResult saveResult)
        {
            if (saveResult.IsSuccessful)
            {
                Biography = saveResult.SavedBiography;
                IsBiographyEditing = false;
                FeedbackResourceKey = "Profile_SaveSucceeded";
            }
            else
            {
                _hasUnconfirmedSave = saveResult.IsSaveUnconfirmed;
                FeedbackResourceKey = _hasUnconfirmedSave ? "Profile_SaveUnconfirmed" :
                    ProfileFeedbackPrefix + saveResult.FailureReason;
            }
        }
    }
}
