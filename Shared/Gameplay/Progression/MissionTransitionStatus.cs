using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Describes public mission progression without server-owned game data.</summary>
    [DataContract]
    public enum MissionTransitionStatus
    {
        [EnumMember] Inactive = 0,
        [EnumMember] WaitingForParticipants = 1,
        [EnumMember] CountingDown = 2,
        [EnumMember] Preparing = 3,
        [EnumMember] PreparationFailed = 4,
        [EnumMember] AttemptLimitReached = 5,
        [EnumMember] CampaignCompleted = 6,
        [EnumMember] MissionUnavailable = 7
    }
}
