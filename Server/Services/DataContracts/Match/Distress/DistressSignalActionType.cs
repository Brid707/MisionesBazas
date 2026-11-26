using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Identifies an action taken by a participant during the distress signal workflow.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
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
