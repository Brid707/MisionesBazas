using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    [DataContract]
    public sealed class MissionConditionProgressSnapshot
    {
        [DataMember(Order = 1)]
        public int TricksWonWithNormalOneCount { get; set; }

        [DataMember(Order = 2)]
        public int[] SpecialWinningCardIds { get; set; }
    }
}
