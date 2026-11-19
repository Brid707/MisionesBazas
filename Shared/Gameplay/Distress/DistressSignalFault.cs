using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Transfers distress signal business validation rejections on the existing match channel.
    /// </summary>
    [DataContract]
    public sealed class DistressSignalFault
    {
        [DataMember(Order = 1)]
        public DistressSignalFailureReason FailureReason { get; set; }
    }
}
