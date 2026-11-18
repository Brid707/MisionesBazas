using System;
using System.Collections.Generic;
using System.Linq;

namespace Application.Models
{
    public sealed partial class MatchState
    {
        public MissionRetryScheduleStatus MissionRetryStatus { get; private set; }

        public bool HasStartedRetryExecution { get; private set; }

        public Guid MissionRetryScheduleId { get; private set; }

        public long MissionRetryDeadlineMilliseconds { get; private set; }

        public long MissionRetryConnectionVersion { get; private set; }

        public int[] MissingRetryParticipantUserIds { get; private set; } = Array.Empty<int>();

        internal void InitializePreparedMissionAttempt(PreparedMissionAttempt preparedAttempt)
        {
            if (MissionAttempt != null)
            {
                throw new InvalidOperationException(nameof(MissionAttempt));
            }
            ApplyPreparedMissionAttempt(preparedAttempt);
        }

        internal void SetMissionRetrySchedule(MissionRetryScheduleStatus status, MatchParticipantPresence presence,
            long deadlineMilliseconds)
        {
            MissionRetryStatus = status;
            HasStartedRetryExecution = false;
            MissionRetryScheduleId = Guid.NewGuid();
            MissionRetryConnectionVersion = presence.ConnectionVersion;
            MissingRetryParticipantUserIds = (int[])presence.MissingParticipantUserIds.Clone();
            MissionRetryDeadlineMilliseconds = deadlineMilliseconds;
            MatchStateVersion++;
        }

        internal void ReserveMissionRetryPreparation()
        {
            MissionRetryStatus = MissionRetryScheduleStatus.Preparing;
            MatchStateVersion++;
        }

        internal void MarkRetryExecutionStarted()
        {
            HasStartedRetryExecution = true;
        }

        internal void CommitScheduledMissionRetry(PreparedMissionAttempt preparedAttempt)
        {
            ApplyPreparedMissionAttempt(preparedAttempt);
            MatchStateVersion++;
        }

        private void ApplyPreparedMissionAttempt(PreparedMissionAttempt preparedAttempt)
        {
            MissionAttempt = preparedAttempt.MissionAttempt;
            PlayerHandCardIdsBySeat = preparedAttempt.PlayerHandCardIdsBySeat;
            WonCardIdsBySeat = preparedAttempt.WonCardIdsBySeat;
            WonTrickCountsBySeat = preparedAttempt.WonTrickCountsBySeat;
            ObjectiveCardIdsByObjectiveId = preparedAttempt.ObjectiveCardIdsByObjectiveId;
            CurrentObjectiveDraftSubmissionId = preparedAttempt.ObjectiveDraftSubmissionId;
            MaximumMissionTrickCount = preparedAttempt.MaximumMissionTrickCount;
            MissionCaptainSeat = preparedAttempt.MissionAttempt.CaptainSeat;
            CurrentTurnPlayerSeat = MissionCaptainSeat;
            CurrentTrickNumber = 1;
            LastTrickWinnerUserId = 0;
            LastEvaluatedTrickNumber = 0;
            LastMissionEvaluation = null;
            IsDealCompleted = false;
            MissionRetryStatus = MissionRetryScheduleStatus.Inactive;
            HasStartedRetryExecution = false;
            MissionRetryScheduleId = Guid.Empty;
            MissionRetryDeadlineMilliseconds = 0;
            MissionRetryConnectionVersion = 0;
            MissingRetryParticipantUserIds = Array.Empty<int>();
            LastCompletedTrickCardPlays = Array.Empty<Gameplay.MatchCardPlay>();
            CurrentTrickCardPlays.Clear();
            CapturedCardPlays.Clear();
            ProcessedCardPlayDecisionsBySubmissionId.Clear();
            ProcessedObjectiveDrafts.Clear();
            ObjectiveDraftHistoryByParticipant.Clear();
        }
    }
}
