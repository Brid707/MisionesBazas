using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using Model.Services;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchSpecialPreparationViewModel : ViewModelBase
    {
        private const int MissionThirtyThreeNumber = 33;
        private const int MissionFortyOneNumber = 41;

        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly Func<PlayerMatchSnapshot> _snapshotProvider;
        private readonly Func<long> _matchStateVersionProvider;
        private readonly Func<bool> _canSubmitMatchRequestProvider;
        private readonly Func<int, string> _participantNameResolver;
        private readonly Func<Task> _synchronizeMatchAction;
        private readonly List<LobbyPlayerItemViewModel> _seatedPlayers;
        private readonly MatchFinalPreparationViewModel _finalPreparation;

        private MissionRoleAssignmentSubmission _pendingRoleAssignment;
        private BlindObjectiveResponseSubmission _pendingBlindResponse;
        private LobbyPlayerItemViewModel _selectedRoleParticipant;
        private bool _isSpecialPreparationPanelOpen;

        public MatchSpecialPreparationViewModel(
            string lobbyCode,
            int participantUserId,
            IMatchClient matchClient,
            Func<PlayerMatchSnapshot> snapshotProvider,
            Func<long> matchStateVersionProvider,
            Func<bool> canSubmitMatchRequestProvider,
            Func<int, string> participantNameResolver,
            Func<Task> synchronizeMatchAction,
            List<LobbyPlayerItemViewModel> seatedPlayers,
            MatchFinalPreparationViewModel finalPreparation)
        {
            _lobbyCode = lobbyCode;
            _participantUserId = participantUserId;
            _matchClient = matchClient ?? throw new ArgumentNullException(nameof(matchClient));
            _snapshotProvider = snapshotProvider ?? throw new ArgumentNullException(nameof(snapshotProvider));
            _matchStateVersionProvider = matchStateVersionProvider ?? throw new ArgumentNullException(nameof(matchStateVersionProvider));
            _canSubmitMatchRequestProvider = canSubmitMatchRequestProvider ?? throw new ArgumentNullException(nameof(canSubmitMatchRequestProvider));
            _participantNameResolver = participantNameResolver ?? throw new ArgumentNullException(nameof(participantNameResolver));
            _synchronizeMatchAction = synchronizeMatchAction ?? throw new ArgumentNullException(nameof(synchronizeMatchAction));
            _seatedPlayers = seatedPlayers ?? throw new ArgumentNullException(nameof(seatedPlayers));
            _finalPreparation = finalPreparation ?? throw new ArgumentNullException(nameof(finalPreparation));

            EligibleRoleParticipants = new ObservableCollection<LobbyPlayerItemViewModel>();
            BlindObjectiveResponseDescriptions = new ObservableCollection<BlindObjectiveResponseViewModel>();

            AssignMissionRoleCommand = new AsyncRelayCommand(AssignMissionRoleAsync, CanAssignMissionRole);
            RespondCapableCommand = new AsyncRelayCommand(() => RespondBlindObjectivesAsync(BlindObjectiveResponse.Yes),
                () => CanRespondBlindObjectives);
            RespondNotCapableCommand = new AsyncRelayCommand(() => RespondBlindObjectivesAsync(BlindObjectiveResponse.No),
                () => CanRespondBlindObjectives);
        }

        public ObservableCollection<LobbyPlayerItemViewModel> EligibleRoleParticipants { get; }
        public ObservableCollection<BlindObjectiveResponseViewModel> BlindObjectiveResponseDescriptions { get; }
        public ICommand AssignMissionRoleCommand { get; }
        public ICommand RespondCapableCommand { get; }
        public ICommand RespondNotCapableCommand { get; }

        public bool HasPendingPreparation =>
            _pendingRoleAssignment != null ||
            _pendingBlindResponse != null ||
            _finalPreparation.HasPendingFinalPreparation;

        public MissionPreparationStage PreparationStage =>
            _snapshotProvider()?.MissionPreparation?.Stage ?? MissionPreparationStage.None;

        public bool IsSpecialPreparationPanelOpen
        {
            get => _isSpecialPreparationPanelOpen;
            set => SetProperty(ref _isSpecialPreparationPanelOpen, value && IsSpecialPreparationVisible);
        }

        public LobbyPlayerItemViewModel SelectedRoleParticipant
        {
            get => _selectedRoleParticipant;
            set => SetProperty(ref _selectedRoleParticipant, value);
        }

        public bool IsSpecialPreparationVisible =>
            PreparationStage == MissionPreparationStage.RoleSelection ||
            PreparationStage == MissionPreparationStage.BlindResponses ||
            PreparationStage == MissionPreparationStage.AssigneeSelection ||
            PreparationStage == MissionPreparationStage.HeartNineIdentification ||
            PreparationStage == MissionPreparationStage.TrickDistributionSelection;

        public bool IsRoleAssignmentVisible =>
            EligibleRoleParticipants.Count > 0 && !_finalPreparation.IsTrickDistributionSelection;

        public bool IsBlindResponseChoiceVisible =>
            _snapshotProvider()?.MissionPreparation?.CanRespondToBlindObjectives ?? false;

        public bool AreBlindResponsesVisible =>
            PreparationStage == MissionPreparationStage.BlindResponses ||
            PreparationStage == MissionPreparationStage.AssigneeSelection;

        public bool CanRespondBlindObjectives =>
            _canSubmitMatchRequestProvider() &&
            (_snapshotProvider()?.MissionPreparation?.CanRespondToBlindObjectives ?? false);

        public bool CanSelectRoleParticipant =>
            _canSubmitMatchRequestProvider() && EligibleRoleParticipants.Count > 0;

        public string SpecialPreparationFeedbackKey => GetSpecialPreparationFeedbackKey();

        public bool HasSingleTrickWinner =>
            _snapshotProvider()?.MissionPreparation?.SingleTrickWinnerParticipantUserId.HasValue ?? false;

        public string SingleTrickWinnerParticipantName =>
            _participantNameResolver(_snapshotProvider()?.MissionPreparation?.SingleTrickWinnerParticipantUserId ?? 0);

        private bool CanAssignMissionRole()
        {
            return CanSelectRoleParticipant && SelectedRoleParticipant != null &&
                EligibleRoleParticipants.Contains(SelectedRoleParticipant);
        }

        private async Task AssignMissionRoleAsync()
        {
            if (CanAssignMissionRole())
            {
                PlayerMatchSnapshot snapshot = _snapshotProvider();
                _pendingRoleAssignment = new MissionRoleAssignmentSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = snapshot.MatchId,
                    MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = snapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = _matchStateVersionProvider(),
                    SelectedParticipantUserId = SelectedRoleParticipant.IdUser
                };
                await _synchronizeMatchAction();
            }
        }

        private async Task RespondBlindObjectivesAsync(BlindObjectiveResponse response)
        {
            if (CanRespondBlindObjectives)
            {
                PlayerMatchSnapshot snapshot = _snapshotProvider();
                _pendingBlindResponse = new BlindObjectiveResponseSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = snapshot.MatchId,
                    MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                    MissionPreparationStageId = snapshot.MissionPreparation.MissionPreparationStageId,
                    MissionPreparationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = _matchStateVersionProvider(),
                    Response = response
                };
                await _synchronizeMatchAction();
            }
        }

        public async Task<string> ConfirmPendingPreparationAsync()
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

        private Guid GetPendingPreparationIdentity()
        {
            return _pendingRoleAssignment?.MissionPreparationSubmissionId ??
                _pendingBlindResponse?.MissionPreparationSubmissionId ??
                _finalPreparation.GetPendingPreparationIdentity();
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
                confirmation = await _finalPreparation.SubmitPendingFinalPreparationAsync();
            }
            return confirmation;
        }

        public void ClearPendingPreparation()
        {
            _pendingRoleAssignment = null;
            _pendingBlindResponse = null;
            _finalPreparation.ClearPendingFinalPreparation();
        }

        private string GetSpecialPreparationFeedbackKey()
        {
            string key = "MissionPreparation_Stage_" + PreparationStage;
            if (PreparationStage == MissionPreparationStage.RoleSelection)
            {
                int mission = _snapshotProvider()?.MissionPreparation?.MissionNumber ?? 0;
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

        public void ApplySpecialPreparationSnapshot(PlayerMissionPreparationSnapshot preparation)
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
            SelectedRoleParticipant = EligibleRoleParticipants.FirstOrDefault(player => player.IdUser == selectedUserId);
            BlindObjectiveResponseDescriptions.Clear();
            foreach (BlindObjectiveParticipantSnapshot response in preparation?.BlindObjectiveResponses ??
                Array.Empty<BlindObjectiveParticipantSnapshot>())
            {
                string responseKey = "MissionPreparation_Response_" + response.Response;
                BlindObjectiveResponseDescriptions.Add(new BlindObjectiveResponseViewModel(
                    _participantNameResolver(response.ParticipantUserId), responseKey));
            }
            if (!IsSpecialPreparationVisible)
            {
                IsSpecialPreparationPanelOpen = false;
            }
            _finalPreparation.ApplyFinalMissionRoles(preparation);
            NotifySpecialPreparationProperties();
        }

        public void NotifySpecialPreparationProperties()
        {
            OnPropertyChanged(nameof(IsSpecialPreparationVisible));
            OnPropertyChanged(nameof(IsRoleAssignmentVisible));
            OnPropertyChanged(nameof(IsBlindResponseChoiceVisible));
            OnPropertyChanged(nameof(AreBlindResponsesVisible));
            OnPropertyChanged(nameof(CanRespondBlindObjectives));
            OnPropertyChanged(nameof(CanSelectRoleParticipant));
            OnPropertyChanged(nameof(SpecialPreparationFeedbackKey));
            OnPropertyChanged(nameof(HasSingleTrickWinner));
            OnPropertyChanged(nameof(SingleTrickWinnerParticipantName));
            _finalPreparation.NotifyFinalPreparationProperties();
        }
    }
}
