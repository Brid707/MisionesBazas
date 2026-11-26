using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Returns a stable access failure code without session credentials or private card state.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MatchAccessFault
    {
        [DataMember(Order = 1)]
        public string FailureCode { get; set; }
    }
}
