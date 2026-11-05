using System;

using Domain;

namespace Application.Models
{
    /// <summary>Identifies one authenticated message evaluation to persist without repeating its effects.</summary>
    public sealed class ChatInfractionSubmission
    {
        public int AccountUserId { get; set; }

        public Guid ChatMessageSubmissionId { get; set; }

        public string ChatMessageContentDigest { get; set; }

        public ChatInfractionCategory DetectedInfractionCategory { get; set; }
    }
}
