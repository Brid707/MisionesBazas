namespace Domain
{
    /// <summary>
    /// Identifies the sequential lifecycle phase of an active mission attempt.
    /// </summary>
    public enum MissionAttemptPhase
    {
        RoleAndPreparation = 0,
        ObjectiveDrafting = 1,
        DistressSignal = 2,
        PlayingTricks = 3,
        PausedByDisconnection = 4,
        Finished = 5
    }
}
