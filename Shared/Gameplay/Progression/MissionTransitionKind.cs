using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Describes public mission progression without server-owned game data.</summary>
    [DataContract]
    public enum MissionTransitionKind
    {
        [EnumMember] None = 0,
        [EnumMember] RetryCurrentMission = 1,
        [EnumMember] AdvanceToNextMission = 2
    }
}
