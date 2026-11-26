using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Confirms that a distress signal action was accepted and reports the committed match state version.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class DistressSignalConfirmation
    {
        [DataMember(Order = 1)]
        public bool IsExecuted { get; set; }

        [DataMember(Order = 2)]
        public long CommittedMatchStateVersion { get; set; }
    }
}
