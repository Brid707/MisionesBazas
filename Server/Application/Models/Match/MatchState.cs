using System;
using System.Collections.Generic;
using Gameplay;
namespace Application.Models
{
    /// <summary>Owns server-only hands and decisions; never serialize or return this object.</summary>
    public sealed class MatchState
    {
        public Domain.MissionAttemptState MissionAttempt { get; private set; }
        public Guid CurrentObjectiveDraftSubmissionId { get; private set; }
        public Dictionary<int, Queue<Guid>> ObjectiveDraftHistoryByParticipant { get; } =
            new Dictionary<int, Queue<Guid>>();
        public Dictionary<Guid, int> ObjectiveCardIdsByObjectiveId { get; } = new Dictionary<Guid, int>();
        public Dictionary<Guid, ProcessedObjectiveDraft> ProcessedObjectiveDrafts { get; } =
            new Dictionary<Guid, ProcessedObjectiveDraft>();
        public Dictionary<int, ObjectiveDraftRequestBudget> ObjectiveDraftBudgetsByParticipant { get; } =
            new Dictionary<int, ObjectiveDraftRequestBudget>();

        public Guid LobbyInstanceId { get; set; }
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

        public void InitializeMissionAttempt(Domain.MissionAttemptState missionAttempt)
        {
            if (MissionAttempt != null)
            {
                throw new InvalidOperationException(nameof(MissionAttempt));
            }
            SetMissionAttempt(missionAttempt);
        }

        public void CommitObjectiveDraft(Domain.MissionAttemptState missionAttempt)
        {
            SetMissionAttempt(missionAttempt);
            MatchStateVersion++;
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
