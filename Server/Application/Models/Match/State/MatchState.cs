using System;
using System.Collections.Generic;
using System.Linq;
using Gameplay;
using TrickTakingMissions.Rules.Enums;

namespace Application.Models
{
    /// <summary>Owns server-only hands and decisions; never serialize or return this object.</summary>
    public sealed class MatchState
    {
        public Domain.MissionAttemptState MissionAttempt { get; private set; }
        public Domain.MissionEvaluationResult LastMissionEvaluation { get; private set; }

        public MissionTrickStatistics TrickStatistics { get; private set; } = new MissionTrickStatistics();

        public int LastEvaluatedTrickNumber { get; private set; }

        public Guid CurrentObjectiveDraftSubmissionId { get; private set; }
        public Dictionary<int, Queue<Guid>> ObjectiveDraftHistoryByParticipant { get; } =
            new Dictionary<int, Queue<Guid>>();
        public Dictionary<Guid, int> ObjectiveCardIdsByObjectiveId { get; private set; } = new Dictionary<Guid, int>();
        public Dictionary<Guid, ProcessedObjectiveDraft> ProcessedObjectiveDrafts { get; } =
            new Dictionary<Guid, ProcessedObjectiveDraft>();
        public Dictionary<int, MatchActionRequestBudget> ObjectiveDraftBudgetsByParticipant { get; } =
            new Dictionary<int, MatchActionRequestBudget>();

        public Guid LobbyInstanceId { get; set; }
        public int TargetMissionCount { get; init; }
        public Guid MatchId { get; } = Guid.NewGuid();
        public long MatchStateVersion { get; set; } = 1;
        public int[] ParticipantUserIds { get; set; }
        public List<int>[] PlayerHandCardIdsBySeat { get; set; }
        public List<int>[] WonCardIdsBySeat { get; set; }
        public int[] WonTrickCountsBySeat { get; set; }
        public int CurrentTurnPlayerSeat { get; set; }
        public int MissionCaptainSeat { get; set; }
        public int CurrentTrickNumber { get; set; } = 1;
        public int MaximumMissionTrickCount { get; set; }
        public bool IsDealCompleted { get; set; }
        public List<MatchCardPlay> CurrentTrickCardPlays { get; } = new List<MatchCardPlay>();
        public MatchCardPlay[] LastCompletedTrickCardPlays { get; set; } = new MatchCardPlay[0];
        public int LastTrickWinnerUserId { get; set; }
        public List<MatchCardPlay> CapturedCardPlays { get; } = new List<MatchCardPlay>();
        public Dictionary<Guid, ProcessedCardPlay> ProcessedCardPlayDecisionsBySubmissionId { get; } =
            new Dictionary<Guid, ProcessedCardPlay>();
        public Dictionary<byte, int> PendingDistressPassCardIdsBySeat { get; } =
            new Dictionary<byte, int>();
        public Dictionary<byte, TrickTakingMissions.Rules.Enums.PassDirection>
            PendingDistressDirectionsBySeat { get; } =
            new Dictionary<byte, TrickTakingMissions.Rules.Enums.PassDirection>();
        public TrickTakingMissions.Rules.Enums.DistressSignalStep DistressStep { get; set; }
        public HashSet<byte> DistressUsageYesVotesBySeat { get; } =
            new HashSet<byte>();
        public Dictionary<byte, TrickTakingMissions.Rules.Enums.PassDirection>
            DistressDirectionVotesBySeat { get; } =
            new Dictionary<byte, TrickTakingMissions.Rules.Enums.PassDirection>();
        public int? DistressInitiatorUserId { get; set; }
        public TrickTakingMissions.Rules.Enums.PassDirection? DistressAgreedDirection { get; set; }
        public bool HasDistressBeenRejected { get; set; }
        public bool HasAppliedDistressPenaltyInCurrentMission { get; set; }

