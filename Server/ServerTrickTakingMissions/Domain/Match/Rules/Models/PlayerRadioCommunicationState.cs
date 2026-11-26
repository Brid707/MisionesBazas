using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Represents the explicit state of a player's radio communication token during a mission attempt.
    /// </summary>
    public sealed record PlayerRadioCommunicationState
    {
        public byte Seat { get; init; }

        public bool HasUsedCommunicationToken { get; init; }

        public bool IsSilencedByCaptain { get; init; }

        public Card CommunicatedCard { get; init; }

        public RadioTokenPosition TokenPosition { get; init; }
    }
}
