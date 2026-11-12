using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Returns a stable access failure code without session credentials or private card state.</summary>
    [DataContract]
    public sealed class MatchAccessFault
    {
        [DataMember(Order = 1)]
        public string FailureCode { get; set; }
    }
}
