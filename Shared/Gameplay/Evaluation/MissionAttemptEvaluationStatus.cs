using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    [DataContract]
    public enum MissionAttemptEvaluationStatus
    {
        [EnumMember] NotEvaluated = 0,
        [EnumMember] InProgress = 1,
        [EnumMember] Succeeded = 2,
        [EnumMember] Failed = 3
    }
}
