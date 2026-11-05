
using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Coordinates bilingual moderation and committed account sanctions for an authenticated submission.
    /// </summary>
    public interface ILobbyChatMessageUseCase
    {
        LobbyChatMessageProcessing ProcessChatMessage(
            AuthenticatedChatMessageSubmission authenticatedChatMessageSubmission);
    }
}
