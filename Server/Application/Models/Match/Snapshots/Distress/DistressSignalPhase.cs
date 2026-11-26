
namespace Application.Models
{
    /// <summary>
    /// Identifies the public sequential step of the distress signal workflow over the match channel.
    /// </summary>
    public enum DistressSignalPhase
    {
        None = 0,
        VotingToUse = 1,
        VotingDirection = 2,
        SelectingCard = 3,
        Completed = 4
    }
}
