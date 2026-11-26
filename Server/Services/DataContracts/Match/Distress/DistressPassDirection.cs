using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Identifies the agreed adjacent seat direction for passing cards during a distress signal over the match channel.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum DistressPassDirection
    {
        [EnumMember] None = 0,
        [EnumMember] Left = 1,
        [EnumMember] Right = 2
    }
}
