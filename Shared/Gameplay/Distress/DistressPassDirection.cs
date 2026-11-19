using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Identifies the agreed adjacent seat direction for passing cards during a distress signal over the match channel.
    /// </summary>
    [DataContract]
    public enum DistressPassDirection
    {
        [EnumMember] None = 0,
        [EnumMember] Left = 1,
        [EnumMember] Right = 2
    }
}
