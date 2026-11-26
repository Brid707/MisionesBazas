using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Carries public objective marker identity without exposing domain rule types.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public enum MissionObjectiveToken
    {
        [EnumMember]
        None = 0,

        [EnumMember]
        OrderOne = 1,

        [EnumMember]
        OrderTwo = 2,

        [EnumMember]
        OrderThree = 3,

        [EnumMember]
        OrderFour = 4,

        [EnumMember]
        OrderFive = 5,

        [EnumMember]
        ArrowOne = 6,

        [EnumMember]
        ArrowTwo = 7,

        [EnumMember]
        ArrowThree = 8,

        [EnumMember]
        ArrowFour = 9,

        [EnumMember]
        Omega = 10
    }
}
