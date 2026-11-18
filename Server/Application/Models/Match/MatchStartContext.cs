using System;

namespace Application.Models
{
    /// <summary>Captures the validated lobby configuration when creating a match.</summary>
    public sealed record MatchStartContext
    {
        public string LobbyCode { get; init; }
        public Guid LobbyInstanceId { get; init; }
        public int[] ParticipantUserIds { get; init; }
        public int TargetMissionCount { get; init; }
    }
}
