using System;
using System.Collections.Generic;
using Gameplay;

namespace Application.Models
{
    /// <summary>Owns server-only hands and decisions; never serialize or return this object.</summary>
    public sealed class MatchState
    {
        public Guid LobbyInstanceId { get; set; }
        public Guid MatchId { get; } = Guid.NewGuid();
        public long MatchStateVersion { get; set; } = 1;
        public int[] ParticipantUserIds { get; set; }
        public List<int>[] PlayerHandCardIdsBySeat { get; set; }
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
    }
}
