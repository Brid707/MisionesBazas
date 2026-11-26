
namespace Application.Models
{
    /// <summary>
    /// Describes one public, server-confirmed card play.
    /// </summary>
    public sealed class MatchCardPlay
    {
        public int PlayerUserId { get; set; }

        public int CardId { get; set; }
    }
}
