using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Provides the state context required to evaluate the validity of a radio communication attempt.
    /// </summary>
    public sealed record RadioCommunicationContext
    {
        public int CurrentTrickNumber { get; init; }

        public bool IsTrickInProgress { get; init; }

        public bool HasCommunicatedThisAttempt { get; init; }

        public bool IsSilencedByCaptain { get; init; }

        public CommunicationRuleType CommunicationRule { get; init; }

        public IReadOnlyList<Card> HandCards { get; init; }

        public Card CardToCommunicate { get; init; }

        public RadioTokenPosition SelectedPosition { get; init; }
    }
}
