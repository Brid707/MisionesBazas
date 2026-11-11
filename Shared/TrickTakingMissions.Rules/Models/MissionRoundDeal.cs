using System.Collections.Generic;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Represents the server-side initial deal outcome for a mission round.
    /// </summary>
    public sealed record MissionRoundDeal
    {
        public int PlayerCount { get; init; }

        public int TotalTricks { get; init; }

        public byte CaptainSeat { get; init; }

        public IReadOnlyDictionary<byte, IReadOnlyList<Card>> HandsBySeat { get; init; }
    }
}
