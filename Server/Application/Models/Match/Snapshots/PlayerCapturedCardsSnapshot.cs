
namespace Application.Models
{
    /// <summary>
    /// Public, detached record of the tricks and cards a participant has won in the current deal.
    /// </summary>
    public sealed class PlayerCapturedCardsSnapshot
    {
        public int PlayerUserId { get; set; }

        public int WonTrickCount { get; set; }

        public int[] WonCardIds { get; set; }
    }
}
