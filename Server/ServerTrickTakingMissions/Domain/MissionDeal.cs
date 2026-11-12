using System.Collections.Generic;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Represents the immutable result of dealing the deck at the start of a mission attempt.
    /// </summary>
    public sealed record MissionDeal
    {
        public IReadOnlyList<IReadOnlyList<Card>> HandsBySeat { get; init; }

        public byte CaptainSeat { get; init; }

        public int TotalTricksInMission { get; init; }
    }
}
