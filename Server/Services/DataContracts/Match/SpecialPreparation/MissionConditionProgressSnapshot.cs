using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionConditionProgressSnapshot
    {
        [DataMember(Order = 1)]
        public int TricksWonWithNormalOneCount { get; set; }

        [DataMember(Order = 2)]
        public int[] SpecialWinningCardIds { get; set; }
        [DataMember(Order = 3)]
        public int CapturedHeartCardCount { get; set; }
    }
}
