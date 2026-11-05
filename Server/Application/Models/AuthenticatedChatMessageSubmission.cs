using System;


namespace Application.Models
{
    /// <summary>Combines server-verified account identity with the text and identifier submitted for a lobby.</summary>
    public sealed class AuthenticatedChatMessageSubmission
    {
        public int AccountUserId { get; set; }

        public Guid ChatMessageSubmissionId { get; set; }

        public string LobbyCode { get; set; }

        public string OriginalChatMessageText { get; set; }
    }
}
