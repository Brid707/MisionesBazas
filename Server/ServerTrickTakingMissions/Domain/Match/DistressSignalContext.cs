using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Encapsulates the state required to validate and execute a pre-trick distress signal card pass.
    /// </summary>
    public sealed record DistressSignalContext
    {
        public int CurrentTrickNumber { get; init; }

        public bool IsTrickInProgress { get; init; }

        public bool HasUsedDistressSignal { get; init; }

        public bool HasAnyPlayerCommunicated { get; init; }

        public PassDirection AgreedDirection { get; init; }

        public IReadOnlyList<IReadOnlyList<Card>> HandsBySeat { get; init; }

        public IReadOnlyDictionary<byte, Card> SelectedPassCardBySeat { get; init; }
    }
}
