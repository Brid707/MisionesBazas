using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Public, detached record of the tricks and cards a participant has won in the current deal.
    /// </summary>
    [DataContract]
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
