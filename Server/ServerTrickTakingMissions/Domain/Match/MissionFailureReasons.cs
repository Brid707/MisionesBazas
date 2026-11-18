namespace Domain
{
    /// <summary>
    /// Centralizes standardized error reason messages and domain constants for mission attempts.
    /// </summary>
    public static class MissionFailureReasons
    {
        public const string ObjectiveCapturedByWrongSeat = "Objective card was captured by an unassigned player seat.";
        public const string MultipleOrderedTokensInSameTrick = "Multiple sequential order tokens cannot be completed in the same trick.";
        public const string MultipleArrowTokensInSameTrick = "Multiple relative arrow tokens cannot be completed in the same trick.";
        public const string OmegaSimultaneousCompletion = "Omega objective cannot be completed simultaneously with another objective.";
        public const string PrecedingOrderTokenNotCompleted = "An ordered objective must be completed at its exact global completion position.";
        public const string PrecedingArrowTokenNotCompleted = "A relative arrow objective cannot be completed before its preceding token.";
        public const string OmegaObjectiveNotCompletedLast = "Omega objective must be completed last.";
        public const string Mission48OmegaNotInLastTrick = "In Mission 48, Omega objective must be completed in the final trick.";
        public const string Mission48PendingNonOmegaBeforeLastTrick = "All non-Omega objectives must be completed before the final trick in Mission 48.";

        public const string Mission05AllPlayersWonTrick = "Every player has won at least one trick.";
        public const string Mission09NoTrickWonWithOne = "No trick was won with a normal card of value 1.";
        public const string Mission13SpecialCardLostTrick = "A special card was played but did not win the trick.";
        public const string Mission13NotAllSpecialCardsWon = "Not all 4 special cards won a trick.";
        public const string Mission16TrickWonWithNine = "A trick was won with a normal card of value 9.";
        public const string Mission26LessTwoTricksWonWithOne = "Less than two tricks were won with a normal card of value 1.";
        public const string Mission29TrickDifferenceExceeded = "Trick difference between players exceeded the permitted threshold.";
        public const string Mission33RoleUnassigned = "Single trick winner seat role is unassigned.";
        public const string Mission33WonWithSpecialCard = "Selected player won a trick with a special card.";
        public const string Mission33WonMultipleTricks = "Selected player won more than one trick.";
        public const string Mission33DidNotWinExactlyOneTrick = "Selected player did not win exactly one trick.";
        public const string Mission34CaptainDidNotWinFirstTrick = "Captain did not win the first trick.";
        public const string Mission34CaptainDidNotWinLastTrick = "Captain did not win the last trick.";
        public const string Mission41RoleUnassigned = "First and last trick winner seat role is unassigned.";
        public const string Mission41FirstTrickNotWonBySelected = "Designated player did not win the first trick.";
        public const string Mission41FirstTrickWonWithSpecial = "Designated player won the first trick with a special card.";
        public const string Mission41IntermediateTrickWonBySelected = "Designated player won an intermediate trick.";
        public const string Mission41LastTrickNotWonBySelected = "Designated player did not win the last trick.";
        public const string Mission41LastTrickWonWithSpecial = "Designated player won the last trick with a special card.";
        public const string Mission44SpecialOrderViolated = "Special cards must win tricks in strictly ascending hierarchy.";
        public const string Mission44NotAllSpecialCardsWon = "Not all 4 special cards won tricks.";
        public const string Mission46HeartNineUnidentified = "Heart 9 owner seat was not identified.";
        public const string Mission46HeartCapturedByWrongSeat = "A Heart card was captured by a player other than the seat left of Heart 9.";
        public const string Mission50RolesUnassigned = "Roles for Mission 50 are not fully assigned.";
        public const string Mission50FirstFourTricksWrongWinner = "Trick was not won by the player assigned to the first four tricks.";
        public const string Mission50FirstFourWinnerWonExtra = "The player assigned to the first four tricks won an additional trick.";
        public const string Mission50LastTrickWinnerWonEarly = "The player assigned to the last trick won an earlier trick.";
        public const string Mission50LastTrickWrongWinner = "The last trick was not won by the designated player.";
        public const string Mission50RemainingPlayerWonNoTrick = "A remaining player did not win any trick.";
        public const string MissionRemainingTricksInsufficient = "Remaining tricks are insufficient to fulfill pending mission victory conditions.";

        public const string ObjectivesIncompleteAtMissionEnd = "Not all mission objectives were completed before the end of the mission.";
        public const string MissionSuccessMessage = "Mission completed successfully!";

        public const int MaxTrickDifferenceThreshold = 2;
        public const int Mission50InitialTricksCount = 4;
        public const int TotalSpecialCardsCount = 4;
        public const int Mission26RequiredOnesCount = 2;
        public const int ForbiddenTrickWinnerCardNumber = 9;
        public const int RequiredTrickWinnerCardNumber = 1;
    }
}
