using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private MissionObjectiveDraftSubmission _pendingObjectiveDraftSubmission;
        private Guid _lastSelectionFreeCycleSubmissionId;

        public ObservableCollection<MissionObjectiveViewModel> UnassignedMissionObjectives { get; } =
            new ObservableCollection<MissionObjectiveViewModel>();
        public ICommand SelectMissionObjectiveCommand { get; private set; }
        public ICommand PassObjectiveDraftCommand { get; private set; }
        public bool IsMissionPreparationComplete => _confirmedMatchSnapshot?.MissionPreparation?.IsPreparationComplete
            ?? false;
        public bool IsObjectiveDraftVisible => _confirmedMatchSnapshot?.MissionPreparation != null &&
            !IsMissionPreparationComplete;
        public string CurrentObjectiveDraftPlayerName => GetParticipantName(
            _confirmedMatchSnapshot?.MissionPreparation?.CurrentObjectiveDraftPlayerUserId ?? 0);

        private void InitializeObjectiveDraftCommands()
        {
            SelectMissionObjectiveCommand = new AsyncRelayCommand(
                SelectMissionObjectiveAsync, CanSelectMissionObjective);
            PassObjectiveDraftCommand = new AsyncRelayCommand(PassObjectiveDraftAsync, CanSubmitObjectiveDraft);
        }

        private bool CanSubmitMatchRequest()
        {
            return !_isDisposed && _isMatchConnected && _isRequestInProgress == 0 &&
                _pendingObjectiveDraftSubmission == null && _pendingCardPlaySubmission == null &&
                _pendingRadioSubmission == null;
        }

        private bool CanSubmitObjectiveDraft()
        {
            return CanSubmitMatchRequest() && IsObjectiveDraftVisible &&
                _confirmedMatchSnapshot.MissionPreparation.CurrentObjectiveDraftPlayerUserId == _participantUserId &&
                _confirmedMatchSnapshot.MissionPreparation.AvailableObjectiveDraftSubmissionId.HasValue;
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
            _pendingObjectiveDraftSubmission = new MissionObjectiveDraftSubmission
            {
                LobbyCode = _lobbyCode,
                MatchId = _confirmedMatchSnapshot.MatchId,
                MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                ObjectiveDraftSubmissionId =
                    _confirmedMatchSnapshot.MissionPreparation.AvailableObjectiveDraftSubmissionId.Value,
                ExpectedMatchStateVersion = MatchStateVersion,
                ObjectiveDraftAction = action,
                SelectedMissionObjectiveId = objectiveId
            };
            await SynchronizeMatchAsync();
        }

        private async Task<string> ConfirmPendingObjectiveDraftAsync()
        {
            string feedbackResourceKey = null;
            if (_pendingObjectiveDraftSubmission != null)
            {
                MissionObjectiveDraftDecision decision = await _matchClient.ProcessObjectiveDraftActionAsync(
                    _pendingObjectiveDraftSubmission, _participantUserId);
                if (!_isDisposed && decision.ObjectiveDraftSubmissionId ==
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

        private void ApplyObjectiveDraftSnapshot(PlayerMissionPreparationSnapshot preparation)
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
            OnPropertyChanged(nameof(IsMissionPreparationComplete));
            OnPropertyChanged(nameof(IsObjectiveDraftVisible));
            OnPropertyChanged(nameof(CurrentObjectiveDraftPlayerName));
        }
    }
}
