using Gameplay;

namespace Application.Models
{
    /// <summary>Retains the request fingerprint and detached decision for safe replays.</summary>
    public sealed class ProcessedCardPlay
    {
        public int ParticipantUserId { get; set; }
        public int CardId { get; set; }
        public long ExpectedMatchStateVersion { get; set; }
        public CardPlayDecision Decision { get; set; }
    }
}
