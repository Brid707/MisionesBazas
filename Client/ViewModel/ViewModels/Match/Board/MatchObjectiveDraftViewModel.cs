using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using Model.Services;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchObjectiveDraftViewModel : ViewModelBase
    {
        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly Func<PlayerMatchSnapshot> _snapshotProvider;
        private readonly Func<long> _matchStateVersionProvider;
        private readonly Func<bool> _canSubmitMatchRequestProvider;
        private readonly Func<bool> _isSpecialPreparationVisibleProvider;
        private readonly Func<int, string> _participantNameResolver;
        private readonly Func<Task> _synchronizeMatchAction;
        private readonly List<LobbyPlayerItemViewModel> _seatedPlayers;
        private readonly Func<bool> _isDisposedProvider;

        private MissionObjectiveDraftSubmission _pendingObjectiveDraftSubmission;
        private Guid _lastSelectionFreeCycleSubmissionId;

        public MatchObjectiveDraftViewModel(
            string lobbyCode,
            int participantUserId,
            IMatchClient matchClient,
            Func<PlayerMatchSnapshot> snapshotProvider,
            Func<long> matchStateVersionProvider,
            Func<bool> canSubmitMatchRequestProvider,
            Func<bool> isSpecialPreparationVisibleProvider,
            Func<int, string> participantNameResolver,
            Func<Task> synchronizeMatchAction,
            List<LobbyPlayerItemViewModel> seatedPlayers,
            Func<bool> isDisposedProvider)
        {
            _lobbyCode = lobbyCode;
            _participantUserId = participantUserId;
            _matchClient = matchClient ?? throw new ArgumentNullException(nameof(matchClient));
            _snapshotProvider = snapshotProvider ?? throw new ArgumentNullException(nameof(snapshotProvider));
            _matchStateVersionProvider = matchStateVersionProvider ?? throw new ArgumentNullException(nameof(matchStateVersionProvider));
            _canSubmitMatchRequestProvider = canSubmitMatchRequestProvider ?? throw new ArgumentNullException(nameof(canSubmitMatchRequestProvider));
            _isSpecialPreparationVisibleProvider = isSpecialPreparationVisibleProvider ?? throw new ArgumentNullException(nameof(isSpecialPreparationVisibleProvider));
            _participantNameResolver = participantNameResolver ?? throw new ArgumentNullException(nameof(participantNameResolver));
            _synchronizeMatchAction = synchronizeMatchAction ?? throw new ArgumentNullException(nameof(synchronizeMatchAction));
            _seatedPlayers = seatedPlayers ?? throw new ArgumentNullException(nameof(seatedPlayers));
            _isDisposedProvider = isDisposedProvider ?? throw new ArgumentNullException(nameof(isDisposedProvider));

            UnassignedMissionObjectives = new ObservableCollection<MissionObjectiveViewModel>();
            SelectMissionObjectiveCommand = new AsyncRelayCommand(SelectMissionObjectiveAsync, CanSelectMissionObjective);
            PassObjectiveDraftCommand = new AsyncRelayCommand(PassObjectiveDraftAsync, CanSubmitObjectiveDraft);
        }

        public ObservableCollection<MissionObjectiveViewModel> UnassignedMissionObjectives { get; }
        public ICommand SelectMissionObjectiveCommand { get; }
        public ICommand PassObjectiveDraftCommand { get; }

        public bool HasPendingSubmission => _pendingObjectiveDraftSubmission != null;

        public bool IsMissionPreparationComplete =>
            _snapshotProvider()?.MissionPreparation?.IsPreparationComplete ?? false;

        public bool IsObjectiveDraftVisible =>
            _snapshotProvider()?.MissionPreparation != null &&
            !IsMissionPreparationComplete &&
            !_isSpecialPreparationVisibleProvider();

        public string CurrentObjectiveDraftPlayerName =>
            _participantNameResolver(_snapshotProvider()?.MissionPreparation?.CurrentObjectiveDraftPlayerUserId ?? 0);

        public bool CanSubmitObjectiveDraft()
        {
            PlayerMatchSnapshot snapshot = _snapshotProvider();
            return _canSubmitMatchRequestProvider() &&
                IsObjectiveDraftVisible &&
                snapshot?.MissionPreparation != null &&
                snapshot.MissionPreparation.CurrentObjectiveDraftPlayerUserId == _participantUserId &&
                snapshot.MissionPreparation.AvailableObjectiveDraftSubmissionId.HasValue;
        }

        private bool CanSelectMissionObjective(object selectedObjective)
        {
            return CanSubmitObjectiveDraft() && selectedObjective is Guid objectiveId &&
                UnassignedMissionObjectives.Any(objective => objective.MissionObjectiveId == objectiveId);
        }

        private async Task SelectMissionObjectiveAsync(object selectedObjective)
        {
            if (CanSelectMissionObjective(selectedObjective))
            {
                await SubmitObjectiveDraftAsync(MissionObjectiveDraftAction.SelectObjective, (Guid)selectedObjective);
            }
        }

        private async Task PassObjectiveDraftAsync()
        {
            if (CanSubmitObjectiveDraft())
            {
                await SubmitObjectiveDraftAsync(MissionObjectiveDraftAction.Pass, null);
            }
        }

        private async Task SubmitObjectiveDraftAsync(MissionObjectiveDraftAction action, Guid? objectiveId)
        {
            PlayerMatchSnapshot snapshot = _snapshotProvider();
            _pendingObjectiveDraftSubmission = new MissionObjectiveDraftSubmission
            {
                LobbyCode = _lobbyCode,
                MatchId = snapshot.MatchId,
                MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                ObjectiveDraftSubmissionId = snapshot.MissionPreparation.AvailableObjectiveDraftSubmissionId.Value,
                ExpectedMatchStateVersion = _matchStateVersionProvider(),
                ObjectiveDraftAction = action,
                SelectedMissionObjectiveId = objectiveId
            };
            await _synchronizeMatchAction();
        }

        public async Task<string> ConfirmPendingObjectiveDraftAsync()
        {
            string feedbackResourceKey = null;
            if (_pendingObjectiveDraftSubmission != null)
            {
                MissionObjectiveDraftDecision decision = await _matchClient.ProcessObjectiveDraftActionAsync(
                    _pendingObjectiveDraftSubmission, _participantUserId);
                if (!_isDisposedProvider() && decision.ObjectiveDraftSubmissionId ==
                    _pendingObjectiveDraftSubmission.ObjectiveDraftSubmissionId)
                {
                    feedbackResourceKey = GetObjectiveDraftDecisionFeedback(decision);
                    _pendingObjectiveDraftSubmission = null;
                }
            }
            return feedbackResourceKey;
        }

        private string GetObjectiveDraftDecisionFeedback(MissionObjectiveDraftDecision decision)
        {
            string feedbackResourceKey = null;
            if (!decision.IsAccepted)
            {
                feedbackResourceKey = "MissionDraft_Error_" + decision.RejectionReason;
            }
            else if (decision.HasCompletedSelectionFreeCycle &&
                _lastSelectionFreeCycleSubmissionId != decision.ObjectiveDraftSubmissionId)
            {
                _lastSelectionFreeCycleSubmissionId = decision.ObjectiveDraftSubmissionId;
                feedbackResourceKey = "MissionDraft_Label_SelectionFreeCycle";
            }
            return feedbackResourceKey;
        }

        public void ApplyObjectiveDraftSnapshot(PlayerMissionPreparationSnapshot preparation)
        {
            UnassignedMissionObjectives.Clear();
            foreach (LobbyPlayerItemViewModel participant in _seatedPlayers)
            {
                participant.MissionObjectives.Clear();
            }
            foreach (MissionObjectiveSnapshot objective in preparation?.Objectives ?? new MissionObjectiveSnapshot[0])
            {
                var objectiveViewModel = new MissionObjectiveViewModel(objective);
                if (!objective.AssignedPlayerUserId.HasValue)
                {
                    UnassignedMissionObjectives.Add(objectiveViewModel);
                }
                else
                {
                    _seatedPlayers.Find(participant => participant.IdUser == objective.AssignedPlayerUserId)
                        ?.MissionObjectives.Add(objectiveViewModel);
                }
            }
            NotifyObjectiveDraftProperties();
        }

        public void NotifyObjectiveDraftProperties()
        {
            OnPropertyChanged(nameof(IsMissionPreparationComplete));
            OnPropertyChanged(nameof(IsObjectiveDraftVisible));
            OnPropertyChanged(nameof(CurrentObjectiveDraftPlayerName));
        }
    }
}
