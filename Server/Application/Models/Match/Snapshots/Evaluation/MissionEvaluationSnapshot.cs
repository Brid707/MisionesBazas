
namespace Application.Models
{
    /// <summary>Describes public attempt progress without private hands or hidden objective identities.</summary>
    public sealed class MissionEvaluationSnapshot
    {
        public int MissionAttemptId { get; set; }

        public int LastEvaluatedTrickNumber { get; set; }

        public MissionAttemptEvaluationStatus MissionAttemptStatus { get; set; }

        public MissionEvaluationFailureReason MissionFailureReason { get; set; }
    }
}
