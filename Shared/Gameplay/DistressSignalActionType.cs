namespace Gameplay
{
    /// <summary>
    /// Identifies an action taken by a participant during the distress signal workflow.
    /// </summary>
    public enum DistressSignalActionType
    {
        ProposeUsage = 1,
        VoteUsage = 2,
        VoteDirection = 3,
        SubmitPassCard = 4,
        CancelProposal = 5
    }
}
