using System;

namespace Application.Models
{
    /// <summary>Contains detached connectivity facts without transport channel types.</summary>
    public sealed record MatchParticipantPresence
    {
        public long ConnectionVersion { get; init; }

        public int[] MissingParticipantUserIds { get; init; }
    }
}
