using System;

namespace Application.Models
{
    /// <summary>Contains persisted account data without persistence entities or WCF attributes.</summary>
    public sealed class OwnPlayerProfile
    {
        public string Username { get; set; }

        public string Email { get; set; }

        public DateTime AccountCreatedAtUtc { get; set; }

        public string Biography { get; set; }

        public int? CompletedMissionCount { get; set; }
    }
}
