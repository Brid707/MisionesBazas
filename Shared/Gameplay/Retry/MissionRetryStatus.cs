using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Describes automatic retry presentation without exposing server timing internals.</summary>
    [DataContract]
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
