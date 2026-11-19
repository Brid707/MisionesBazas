using System;
using System.Collections.Generic;
using System.Linq;

namespace Application.Models
{
    public sealed partial class MatchState
    {
        public MissionTransitionScheduleStatus MissionTransitionStatus { get; private set; }

        public MissionTransitionAction TransitionAction { get; private set; }

        public int DestinationMissionNumber { get; private set; }

        public bool HasStartedTransitionExecution { get; private set; }

        public Guid MissionTransitionScheduleId { get; private set; }

        public long MissionTransitionDeadlineMilliseconds { get; private set; }

        public long MissionTransitionConnectionVersion { get; private set; }

        public int[] MissingTransitionParticipantUserIds { get; private set; } = Array.Empty<int>();

        internal void InitializePreparedMissionAttempt(PreparedMissionAttempt preparedAttempt)
        {
            if (MissionAttempt != null)
            {
                throw new InvalidOperationException(nameof(MissionAttempt));
            }
            ApplyPreparedMissionAttempt(preparedAttempt);
        }

        internal void ConfigureMissionTransition(MissionTransitionAction transitionAction, int destinationMissionNumber)
        {
            TransitionAction = transitionAction;
            DestinationMissionNumber = destinationMissionNumber;
        }

        internal void SetMissionTransitionSchedule(MissionTransitionScheduleStatus status,
            MatchParticipantPresence presence,
            long deadlineMilliseconds)
        {
            MissionTransitionStatus = status;
            HasStartedTransitionExecution = false;
            MissionTransitionScheduleId = Guid.NewGuid();
            MissionTransitionConnectionVersion = presence.ConnectionVersion;
            MissingTransitionParticipantUserIds = (int[])presence.MissingParticipantUserIds.Clone();
            MissionTransitionDeadlineMilliseconds = deadlineMilliseconds;
            MatchStateVersion++;
        }

        internal void ReserveMissionTransitionPreparation()
        {
            MissionTransitionStatus = MissionTransitionScheduleStatus.Preparing;
            MatchStateVersion++;
        }

        internal void MarkTransitionExecutionStarted()
        {
            HasStartedTransitionExecution = true;
        }

        internal void CommitScheduledMissionTransition(PreparedMissionAttempt preparedAttempt)
        {
            ApplyPreparedMissionAttempt(preparedAttempt);
            MatchStateVersion++;
        }

        private void ApplyPreparedMissionAttempt(PreparedMissionAttempt preparedAttempt)
        {
            bool isInitialAttempt = MissionAttempt == null;
            MissionAttempt = preparedAttempt.MissionAttempt;
            ResetSpecialPreparationState(isInitialAttempt);
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
            TransitionAction = MissionTransitionAction.None;
            DestinationMissionNumber = MissionAttempt.MissionNumber;
            MissionTransitionStatus = MissionTransitionScheduleStatus.Inactive;
            HasStartedTransitionExecution = false;
            MissionTransitionScheduleId = Guid.Empty;
            MissionTransitionDeadlineMilliseconds = 0;
            MissionTransitionConnectionVersion = 0;
            MissingTransitionParticipantUserIds = Array.Empty<int>();
            LastCompletedTrickCardPlays = Array.Empty<Gameplay.MatchCardPlay>();
            CurrentTrickCardPlays.Clear();
            CapturedCardPlays.Clear();
            ProcessedCardPlayDecisionsBySubmissionId.Clear();
            RadioCommunicationsByParticipantUserId.Clear();
            ProcessedRadioCommunicationsBySubmissionId.Clear();
            ProcessedObjectiveDrafts.Clear();
            ObjectiveDraftHistoryByParticipant.Clear();
        }
    }
}
