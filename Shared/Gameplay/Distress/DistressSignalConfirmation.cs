using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Confirms that a distress signal action was accepted and reports the committed match state version.
    /// </summary>
    [DataContract]
    public sealed class DistressSignalConfirmation
    {
        [DataMember(Order = 1)]
        public bool IsExecuted { get; set; }

        [DataMember(Order = 2)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
