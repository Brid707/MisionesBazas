namespace Domain
{
    /// <summary>Identifies the highest prohibited-content category detected in a chat message.</summary>
    public enum ChatInfractionCategory
    {
        None = 0,
        Profanity = 1,
        Threat = 2
    }
}
