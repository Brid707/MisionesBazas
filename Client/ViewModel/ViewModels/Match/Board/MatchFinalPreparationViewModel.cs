using System;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.GameServices;
using Model.Services;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchFinalPreparationViewModel : ViewModelBase
    {
        private const int MissionFortySixNumber = 46;
        private static readonly int s_requiredHeartCardCount =
            DeckRules.CreateStandardDeck().Count(card => card.Suit == CardSuit.Heart);

        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly Func<PlayerMatchSnapshot> _snapshotProvider;
        private readonly Func<long> _matchStateVersionProvider;
        private readonly Func<bool> _canSubmitMatchRequestProvider;
        private readonly Func<MissionPreparationStage> _stageProvider;
        private readonly Func<bool> _isMissionPreparationCompleteProvider;
        private readonly ObservableCollection<LobbyPlayerItemViewModel> _eligibleRoleParticipants;
        private readonly Func<int, string> _participantNameResolver;
        private readonly Func<Task> _synchronizeMatchAction;

        private LobbyPlayerItemViewModel _selectedFirstFourTrickWinner;
        private LobbyPlayerItemViewModel _selectedLastTrickWinner;
        private HeartNineIdentificationSubmission _pendingHeartIdentification;
        private MissionTrickDistributionSubmission _pendingTrickDistribution;

        public MatchFinalPreparationViewModel(
            string lobbyCode,
            int participantUserId,
            IMatchClient matchClient,
            Func<PlayerMatchSnapshot> snapshotProvider,
            Func<long> matchStateVersionProvider,
            Func<bool> canSubmitMatchRequestProvider,
            Func<MissionPreparationStage> stageProvider,
            Func<bool> isMissionPreparationCompleteProvider,
            ObservableCollection<LobbyPlayerItemViewModel> eligibleRoleParticipants,
            Func<int, string> participantNameResolver,
            Func<Task> synchronizeMatchAction)
        {
            _lobbyCode = lobbyCode;
            _participantUserId = participantUserId;
            _matchClient = matchClient ?? throw new ArgumentNullException(nameof(matchClient));
            _snapshotProvider = snapshotProvider ?? throw new ArgumentNullException(nameof(snapshotProvider));
            _matchStateVersionProvider = matchStateVersionProvider ?? throw new ArgumentNullException(nameof(matchStateVersionProvider));
            _canSubmitMatchRequestProvider = canSubmitMatchRequestProvider ?? throw new ArgumentNullException(nameof(canSubmitMatchRequestProvider));
            _stageProvider = stageProvider ?? throw new ArgumentNullException(nameof(stageProvider));
            _isMissionPreparationCompleteProvider = isMissionPreparationCompleteProvider ?? throw new ArgumentNullException(nameof(isMissionPreparationCompleteProvider));
            _eligibleRoleParticipants = eligibleRoleParticipants ?? throw new ArgumentNullException(nameof(eligibleRoleParticipants));
            _participantNameResolver = participantNameResolver ?? throw new ArgumentNullException(nameof(participantNameResolver));
            _synchronizeMatchAction = synchronizeMatchAction ?? throw new ArgumentNullException(nameof(synchronizeMatchAction));

            ConfirmedMissionRoles = new ObservableCollection<PublicMissionRoleViewModel>();
            IdentifyHeartNineOwnerCommand = new AsyncRelayCommand(IdentifyHeartNineOwnerAsync, () => CanIdentifyHeartNineOwnership);
            AssignTrickDistributionCommand = new AsyncRelayCommand(AssignTrickDistributionAsync, CanAssignDistribution);
        }

        public ObservableCollection<PublicMissionRoleViewModel> ConfirmedMissionRoles { get; }
        public ICommand IdentifyHeartNineOwnerCommand { get; }
        public ICommand AssignTrickDistributionCommand { get; }

        public bool HasPendingFinalPreparation =>
            _pendingHeartIdentification != null || _pendingTrickDistribution != null;

        public bool IsTrickDistributionSelection =>
            _stageProvider() == MissionPreparationStage.TrickDistributionSelection;

        public bool IsHeartNineIdentificationStage =>
            _stageProvider() == MissionPreparationStage.HeartNineIdentification;

        public bool IsHeartCaptureProgressVisible =>
            _snapshotProvider()?.MissionPreparation?.MissionNumber == MissionFortySixNumber &&
            _isMissionPreparationCompleteProvider();

        public string HeartCaptureProgressDisplay => string.Format(CultureInfo.InvariantCulture,
            "{0}/{1}", _snapshotProvider()?.MissionConditionProgress?.CapturedHeartCardCount ?? 0,
            s_requiredHeartCardCount);

        public bool CanIdentifyHeartNineOwnership =>
            _canSubmitMatchRequestProvider() &&
            (_snapshotProvider()?.MissionPreparation?.CanIdentifyHeartNineOwnership ?? false);

        public LobbyPlayerItemViewModel SelectedFirstFourTrickWinner
        {
            get => _selectedFirstFourTrickWinner;
            set => SetProperty(ref _selectedFirstFourTrickWinner, value);
        }

        public LobbyPlayerItemViewModel SelectedLastTrickWinner
        {
            get => _selectedLastTrickWinner;
            set => SetProperty(ref _selectedLastTrickWinner, value);
        }

        public bool CanAssignDistribution()
        {
            return _canSubmitMatchRequestProvider() && IsTrickDistributionSelection &&
                SelectedFirstFourTrickWinner != null && SelectedLastTrickWinner != null &&
                SelectedFirstFourTrickWinner != SelectedLastTrickWinner &&
                _eligibleRoleParticipants.Contains(SelectedFirstFourTrickWinner) &&
                _eligibleRoleParticipants.Contains(SelectedLastTrickWinner);
        }

        private async Task IdentifyHeartNineOwnerAsync()
        {
            if (CanIdentifyHeartNineOwnership)
            {
                PlayerMatchSnapshot snapshot = _snapshotProvider();
                _pendingHeartIdentification = new HeartNineIdentificationSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = snapshot.MatchId,
                    MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = snapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = _matchStateVersionProvider()
                };
                await _synchronizeMatchAction();
            }
        }

        private async Task AssignTrickDistributionAsync()
        {
            if (CanAssignDistribution())
            {
                PlayerMatchSnapshot snapshot = _snapshotProvider();
                _pendingTrickDistribution = new MissionTrickDistributionSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = snapshot.MatchId,
                    MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = snapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = _matchStateVersionProvider(),
                    FirstFourTricksWinnerParticipantUserId = SelectedFirstFourTrickWinner.IdUser,
                    LastTrickWinnerParticipantUserId = SelectedLastTrickWinner.IdUser
                };
                await _synchronizeMatchAction();
            }
        }

        public Guid GetPendingPreparationIdentity()
        {
            return _pendingHeartIdentification?.MissionPreparationSubmissionId ??
                _pendingTrickDistribution.MissionPreparationSubmissionId;
        }

        public async Task<MissionPreparationConfirmation> SubmitPendingFinalPreparationAsync()
        {
            MissionPreparationConfirmation confirmation;
            if (_pendingHeartIdentification != null)
            {
                confirmation = await _matchClient.IdentifyHeartNineOwnerAsync(_pendingHeartIdentification,
                    _participantUserId);
            }
            else
            {
                confirmation = await _matchClient.AssignMissionTrickDistributionAsync(_pendingTrickDistribution,
                    _participantUserId);
            }
            return confirmation;
        }

        public void ClearPendingFinalPreparation()
        {
            _pendingHeartIdentification = null;
            _pendingTrickDistribution = null;
        }

        public void ApplyFinalMissionRoles(PlayerMissionPreparationSnapshot preparation)
        {
            ConfirmedMissionRoles.Clear();
            AddPublicMissionRole("MissionRole_Label_FirstAndLast",
                preparation?.FirstAndLastTrickWinnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_FirstFour", preparation?.FirstFourTricksWinnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_Last", preparation?.LastTrickWinnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_HeartNineOwner", preparation?.HeartNineOwnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_HeartCapturer", preparation?.RequiredHeartCaptureParticipantUserId);
            NotifyFinalPreparationProperties();
        }

        private void AddPublicMissionRole(string label, int? participantUserId)
        {
            if (participantUserId.HasValue)
            {
                ConfirmedMissionRoles.Add(new PublicMissionRoleViewModel(label,
                    _participantNameResolver(participantUserId.Value)));
            }
        }

        public void NotifyFinalPreparationProperties()
        {
            OnPropertyChanged(nameof(IsTrickDistributionSelection));
            OnPropertyChanged(nameof(IsHeartNineIdentificationStage));
            OnPropertyChanged(nameof(IsHeartCaptureProgressVisible));
            OnPropertyChanged(nameof(HeartCaptureProgressDisplay));
            OnPropertyChanged(nameof(CanIdentifyHeartNineOwnership));
        }
    }
}
