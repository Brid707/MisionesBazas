using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Public, detached record of the tricks and cards a participant has won in the current deal.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class PlayerCapturedCardsSnapshot
    {
        [DataMember(Order = 1)]
        public int PlayerUserId { get; set; }

        [DataMember(Order = 2)]
        public int WonTrickCount { get; set; }

        [DataMember(Order = 3)]
        public int[] WonCardIds { get; set; }
    }
}
