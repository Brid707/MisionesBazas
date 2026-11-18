using System;
using System.Diagnostics;
using System.Threading;
using Gameplay;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private readonly Timer _retryCountdownTimer;
        private long _retrySnapshotTimestamp;
        private int _retryRemainingMilliseconds;

        public int CurrentMissionAttemptNumber => _confirmedMatchSnapshot?.MissionRetry?.AttemptNumber ?? 1;

        public bool IsMissionRetryVisible => _confirmedMatchSnapshot?.MissionRetry != null &&
            _confirmedMatchSnapshot.MissionRetry.Status != MissionRetryStatus.Inactive;

        public int MissionRetryRemainingSeconds
        {
            get
            {
                double elapsedMilliseconds = (Stopwatch.GetTimestamp() - _retrySnapshotTimestamp) *
                    1000.0 / Stopwatch.Frequency;
                return (int)Math.Ceiling(Math.Max(0, _retryRemainingMilliseconds - elapsedMilliseconds) / 1000.0);
            }
        }

        public bool HasMissionRetryCountdown => _isMatchConnected && MissionRetryRemainingSeconds > 0 &&
            (_confirmedMatchSnapshot?.MissionRetry?.Status == MissionRetryStatus.CountingDown ||
                _confirmedMatchSnapshot?.MissionRetry?.Status == MissionRetryStatus.PreparationFailed);

        public string MissionRetryStatusResourceKey
        {
            get
            {
                MissionRetryStatus status = _confirmedMatchSnapshot?.MissionRetry?.Status ??
                    MissionRetryStatus.Inactive;
                string resourceKey = "MissionRetry_Status_" + status;
                if (!_isMatchConnected)
                {
                    resourceKey = "MissionRetry_Status_ConnectionUnavailable";
                }
                else if (status == MissionRetryStatus.CountingDown && MissionRetryRemainingSeconds == 0)
                {
                    resourceKey = "MissionRetry_Status_AwaitingServer";
                }
                return resourceKey;
            }
        }

        private void ApplyMissionRetrySnapshot(MissionRetrySnapshot retrySnapshot)
        {
            _retryRemainingMilliseconds = Math.Max(0, retrySnapshot?.RemainingDelayMilliseconds ?? 0);
            _retrySnapshotTimestamp = Stopwatch.GetTimestamp();
        }

        private void OnRetryCountdownTick(object timerState)
        {
            if (!_isDisposed && IsMissionRetryVisible && _uiContext != null)
            {
                _uiContext.Post(_ => NotifyMissionRetryProperties(), null);
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

        private void NotifyMissionRetryProperties()
        {
            OnPropertyChanged(nameof(IsMissionRetryVisible));
            OnPropertyChanged(nameof(CurrentMissionAttemptNumber));
            OnPropertyChanged(nameof(MissionRetryRemainingSeconds));
            OnPropertyChanged(nameof(HasMissionRetryCountdown));
            OnPropertyChanged(nameof(MissionRetryStatusResourceKey));
        }
    }
}
