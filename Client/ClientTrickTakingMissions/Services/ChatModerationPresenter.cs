using System.Windows;

using Model.GameServices;
using View.Properties.Langs;
using ViewModel.Services;

namespace View.Services
{
    /// <summary>Displays the server-applied account restriction in the selected interface language.</summary>
    public sealed class ChatModerationPresenter : IChatModerationPresenter
    {
        public string FormatChatSubmissionFeedback(LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome)
        {
            return ChatModerationTextFormatter.FormatSubmissionFeedback(chatMessageSubmissionOutcome);
        }

        public void ShowChatAccountBan(ChatAccountBanNotice chatAccountBanNotice)
        {
            MessageBox.Show(ChatModerationTextFormatter.FormatAccountBan(chatAccountBanNotice),
                Resources.Chat_Title, MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }
}
