using System;

namespace Application.Models
{
    /// <summary>Transfers authorized mission preparation data without private hands.</summary>
    public sealed class MissionConditionProgressSnapshot
    {
        public int TricksWonWithNormalOneCount { get; set; }

        public int[] SpecialWinningCardIds { get; set; }
        public int CapturedHeartCardCount { get; set; }
    }
}
