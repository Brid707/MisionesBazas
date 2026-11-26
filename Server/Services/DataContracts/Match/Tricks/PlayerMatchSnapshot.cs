using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Contains only the requesting participant hand and detached public table information.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class PlayerMatchSnapshot
    {
        [DataMember(Order = 1)]
        public System.Guid MatchId { get; set; }

        [DataMember(Order = 2)]
        public long MatchStateVersion { get; set; }

        [DataMember(Order = 3)]
        public int[] OwnHandCardIds { get; set; }

        [DataMember(Order = 4)]
        public int[] ParticipantUserIds { get; set; }

        [DataMember(Order = 5)]
        public int[] RemainingHandCardCounts { get; set; }

        [DataMember(Order = 6)]
        public int CurrentTurnPlayerUserId { get; set; }

        [DataMember(Order = 7)]
        public int MissionCaptainUserId { get; set; }

        [DataMember(Order = 8)]
        public int CurrentTrickNumber { get; set; }

        [DataMember(Order = 9)]
        public int MaximumMissionTrickCount { get; set; }

        [DataMember(Order = 10)]
        public bool IsDealCompleted { get; set; }

        [DataMember(Order = 11)]
        public MatchCardPlay[] CurrentTrickCardPlays { get; set; }

        [DataMember(Order = 12)]
        public MatchCardPlay[] LastCompletedTrickCardPlays { get; set; }

        [DataMember(Order = 13)]
        public int LastTrickWinnerUserId { get; set; }

        [DataMember(Order = 15)]
        public PlayerMissionPreparationSnapshot MissionPreparation { get; set; }

        [DataMember(Order = 14)]
        public PlayerCapturedCardsSnapshot[] CapturedCardsByPlayer { get; set; }
        [DataMember(Order = 16)]
        public MissionEvaluationSnapshot MissionEvaluation { get; set; }
        [DataMember(Order = 17)]
        public MissionRetrySnapshot MissionRetry { get; set; }

        [DataMember(Order = 18)]
        public MissionTransitionSnapshot MissionTransition { get; set; }

        [DataMember(Order = 19)]
        public PlayerRadioCommunicationSnapshot[] RadioCommunications { get; set; }

        [DataMember(Order = 20)]
        public RadioCommunicationMode RadioMode { get; set; }
        [DataMember(Order = 21)]
        public MissionConditionProgressSnapshot MissionConditionProgress { get; set; }
        [DataMember(Order = 22)]
        public RadioAvailabilitySnapshot OwnRadioAvailability { get; set; }
        [DataMember(Order = 23)]
        public DistressSignalSnapshot DistressSignal { get; set; }
    }
}
