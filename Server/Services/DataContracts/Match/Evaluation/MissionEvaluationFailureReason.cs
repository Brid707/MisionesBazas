using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionEvaluationFailureReason
    {
        [EnumMember] None = 0,
        [EnumMember] ObjectiveCapturedByWrongSeat = 1,
        [EnumMember] MultipleOrderedTokensInSameTrick = 2,
        [EnumMember] MultipleArrowTokensInSameTrick = 3,
        [EnumMember] OmegaSimultaneousCompletion = 4,
        [EnumMember] PrecedingOrderTokenNotCompleted = 5,
        [EnumMember] PrecedingArrowTokenNotCompleted = 6,
        [EnumMember] OmegaObjectiveNotCompletedLast = 7,
        [EnumMember] ObjectivesIncompleteAtMissionEnd = 8,
        [EnumMember] Mission48OmegaNotInLastTrick = 9,
        [EnumMember] Mission48PendingNonOmegaBeforeLastTrick = 10,
        [EnumMember] SpecialMissionConstraint = 11,
        [EnumMember] AllParticipantsWonAtLeastOneTrick = 12,
        [EnumMember] NormalOneDidNotWinTrick = 13,
        [EnumMember] SpecialCardLostTrick = 14,
        [EnumMember] SpecialCardsDidNotWinAllRequiredTricks = 15,
        [EnumMember] NormalNineWonTrick = 16,
        [EnumMember] InsufficientNormalOneWinningTricks = 17,
        [EnumMember] WonTrickDifferenceExceeded = 18,
        [EnumMember] SingleTrickWinnerUnassigned = 19,
        [EnumMember] SelectedParticipantWonWithSpecialCard = 20,
        [EnumMember] SelectedParticipantWonMultipleTricks = 21,
        [EnumMember] SelectedParticipantDidNotWinExactlyOneTrick = 22,
        [EnumMember] CaptainDidNotWinFirstTrick = 23,
        [EnumMember] CaptainDidNotWinLastTrick = 24,
        [EnumMember] FirstAndLastWinnerUnassigned = 25,
        [EnumMember] FirstTrickWonByWrongParticipant = 26,
        [EnumMember] FirstTrickWonWithSpecialCard = 27,
        [EnumMember] IntermediateTrickWonBySelectedParticipant = 28,
        [EnumMember] LastTrickWonByWrongParticipant = 29,
        [EnumMember] LastTrickWonWithSpecialCard = 30,
        [EnumMember] SpecialCardWinningOrderViolated = 31,
        [EnumMember] HeartNineOwnerUnidentified = 32,
        [EnumMember] HeartCapturedByWrongParticipant = 33,
        [EnumMember] HeartCardsNotAllCaptured = 34,
        [EnumMember] TrickDistributionUnassigned = 35,
        [EnumMember] InitialTricksWonByWrongParticipant = 36,
        [EnumMember] InitialTrickWinnerWonExtra = 37,
        [EnumMember] FinalTrickWinnerWonEarly = 38,
        [EnumMember] FinalTrickWonByWrongParticipant = 39,
        [EnumMember] RemainingParticipantWonNoTrick = 40
    }
}
