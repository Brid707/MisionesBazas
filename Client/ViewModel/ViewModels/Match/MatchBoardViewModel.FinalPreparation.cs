using System;
using System.Linq;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private LobbyPlayerItemViewModel _selectedFirstFourTrickWinner;
        private LobbyPlayerItemViewModel _selectedLastTrickWinner;
        public ObservableCollection<PublicMissionRoleViewModel> ConfirmedMissionRoles { get; } =
            new ObservableCollection<PublicMissionRoleViewModel>();
        public ICommand IdentifyHeartNineOwnerCommand { get; private set; }
        public ICommand AssignTrickDistributionCommand { get; private set; }
        public bool IsTrickDistributionSelection => PreparationStage ==
            MissionPreparationStage.TrickDistributionSelection;
        public bool IsHeartNineIdentificationStage =>
            PreparationStage == MissionPreparationStage.HeartNineIdentification;
        public bool IsHeartCaptureProgressVisible =>
            _confirmedMatchSnapshot?.MissionPreparation?.MissionNumber == MissionFortySixNumber &&
            IsMissionPreparationComplete;
        private static readonly int s_requiredHeartCardCount =
            TrickTakingMissions.Rules.Rules.DeckRules.CreateStandardDeck().Count(card =>
                card.Suit == TrickTakingMissions.Rules.Enums.CardSuit.Heart);
        public string HeartCaptureProgressDisplay => string.Format(System.Globalization.CultureInfo.InvariantCulture,
            "{0}/{1}", _confirmedMatchSnapshot?.MissionConditionProgress?.CapturedHeartCardCount ?? 0,
            s_requiredHeartCardCount);
        public bool CanIdentifyHeartNineOwnership => CanSubmitMatchRequest() &&
            (_confirmedMatchSnapshot?.MissionPreparation?.CanIdentifyHeartNineOwnership ?? false);

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

        private void InitializeFinalPreparationCommands()
        {
            IdentifyHeartNineOwnerCommand = new AsyncRelayCommand(IdentifyHeartNineOwnerAsync,
                () => CanIdentifyHeartNineOwnership);
            AssignTrickDistributionCommand = new AsyncRelayCommand(AssignTrickDistributionAsync, CanAssignDistribution);
        }

        private bool CanAssignDistribution()
        {
            return CanSubmitMatchRequest() && IsTrickDistributionSelection && SelectedFirstFourTrickWinner != null &&
                SelectedLastTrickWinner != null && SelectedFirstFourTrickWinner != SelectedLastTrickWinner &&
                EligibleRoleParticipants.Contains(SelectedFirstFourTrickWinner) &&
                EligibleRoleParticipants.Contains(SelectedLastTrickWinner);
        }

        private async Task IdentifyHeartNineOwnerAsync()
        {
            if (CanIdentifyHeartNineOwnership)
            {
                _pendingHeartIdentification = new HeartNineIdentificationSubmission
                {
                    LobbyCode = _lobbyCode, MatchId = _confirmedMatchSnapshot.MatchId,
                    MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = _confirmedMatchSnapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(), ExpectedMatchStateVersion = MatchStateVersion
                };
                await SynchronizeMatchAsync();
            }
        }

        private async Task AssignTrickDistributionAsync()
        {
            if (CanAssignDistribution())
            {
                _pendingTrickDistribution = new MissionTrickDistributionSubmission
                {
                    LobbyCode = _lobbyCode, MatchId = _confirmedMatchSnapshot.MatchId,
                    MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = _confirmedMatchSnapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(), ExpectedMatchStateVersion = MatchStateVersion,
                    FirstFourTricksWinnerParticipantUserId = SelectedFirstFourTrickWinner.IdUser,
                    LastTrickWinnerParticipantUserId = SelectedLastTrickWinner.IdUser
                };
                await SynchronizeMatchAsync();
            }
        }

        private Guid GetPendingPreparationIdentity()
        {
            return _pendingRoleAssignment?.MissionPreparationSubmissionId ??
                _pendingBlindResponse?.MissionPreparationSubmissionId ??
                _pendingHeartIdentification?.MissionPreparationSubmissionId ??
                _pendingTrickDistribution.MissionPreparationSubmissionId;
        }

        private async Task<MissionPreparationConfirmation> SubmitPendingFinalPreparationAsync()
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

        private string GetSpecialPreparationFeedbackKey()
        {
            string key = "MissionPreparation_Stage_" + PreparationStage;
            if (PreparationStage == MissionPreparationStage.RoleSelection)
            {
                int mission = _confirmedMatchSnapshot.MissionPreparation.MissionNumber;
                if (mission == MissionThirtyThreeNumber)
                {
                    key = "MissionPreparation_Label_SelectSingleTrickWinner";
                }
                if (mission == MissionFortyOneNumber)
                {
                    key = "MissionPreparation_Label_SelectFirstAndLastWinner";
                }
            }
            return key;
        }

        private void ApplyFinalMissionRoles(PlayerMissionPreparationSnapshot preparation)
        {
            ConfirmedMissionRoles.Clear();
            AddPublicMissionRole("MissionRole_Label_FirstAndLast",
                preparation?.FirstAndLastTrickWinnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_FirstFour", preparation?.FirstFourTricksWinnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_Last", preparation?.LastTrickWinnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_HeartNineOwner", preparation?.HeartNineOwnerParticipantUserId);
            AddPublicMissionRole("MissionRole_Label_HeartCapturer", preparation?.RequiredHeartCaptureParticipantUserId);
        }

        private void AddPublicMissionRole(string label, int? participantUserId)
        {
            if (participantUserId.HasValue)
            {
                ConfirmedMissionRoles.Add(new PublicMissionRoleViewModel(label,
                    GetParticipantName(participantUserId.Value)));
            }
        }
    }
}
