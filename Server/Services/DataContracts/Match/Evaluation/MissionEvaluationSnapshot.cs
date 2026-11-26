using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Describes public attempt progress without private hands or hidden objective identities.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionEvaluationSnapshot
    {
        [DataMember(Order = 1)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 2)]
        public int LastEvaluatedTrickNumber { get; set; }

        [DataMember(Order = 3)]
        public MissionAttemptEvaluationStatus MissionAttemptStatus { get; set; }

        [DataMember(Order = 4)]
        public MissionEvaluationFailureReason MissionFailureReason { get; set; }
    }
}
