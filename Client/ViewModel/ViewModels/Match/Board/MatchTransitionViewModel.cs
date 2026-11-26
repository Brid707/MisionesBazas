using System;
using System.Diagnostics;
using System.Globalization;
using System.Threading;
using Model.GameServices;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchTransitionViewModel : ViewModelBase, IDisposable
    {
        private readonly Timer _missionTransitionCountdownTimer;
        private readonly SynchronizationContext _uiContext;
        private long _missionTransitionSnapshotTimestamp;
        private int _missionTransitionRemainingMilliseconds;
        private MissionTransitionSnapshot _currentTransition;
        private int? _currentMissionNumber;
        private bool _isMatchConnected;
        private bool _isDisposed;

        public MatchTransitionViewModel(SynchronizationContext uiContext)
        {
            _uiContext = uiContext;
            _missionTransitionCountdownTimer = new Timer(OnMissionTransitionCountdownTick, null, TimeSpan.Zero,
                TimeSpan.FromMilliseconds(250));
        }

        public int CurrentMissionAttemptNumber => _currentTransition?.AttemptNumber ?? 1;

        public string MissionProgressDisplay => _currentTransition == null
            ? string.Empty
            : string.Format(CultureInfo.InvariantCulture, "{0}/{1}",
                _currentMissionNumber,
                _currentTransition.TargetMissionCount);

        public bool IsCampaignCompleted => _currentTransition?.Status ==
            MissionTransitionStatus.CampaignCompleted;

        public bool IsMissionTransitionVisible => _currentTransition != null &&
            _currentTransition.Status != MissionTransitionStatus.Inactive;

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
            (_currentTransition?.Status == MissionTransitionStatus.CountingDown ||
                _currentTransition?.Status == MissionTransitionStatus.PreparationFailed);

        public string MissionTransitionStatusResourceKey
        {
            get
            {
                MissionTransitionStatus status = _currentTransition?.Status ??
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
                    _currentTransition?.Kind == MissionTransitionKind.AdvanceToNextMission)
                {
                    resourceKey = "MissionTransition_Status_AdvanceCountingDown";
                }
                return resourceKey;
            }
        }

        public void ApplyTransitionSnapshot(MissionTransitionSnapshot transitionSnapshot, int? missionNumber, bool isMatchConnected)
        {
            _currentTransition = transitionSnapshot;
            _currentMissionNumber = missionNumber;
            _isMatchConnected = isMatchConnected;
            _missionTransitionRemainingMilliseconds = Math.Max(0, transitionSnapshot?.RemainingDelayMilliseconds ?? 0);
            _missionTransitionSnapshotTimestamp = Stopwatch.GetTimestamp();
            NotifyMissionTransitionProperties();
        }

        private void OnMissionTransitionCountdownTick(object timerState)
        {
            if (!_isDisposed && IsMissionTransitionVisible && _uiContext != null)
            {
                _uiContext.Post(_ => NotifyMissionTransitionProperties(), null);
            }
        }

        public void NotifyMissionTransitionProperties()
        {
            OnPropertyChanged(nameof(IsMissionTransitionVisible));
            OnPropertyChanged(nameof(IsCampaignCompleted));
            OnPropertyChanged(nameof(MissionProgressDisplay));
            OnPropertyChanged(nameof(CurrentMissionAttemptNumber));
            OnPropertyChanged(nameof(MissionTransitionRemainingSeconds));
            OnPropertyChanged(nameof(HasMissionTransitionCountdown));
            OnPropertyChanged(nameof(MissionTransitionStatusResourceKey));
        }

        public void Dispose()
        {
            _isDisposed = true;
            _missionTransitionCountdownTimer.Dispose();
        }
    }
}
