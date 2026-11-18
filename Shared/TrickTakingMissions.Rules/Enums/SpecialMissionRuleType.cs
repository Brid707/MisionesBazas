namespace TrickTakingMissions.Rules.Enums
{
    /// <summary>
    /// Identifies the special gameplay rule or victory condition active for a mission.
    /// </summary>
    public enum SpecialMissionRuleType
    {
        None = 0,
        M05_OnePlayerWinsNoTricks = 5,
        M09_WinTrickWithNumberOne = 9,
        M11_CaptainSilencesOnePlayer = 11,
        M13_WinTrickWithEverySpecialCard = 13,
        M16_NoTrickWonWithNumberNine = 16,
        M17_NoTrickWonWithNumberNine = 17,
        M20_CaptainAssignsAllObjectivesToOnePlayer = 20,
        M26_TwoTricksWonWithNumberOne = 26,
        M27_CaptainAssignsAllObjectivesToOnePlayer = 27,
        M29_MaxTrickDifferenceTwo = 29,
        M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard = 33,
        M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo = 34,
        M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard = 41,
        M44_SpecialCardsWinTricksInAscendingOrder = 44,
        M46_SeatLeftOfHeartNineWinsAllHearts = 46,
        M48_OmegaObjectiveCompletedInLastTrick = 48,
        M50_SplitTrickWinsDistribution = 50
    }
}
