
using Model.GameServices;

namespace ViewModel.Services
{
    /// <summary>Displays a localized account restriction without coupling the chat ViewModel to WPF.</summary>
    public interface IChatModerationPresenter
    {
        string FormatChatSubmissionFeedback(LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome);

        string FormatAccountBan(ChatAccountBanNotice chatAccountBanNotice);

        void ShowChatAccountBan(ChatAccountBanNotice chatAccountBanNotice);
    }
}