        public MatchRadioCommunicationState RadioState { get; } = new MatchRadioCommunicationState();
        public MatchSpecialPreparationState SpecialPreparationState { get; } = new MatchSpecialPreparationState();
        public MatchTransitionState TransitionState { get; } = new MatchTransitionState();

        // Radio State Passthroughs
        public Dictionary<int, CommittedRadioCommunication> RadioCommunicationsByParticipantUserId =>
            RadioState.RadioCommunicationsByParticipantUserId;
        public Dictionary<Guid, CommittedRadioCommunication> ProcessedRadioCommunicationsBySubmissionId =>
            RadioState.ProcessedRadioCommunicationsBySubmissionId;
        public Dictionary<int, MatchActionRequestBudget> RadioBudgetsByParticipantUserId =>
            RadioState.RadioBudgetsByParticipantUserId;

        internal RadioCommunicationCommit CommitRadioCommunication(CommittedRadioCommunication communication)
        {
            MatchStateVersion++;
            return RadioState.CommitRadioCommunication(communication, MatchStateVersion);
        }

        // Special Preparation Passthroughs
        public Guid MissionPreparationStageId => SpecialPreparationState.MissionPreparationStageId;
        public long PreparationStageOpenedVersion => SpecialPreparationState.PreparationStageOpenedVersion;
        public IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> BlindResponsesBySeat =>
            SpecialPreparationState.BlindResponsesBySeat;
        public Dictionary<Guid, ProcessedMissionPreparation> ProcessedPreparationSubmissions =>
            SpecialPreparationState.ProcessedPreparationSubmissions;
        public Dictionary<int, MatchActionRequestBudget> PreparationBudgetsByParticipant =>
            SpecialPreparationState.PreparationBudgetsByParticipant;

        internal MissionPreparationCommit CommitSpecialPreparation(MissionPreparationRequest request,
            int participantUserId, SpecialPreparationChange preparedChange)
        {
            long committedVersion = MatchStateVersion + 1;
            MissionPreparationCommit commit = SpecialPreparationState.CommitSpecialPreparation(
                request, participantUserId, preparedChange, committedVersion);
            MissionAttempt = preparedChange.UpdatedAttempt;
            MatchStateVersion = commit.CommittedMatchStateVersion;
            return commit;
        }

        private void ResetSpecialPreparationState(bool isInitialAttempt)
        {
            TrickStatistics = new MissionTrickStatistics();
            SpecialPreparationState.ResetSpecialPreparationState(MatchStateVersion, isInitialAttempt);
        }

        // Transition Passthroughs
        public MissionTransitionScheduleStatus MissionTransitionStatus => TransitionState.MissionTransitionStatus;
        public MissionTransitionAction TransitionAction => TransitionState.TransitionAction;
        public int DestinationMissionNumber => TransitionState.DestinationMissionNumber;
        public bool HasStartedTransitionExecution => TransitionState.HasStartedTransitionExecution;
        public Guid MissionTransitionScheduleId => TransitionState.MissionTransitionScheduleId;
        public long MissionTransitionDeadlineMilliseconds => TransitionState.MissionTransitionDeadlineMilliseconds;
        public long MissionTransitionConnectionVersion => TransitionState.MissionTransitionConnectionVersion;
        public int[] MissingTransitionParticipantUserIds => TransitionState.MissingTransitionParticipantUserIds;

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
            TransitionState.ConfigureMissionTransition(transitionAction, destinationMissionNumber);
        }

        internal void SetMissionTransitionSchedule(MissionTransitionScheduleStatus status,
            MatchParticipantPresence presence,
            long deadlineMilliseconds)
        {
            TransitionState.SetMissionTransitionSchedule(status, presence, deadlineMilliseconds);
            MatchStateVersion++;
        }

        internal void ReserveMissionTransitionPreparation()
        {
            TransitionState.ReserveMissionTransitionPreparation();
            MatchStateVersion++;
        }

        internal void MarkTransitionExecutionStarted()
        {
            TransitionState.MarkTransitionExecutionStarted();
        }

