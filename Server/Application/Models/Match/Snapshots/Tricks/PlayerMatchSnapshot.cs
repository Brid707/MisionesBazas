
namespace Application.Models
{
    /// <summary>
    /// Contains only the requesting participant hand and detached public table information.
    /// </summary>
    public sealed class PlayerMatchSnapshot
    {
        public System.Guid MatchId { get; set; }

        public long MatchStateVersion { get; set; }

        public int[] OwnHandCardIds { get; set; }

        public int[] ParticipantUserIds { get; set; }

        public int[] RemainingHandCardCounts { get; set; }

        public int CurrentTurnPlayerUserId { get; set; }

        public int MissionCaptainUserId { get; set; }

        public int CurrentTrickNumber { get; set; }

        public int MaximumMissionTrickCount { get; set; }

        public bool IsDealCompleted { get; set; }

        public MatchCardPlay[] CurrentTrickCardPlays { get; set; }

        public MatchCardPlay[] LastCompletedTrickCardPlays { get; set; }

        public int LastTrickWinnerUserId { get; set; }

        public PlayerMissionPreparationSnapshot MissionPreparation { get; set; }

        public PlayerCapturedCardsSnapshot[] CapturedCardsByPlayer { get; set; }
        public MissionEvaluationSnapshot MissionEvaluation { get; set; }
        public MissionRetrySnapshot MissionRetry { get; set; }

        public MissionTransitionSnapshot MissionTransition { get; set; }

        public PlayerRadioCommunicationSnapshot[] RadioCommunications { get; set; }

        public RadioCommunicationMode RadioMode { get; set; }
        public MissionConditionProgressSnapshot MissionConditionProgress { get; set; }
        public RadioAvailabilitySnapshot OwnRadioAvailability { get; set; }
        public DistressSignalSnapshot DistressSignal { get; set; }
    }
}
