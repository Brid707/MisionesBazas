namespace TrickTakingMissions.Rules.Enums
{
    /// <summary>
    /// Identifies the resolution action taken after the 60-second reconnection grace period expires.
    /// </summary>
    public enum DisconnectionResolutionOption
    {
        None = 0,
        RestartMissionWithThreePlayers = 1,
        ReturnToLobby = 2
    }
}
