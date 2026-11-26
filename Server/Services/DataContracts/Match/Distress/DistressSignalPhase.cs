using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Identifies the public sequential step of the distress signal workflow over the match channel.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum DistressSignalPhase
    {
        [EnumMember] None = 0,
        [EnumMember] VotingToUse = 1,
        [EnumMember] VotingDirection = 2,
        [EnumMember] SelectingCard = 3,
        [EnumMember] Completed = 4
    }
}
