using TrickTakingMissions.Rules.Enums;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Represents an active objective card in a mission attempt, including its visibility, assigned seat, and completion status.
    /// </summary>
    public sealed record MissionObjective
    {
        public int CardId { get; init; }

        public ObjectiveTokenType Token { get; init; }

        public int? AssignedSeat { get; init; }

        public bool IsRevealed { get; init; } = true;

        public ObjectiveStatus Status { get; init; }

        public int? CompletedAtTrickNumber { get; init; }
    }
}
