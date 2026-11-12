namespace Domain
{
    /// <summary>
    /// Centralizes the supported player count range for an active match.
    /// </summary>
    internal static class MatchPlayerCountRules
    {
        internal static bool IsPlayerCountSupported(int playerCount)
        {
            return playerCount >= LobbyRoomRules.MinimumPlayerLimit
                && playerCount <= LobbyRoomRules.MaximumPlayerLimit;
        }
    }
}
