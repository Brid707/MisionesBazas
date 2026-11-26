using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionAttemptEvaluationStatus
    {
        [EnumMember] NotEvaluated = 0,
        [EnumMember] InProgress = 1,
        [EnumMember] Succeeded = 2,
        [EnumMember] Failed = 3
    }
}
