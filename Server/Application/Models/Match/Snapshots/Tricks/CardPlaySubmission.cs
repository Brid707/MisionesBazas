
namespace Application.Models
{
    /// <summary>
    /// Identifies an attempted card play and the state on which it was selected.
    /// </summary>
    public sealed class CardPlaySubmission
    {
        public int MissionAttemptId { get; set; }

        public string LobbyCode { get; set; }

        public System.Guid MatchId { get; set; }

        public System.Guid CardPlaySubmissionId { get; set; }

        public long ExpectedMatchStateVersion { get; set; }

        public int CardId { get; set; }
    }
}
