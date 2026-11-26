using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies draft operations; an unspecified action is rejected.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
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
