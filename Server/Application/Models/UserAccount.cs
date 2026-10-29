using System;

namespace Application.Models
{
    /// <summary>
    /// Represents a user account within the application core domain, decoupled from database entities.
    /// </summary>
    public sealed class UserAccount
    {
        public int IdUser { get; set; }

        public string Username { get; set; }

        public string Email { get; set; }

        public string PasswordHash { get; set; }

        public byte Status { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime? LastLoginAt { get; set; }
    }
}
