namespace Domain
{
    /// <summary>
    /// Identifies the active sequential phase of the distress signal workflow.
    /// </summary>
    public enum DistressSignalStep
    {
        None = 0,
        VotingToUse = 1,
        VotingDirection = 2,
        SelectingCard = 3,
        Completed = 4
    }
}
