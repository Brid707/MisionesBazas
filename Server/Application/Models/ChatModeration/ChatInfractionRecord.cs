
using Domain;

namespace Application.Models
{
    /// <summary>Contains the committed account state and replay disposition of a submitted chat message.</summary>
    public sealed class ChatInfractionRecord
    {
        public ChatAccountInfractionState AccountInfractionState { get; set; }

        public int CurrentMessageInfractionPoints { get; set; }

        public bool IsRepeatedChatMessageSubmission { get; set; }

        public bool HasConflictingChatMessageIdentifier { get; set; }

        public bool IsAccountBanned { get; set; }
    }
}
