using System;
using System.Diagnostics;
using System.Globalization;
using System.Threading;
using Gameplay;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private readonly Timer _missionTransitionCountdownTimer;
        private long _missionTransitionSnapshotTimestamp;
        private int _missionTransitionRemainingMilliseconds;

        public int CurrentMissionAttemptNumber => _confirmedMatchSnapshot?.MissionTransition?.AttemptNumber ?? 1;

        public string MissionProgressDisplay => _confirmedMatchSnapshot?.MissionTransition == null
            ? string.Empty
            : string.Format(CultureInfo.InvariantCulture, "{0}/{1}",
                _confirmedMatchSnapshot.MissionPreparation?.MissionNumber,
                _confirmedMatchSnapshot.MissionTransition.TargetMissionCount);

        public bool IsCampaignCompleted => _confirmedMatchSnapshot?.MissionTransition?.Status ==
            MissionTransitionStatus.CampaignCompleted;

        public bool IsMissionTransitionVisible => _confirmedMatchSnapshot?.MissionTransition != null &&
            _confirmedMatchSnapshot.MissionTransition.Status != MissionTransitionStatus.Inactive;

        public int MissionTransitionRemainingSeconds
        {
            get
            {
                double elapsedMilliseconds = (Stopwatch.GetTimestamp() - _missionTransitionSnapshotTimestamp) *
                    1000.0 / Stopwatch.Frequency;
                return (int)Math.Ceiling(Math.Max(0,
                    _missionTransitionRemainingMilliseconds - elapsedMilliseconds) / 1000.0);
            }
        }

        public bool HasMissionTransitionCountdown => _isMatchConnected && MissionTransitionRemainingSeconds > 0 &&
            (_confirmedMatchSnapshot?.MissionTransition?.Status == MissionTransitionStatus.CountingDown ||
                _confirmedMatchSnapshot?.MissionTransition?.Status == MissionTransitionStatus.PreparationFailed);

        public string MissionTransitionStatusResourceKey
        {
            get
            {
                MissionTransitionStatus status = _confirmedMatchSnapshot?.MissionTransition?.Status ??
                    MissionTransitionStatus.Inactive;
                string resourceKey = "MissionTransition_Status_" + status;
                if (!_isMatchConnected)
                {
                    resourceKey = "MissionTransition_Status_ConnectionUnavailable";
                }
                else if ((status == MissionTransitionStatus.CountingDown ||
                    status == MissionTransitionStatus.PreparationFailed) && MissionTransitionRemainingSeconds == 0)
                {
                    resourceKey = "MissionTransition_Status_AwaitingServer";
                }
                else if (status == MissionTransitionStatus.CountingDown &&
                    _confirmedMatchSnapshot?.MissionTransition?.Kind == MissionTransitionKind.AdvanceToNextMission)
                {
                    resourceKey = "MissionTransition_Status_AdvanceCountingDown";
                }
                return resourceKey;
            }
        }

        private void ApplyMissionTransitionSnapshot(MissionTransitionSnapshot transitionSnapshot)
        {
            _missionTransitionRemainingMilliseconds = Math.Max(0, transitionSnapshot?.RemainingDelayMilliseconds ?? 0);
            _missionTransitionSnapshotTimestamp = Stopwatch.GetTimestamp();
        }

        private void OnMissionTransitionCountdownTick(object timerState)
        {
            if (!_isDisposed && IsMissionTransitionVisible && _uiContext != null)
            {
                _uiContext.Post(_ => NotifyMissionTransitionProperties(), null);
            }
        }

        private void ResetAttemptPresentationIfChanged(PlayerMatchSnapshot playerSnapshot)
        {
            bool hasAttemptChanged = _confirmedMatchSnapshot?.MissionPreparation != null &&
                _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId !=
                    playerSnapshot.MissionPreparation?.MissionAttemptId;
            if (hasAttemptChanged)
            {
                _announcedCompletedTrickCount = 0;
                _isCompletedTrickDisplayActive = false;
                _completedTrickDisplayTimer.Change(Timeout.Infinite, Timeout.Infinite);
            }
        }

        private void NotifyMissionTransitionProperties()
        {
            OnPropertyChanged(nameof(IsMissionTransitionVisible));
            OnPropertyChanged(nameof(IsCampaignCompleted));
            OnPropertyChanged(nameof(MissionProgressDisplay));
            OnPropertyChanged(nameof(CurrentMissionAttemptNumber));
            OnPropertyChanged(nameof(MissionTransitionRemainingSeconds));
            OnPropertyChanged(nameof(HasMissionTransitionCountdown));
            OnPropertyChanged(nameof(MissionTransitionStatusResourceKey));
        }
    }
}
