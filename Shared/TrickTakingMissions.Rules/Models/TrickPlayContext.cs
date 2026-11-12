using System.Collections.Generic;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Encapsulates the local player hand and public table state needed to validate a candidate card play.
    /// </summary>
    public sealed record TrickPlayContext
    {
        public byte PlayerSeat { get; init; }

        public byte CurrentTurnSeat { get; init; }

        public int PlayerCount { get; init; }

        public IReadOnlyList<Card> PlayerHand { get; init; }

        public IReadOnlyList<TrickCardPlay> CurrentTrickPlayedCards { get; init; }

        public Card CandidateCard { get; init; }
    }
}
