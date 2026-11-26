
namespace Application.Models
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    public enum MissionAttemptEvaluationStatus
    {
        NotEvaluated = 0,
        InProgress = 1,
        Succeeded = 2,
        Failed = 3
    }
}
