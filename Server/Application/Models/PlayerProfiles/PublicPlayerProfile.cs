using System;

namespace Application.Models
{
    /// <summary>Projects public persisted account fields without private email or transport dependencies.</summary>
    public sealed class PublicPlayerProfile
    {
        public int ProfileOwnerUserId { get; set; }

        public string Username { get; set; }

        public string Biography { get; set; }

        public DateTime AccountCreatedAtUtc { get; set; }

        public int? CompletedMissionCount { get; set; }
    }
}
