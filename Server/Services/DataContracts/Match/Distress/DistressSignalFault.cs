using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Transfers distress signal business validation rejections on the existing match channel.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class DistressSignalFault
    {
        [DataMember(Order = 1)]
        public DistressSignalFailureReason FailureReason { get; set; }
    }
}
