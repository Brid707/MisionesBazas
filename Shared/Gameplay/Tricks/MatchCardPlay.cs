using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Describes one public, server-confirmed card play.
    /// </summary>
    [DataContract]
    public sealed class MatchCardPlay
    {
        [DataMember(Order = 1)]
        public int PlayerUserId { get; set; }

        [DataMember(Order = 2)]
        public int CardId { get; set; }
    }
}