        internal void CommitScheduledMissionTransition(PreparedMissionAttempt preparedAttempt)
        {
            ApplyPreparedMissionAttempt(preparedAttempt);
            MatchStateVersion++;
        }

        private void ApplyPreparedMissionAttempt(PreparedMissionAttempt preparedAttempt)
        {
            bool isInitialAttempt = MissionAttempt == null;
            bool isSameMissionRetry = !isInitialAttempt &&
                MissionAttempt.MissionNumber == preparedAttempt.MissionAttempt.MissionNumber;
            if (!isSameMissionRetry)
            {
                HasAppliedDistressPenaltyInCurrentMission = false;
            }
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
            TransitionState.Reset(MissionAttempt.MissionNumber);
            LastCompletedTrickCardPlays = Array.Empty<MatchCardPlay>();
            CurrentTrickCardPlays.Clear();
            CapturedCardPlays.Clear();
            ProcessedCardPlayDecisionsBySubmissionId.Clear();
            RadioState.Clear();
            ProcessedObjectiveDrafts.Clear();
            ObjectiveDraftHistoryByParticipant.Clear();
            ResetDistressState();
            HasDistressBeenRejected = false;
        }

        public void ResetDistressState()
        {
            DistressStep = TrickTakingMissions.Rules.Enums.DistressSignalStep.None;
            PendingDistressPassCardIdsBySeat.Clear();
            PendingDistressDirectionsBySeat.Clear();
            DistressUsageYesVotesBySeat.Clear();
            DistressDirectionVotesBySeat.Clear();
            DistressInitiatorUserId = null;
            DistressAgreedDirection = null;
        }

        public void CommitMissionAttemptUpdate(Domain.MissionAttemptState missionAttempt)
        {
            if (missionAttempt == null || missionAttempt.PlayerCount != ParticipantUserIds.Length)
            {
                throw new ArgumentException(nameof(missionAttempt));
            }
            MissionAttempt = missionAttempt;
            MatchStateVersion++;
        }

        public void CommitObjectiveDraft(Domain.MissionAttemptState missionAttempt)
        {
            SetMissionAttempt(missionAttempt);
            MatchStateVersion++;
        }

        internal void CommitCompletedTrick(CompletedTrickResolution completedTrick)
        {
            TrickStatistics = completedTrick.TrickStatistics;
            CurrentTurnPlayerSeat = completedTrick.WinningParticipantSeat;
            LastTrickWinnerUserId = ParticipantUserIds[completedTrick.WinningParticipantSeat];
            WonTrickCountsBySeat[completedTrick.WinningParticipantSeat]++;
            WonCardIdsBySeat[completedTrick.WinningParticipantSeat].AddRange(
                System.Linq.Enumerable.Select(completedTrick.CompletedTrickCardPlays, play => play.CardId));
            LastCompletedTrickCardPlays = completedTrick.CompletedTrickCardPlays;
            CapturedCardPlays.AddRange(completedTrick.CompletedTrickCardPlays);
            CurrentTrickCardPlays.Clear();
            MissionAttempt = completedTrick.UpdatedMissionAttempt;
            LastMissionEvaluation = completedTrick.MissionEvaluation;
            LastEvaluatedTrickNumber = completedTrick.CompletedTrickNumber;
            IsDealCompleted = completedTrick.CompletedTrickNumber == MaximumMissionTrickCount;
            if (!IsDealCompleted && MissionAttempt.Status ==
                TrickTakingMissions.Rules.Enums.MissionAttemptStatus.InProgress)
            {
                CurrentTrickNumber++;
            }
        }

        private void SetMissionAttempt(Domain.MissionAttemptState missionAttempt)
        {
            if (missionAttempt == null || missionAttempt.PlayerCount != ParticipantUserIds.Length)
            {
                throw new ArgumentException(nameof(missionAttempt));
            }
            MissionAttempt = missionAttempt;
            CurrentObjectiveDraftSubmissionId = Guid.NewGuid();
        }
    }
}
