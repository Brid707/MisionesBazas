using TrickTakingMissions.Rules.Enums;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Represents an immutable card from the official 40-card deck.
    /// </summary>
    public sealed record Card
    {
        public int IdCard { get; init; }

        public CardSuit Suit { get; init; }

        public int Number { get; init; }

        public SpecialCardSymbol SpecialSymbol { get; init; }
    }
}
