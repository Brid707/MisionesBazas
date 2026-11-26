using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Describes one public, server-confirmed card play.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MatchCardPlay
    {
        [DataMember(Order = 1)]
        public int PlayerUserId { get; set; }

        [DataMember(Order = 2)]
        public int CardId { get; set; }
    }
}
