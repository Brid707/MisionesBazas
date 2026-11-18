using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies draft operations; an unspecified action is rejected.</summary>
    [DataContract]
    public enum MissionObjectiveDraftAction
    {
        [EnumMember]
        Unspecified = 0,

        [EnumMember]
        SelectObjective = 1,

        [EnumMember]
        Pass = 2
    }
}
