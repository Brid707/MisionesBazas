
namespace Application.Models
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    public enum MissionEvaluationFailureReason
    {
        None = 0,
        ObjectiveCapturedByWrongSeat = 1,
        MultipleOrderedTokensInSameTrick = 2,
        MultipleArrowTokensInSameTrick = 3,
        OmegaSimultaneousCompletion = 4,
        PrecedingOrderTokenNotCompleted = 5,
        PrecedingArrowTokenNotCompleted = 6,
        OmegaObjectiveNotCompletedLast = 7,
        ObjectivesIncompleteAtMissionEnd = 8,
        Mission48OmegaNotInLastTrick = 9,
        Mission48PendingNonOmegaBeforeLastTrick = 10,
        SpecialMissionConstraint = 11,
        AllParticipantsWonAtLeastOneTrick = 12,
        NormalOneDidNotWinTrick = 13,
        SpecialCardLostTrick = 14,
        SpecialCardsDidNotWinAllRequiredTricks = 15,
        NormalNineWonTrick = 16,
        InsufficientNormalOneWinningTricks = 17,
        WonTrickDifferenceExceeded = 18,
        SingleTrickWinnerUnassigned = 19,
        SelectedParticipantWonWithSpecialCard = 20,
        SelectedParticipantWonMultipleTricks = 21,
        SelectedParticipantDidNotWinExactlyOneTrick = 22,
        CaptainDidNotWinFirstTrick = 23,
        CaptainDidNotWinLastTrick = 24,
        FirstAndLastWinnerUnassigned = 25,
        FirstTrickWonByWrongParticipant = 26,
        FirstTrickWonWithSpecialCard = 27,
        IntermediateTrickWonBySelectedParticipant = 28,
        LastTrickWonByWrongParticipant = 29,
        LastTrickWonWithSpecialCard = 30,
        SpecialCardWinningOrderViolated = 31,
        HeartNineOwnerUnidentified = 32,
        HeartCapturedByWrongParticipant = 33,
        HeartCardsNotAllCaptured = 34,
        TrickDistributionUnassigned = 35,
        InitialTricksWonByWrongParticipant = 36,
        InitialTrickWinnerWonExtra = 37,
        FinalTrickWinnerWonEarly = 38,
        FinalTrickWonByWrongParticipant = 39,
        RemainingParticipantWonNoTrick = 40
    }
}
