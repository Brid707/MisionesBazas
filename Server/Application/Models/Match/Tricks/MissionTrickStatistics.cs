using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Application.Models
{
    /// <summary>Counts winning cards, never all captured cards, within one attempt.</summary>
    public sealed record MissionTrickStatistics
    {
        private const int NormalOneCardNumber = 1;
        public int TricksWonWithNormalOneCount { get; init; }
        public IReadOnlyList<int> SpecialWinningCardIds { get; init; } = Array.Empty<int>();

        internal MissionTrickStatistics IncludeWinner(Card winningCard)
        {
            bool isNormalOne = winningCard.Suit != CardSuit.Special && winningCard.Number == NormalOneCardNumber;
            return new MissionTrickStatistics
            {
                TricksWonWithNormalOneCount = TricksWonWithNormalOneCount + (isNormalOne ? 1 : 0),
                SpecialWinningCardIds = winningCard.Suit == CardSuit.Special
                    ? SpecialWinningCardIds.Concat(new[] { winningCard.IdCard }).Distinct().ToArray()
                    : SpecialWinningCardIds.ToArray()
            };
        }
    }
}
