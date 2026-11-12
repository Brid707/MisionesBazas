
using Application.Models;
using Domain;

namespace Application.Ports
{
    /// <summary>
    /// Persists account moderation state and serializes message processing across server connections.
    /// </summary>
    public interface IChatInfractionRepository
    {
        ChatInfractionRecord RecordChatMessageInfraction(ChatInfractionSubmission chatInfractionSubmission);

        ChatAccountInfractionState GetAccountInfractionState(int accountUserId);
    }
}
