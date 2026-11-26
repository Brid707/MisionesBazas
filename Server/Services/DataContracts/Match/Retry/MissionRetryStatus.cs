using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes automatic retry presentation without exposing server timing internals.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionRetryStatus
    {
        [EnumMember] Inactive = 0,
        [EnumMember] WaitingForParticipants = 1,
        [EnumMember] CountingDown = 2,
        [EnumMember] Preparing = 3,
        [EnumMember] PreparationFailed = 4,
        [EnumMember] AttemptLimitReached = 5
    }
}
