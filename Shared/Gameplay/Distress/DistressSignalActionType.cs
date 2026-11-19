using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Identifies an action taken by a participant during the distress signal workflow.
    /// </summary>
    [DataContract]
    public enum DistressSignalActionType
    {
        [EnumMember] None = 0,
        [EnumMember] ProposeUsage = 1,
        [EnumMember] VoteUsage = 2,
        [EnumMember] VoteDirection = 3,
        [EnumMember] SubmitPassCard = 4,
        [EnumMember] CancelProposal = 5
    }
}
