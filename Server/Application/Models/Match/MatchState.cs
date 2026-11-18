using System;
using System.Collections.Generic;
using Gameplay;
namespace Application.Models
{
    /// <summary>Owns server-only hands and decisions; never serialize or return this object.</summary>
    public sealed partial class MatchState
    {
        public Domain.MissionAttemptState MissionAttempt { get; private set; }
        public Domain.MissionEvaluationResult LastMissionEvaluation { get; private set; }

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

        public void CommitObjectiveDraft(Domain.MissionAttemptState missionAttempt)
        {
            SetMissionAttempt(missionAttempt);
            MatchStateVersion++;
        }

        internal void CommitCompletedTrick(CompletedTrickResolution completedTrick)
        {
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
