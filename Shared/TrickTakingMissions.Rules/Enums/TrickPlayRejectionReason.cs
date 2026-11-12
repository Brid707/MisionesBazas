namespace TrickTakingMissions.Rules.Enums
{
    /// <summary>
    /// Describes why an attempted card play in a trick was rejected by the rules engine.
    /// </summary>
    public enum TrickPlayRejectionReason
    {
        None = 0,
        NotPlayerTurn = 1,
        CardNotInHand = 2,
        MustFollowLeadSuit = 3,
        TrickAlreadyCompleted = 4,
        InvalidPlayContext = 5
    }
}
