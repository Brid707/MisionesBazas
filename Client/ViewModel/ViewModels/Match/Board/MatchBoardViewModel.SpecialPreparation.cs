using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private MissionRoleAssignmentSubmission _pendingRoleAssignment;
        private HeartNineIdentificationSubmission _pendingHeartIdentification;
        private MissionTrickDistributionSubmission _pendingTrickDistribution;
        private BlindObjectiveResponseSubmission _pendingBlindResponse;
        private LobbyPlayerItemViewModel _selectedRoleParticipant;
        private bool _isSpecialPreparationPanelOpen;

        public bool IsSpecialPreparationPanelOpen
        {
            get => _isSpecialPreparationPanelOpen;
            set => SetProperty(ref _isSpecialPreparationPanelOpen, value && IsSpecialPreparationVisible);
        }


        public ObservableCollection<LobbyPlayerItemViewModel> EligibleRoleParticipants { get; } =
            new ObservableCollection<LobbyPlayerItemViewModel>();
        public ObservableCollection<BlindObjectiveResponseViewModel> BlindObjectiveResponseDescriptions { get; } =
            new ObservableCollection<BlindObjectiveResponseViewModel>();
        public ICommand AssignMissionRoleCommand { get; private set; }
        public ICommand RespondCapableCommand { get; private set; }
        public ICommand RespondNotCapableCommand { get; private set; }
        public bool IsSpecialPreparationVisible => PreparationStage == MissionPreparationStage.RoleSelection ||
            PreparationStage == MissionPreparationStage.BlindResponses ||
            PreparationStage == MissionPreparationStage.AssigneeSelection ||
            PreparationStage == MissionPreparationStage.HeartNineIdentification ||
            PreparationStage == MissionPreparationStage.TrickDistributionSelection;
        public bool IsRoleAssignmentVisible => EligibleRoleParticipants.Count > 0 && !IsTrickDistributionSelection;
        public bool IsBlindResponseChoiceVisible =>
            _confirmedMatchSnapshot?.MissionPreparation?.CanRespondToBlindObjectives ?? false;
        public bool AreBlindResponsesVisible => PreparationStage == MissionPreparationStage.BlindResponses ||
            PreparationStage == MissionPreparationStage.AssigneeSelection;
        public bool CanRespondBlindObjectives => CanSubmitMatchRequest() &&
            (_confirmedMatchSnapshot?.MissionPreparation?.CanRespondToBlindObjectives ?? false);
        public bool CanSelectRoleParticipant => CanSubmitMatchRequest() && EligibleRoleParticipants.Count > 0;
        public string SpecialPreparationFeedbackKey => GetSpecialPreparationFeedbackKey();
        public bool HasSingleTrickWinner =>
            _confirmedMatchSnapshot?.MissionPreparation?.SingleTrickWinnerParticipantUserId.HasValue ?? false;
        public string SingleTrickWinnerParticipantName => GetParticipantName(
            _confirmedMatchSnapshot?.MissionPreparation?.SingleTrickWinnerParticipantUserId ?? 0);
        private bool HasPendingPreparation => _pendingRoleAssignment != null || _pendingBlindResponse != null ||
            _pendingHeartIdentification != null || _pendingTrickDistribution != null;
        private MissionPreparationStage PreparationStage => _confirmedMatchSnapshot?.MissionPreparation?.Stage ??
            MissionPreparationStage.None;

        public LobbyPlayerItemViewModel SelectedRoleParticipant
        {
            get => _selectedRoleParticipant;
            set => SetProperty(ref _selectedRoleParticipant, value);
        }

        private void InitializeSpecialPreparationCommands()
        {
            AssignMissionRoleCommand = new AsyncRelayCommand(AssignMissionRoleAsync, CanAssignMissionRole);
            RespondCapableCommand = new AsyncRelayCommand(() => RespondBlindObjectivesAsync(BlindObjectiveResponse.Yes),
                () => CanRespondBlindObjectives);
            RespondNotCapableCommand = new AsyncRelayCommand(() =>
                RespondBlindObjectivesAsync(BlindObjectiveResponse.No),
                () => CanRespondBlindObjectives);
        }

        private bool CanAssignMissionRole()
        {
            return CanSelectRoleParticipant && SelectedRoleParticipant != null &&
                EligibleRoleParticipants.Contains(SelectedRoleParticipant);
        }

        private async Task AssignMissionRoleAsync()
        {
            if (CanAssignMissionRole())
            {
                _pendingRoleAssignment = new MissionRoleAssignmentSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = _confirmedMatchSnapshot.MatchId,
                    MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = _confirmedMatchSnapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = MatchStateVersion,
                    SelectedParticipantUserId = SelectedRoleParticipant.IdUser
                };
                await SynchronizeMatchAsync();
            }
        }

        private async Task RespondBlindObjectivesAsync(BlindObjectiveResponse response)
        {
            if (CanRespondBlindObjectives)
            {
                _pendingBlindResponse = new BlindObjectiveResponseSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = _confirmedMatchSnapshot.MatchId,
                    MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = _confirmedMatchSnapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = MatchStateVersion,
                    Response = response
                };
                await SynchronizeMatchAsync();
            }
        }

        private async Task<string> ConfirmPendingPreparationAsync()
        {
            string feedback = null;
            if (HasPendingPreparation)
            {
                try
                {
                    Guid expectedIdentity = GetPendingPreparationIdentity();
                    MissionPreparationConfirmation confirmation = await SubmitPendingPreparationAsync();
                    if (confirmation == null || confirmation.MissionPreparationSubmissionId != expectedIdentity)
                    {
                        throw new FaultException<MatchAccessFault>(new MatchAccessFault
                        { FailureCode = nameof(MissionPreparationFailureReason.OperationUnavailable) });
                    }
                    ClearPendingPreparation();
                }
                catch (FaultException<MissionPreparationFault> ex)
                {
                    feedback = "MissionPreparation_Error_" + ex.Detail.FailureReason;
                    if (ex.Detail.FailureReason != MissionPreparationFailureReason.OperationUnavailable)
                    {
                        ClearPendingPreparation();
                    }
                }
            }
            return feedback;
        }

        private async Task<MissionPreparationConfirmation> SubmitPendingPreparationAsync()
        {
            MissionPreparationConfirmation confirmation;
            if (_pendingRoleAssignment != null)
            {
                confirmation = await _matchClient.AssignMissionRoleAsync(_pendingRoleAssignment, _participantUserId);
            }
            else if (_pendingBlindResponse != null)
            {
                confirmation = await _matchClient.RespondToBlindObjectivesAsync(_pendingBlindResponse,
                    _participantUserId);
            }
            else
            {
                confirmation = await SubmitPendingFinalPreparationAsync();
            }
            return confirmation;
        }

        private void ClearPendingPreparation()
        {
            _pendingRoleAssignment = null;
            _pendingBlindResponse = null;
            _pendingHeartIdentification = null;
            _pendingTrickDistribution = null;
        }

        private void ApplySpecialPreparationSnapshot(PlayerMissionPreparationSnapshot preparation)
        {
            int? selectedUserId = SelectedRoleParticipant?.IdUser;
            EligibleRoleParticipants.Clear();
            foreach (int userId in preparation?.EligibleRoleParticipantUserIds ?? Array.Empty<int>())
            {
                LobbyPlayerItemViewModel participant = _seatedPlayers.FirstOrDefault(player => player.IdUser == userId);
                if (participant != null)
                {
                    EligibleRoleParticipants.Add(participant);
                }
            }
            SelectedRoleParticipant = EligibleRoleParticipants.FirstOrDefault(player => player.IdUser ==
                selectedUserId);
            BlindObjectiveResponseDescriptions.Clear();
            foreach (BlindObjectiveParticipantSnapshot response in preparation?.BlindObjectiveResponses ??
                Array.Empty<BlindObjectiveParticipantSnapshot>())
            {
                string responseKey = "MissionPreparation_Response_" + response.Response;
                BlindObjectiveResponseDescriptions.Add(new BlindObjectiveResponseViewModel(
                    GetParticipantName(response.ParticipantUserId), responseKey));
            }
            if (!IsSpecialPreparationVisible)
            {
                IsSpecialPreparationPanelOpen = false;
            }
            ApplyFinalMissionRoles(preparation);
            NotifySpecialPreparationProperties();
        }

        private void NotifySpecialPreparationProperties()
        {
            OnPropertyChanged(nameof(IsSpecialPreparationVisible));
            OnPropertyChanged(nameof(IsRoleAssignmentVisible));
            OnPropertyChanged(nameof(IsBlindResponseChoiceVisible));
            OnPropertyChanged(nameof(AreBlindResponsesVisible));
            OnPropertyChanged(nameof(CanRespondBlindObjectives));
            OnPropertyChanged(nameof(CanSelectRoleParticipant));
            OnPropertyChanged(nameof(SpecialPreparationFeedbackKey));
            OnPropertyChanged(nameof(IsTrickDistributionSelection));
            OnPropertyChanged(nameof(IsHeartNineIdentificationStage));
            OnPropertyChanged(nameof(IsHeartCaptureProgressVisible));
            OnPropertyChanged(nameof(HeartCaptureProgressDisplay));
            OnPropertyChanged(nameof(CanIdentifyHeartNineOwnership));
            OnPropertyChanged(nameof(HasSingleTrickWinner));
            OnPropertyChanged(nameof(SingleTrickWinnerParticipantName));
        }
    }
}
