using System;

namespace Application.Models
{
    /// <summary>Signals unavailable persistence without coupling application to Entity Framework.</summary>
    public sealed class PlayerProfileUnavailableException : Exception
    {
        public PlayerProfileUnavailableException()
        {
        }

        public PlayerProfileUnavailableException(string message) : base(message)
        {
        }

        public PlayerProfileUnavailableException(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }
}
