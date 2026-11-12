using System;
using System.Windows;

using Model.GameServices;
using TrickTakingMissions.Logging.Abstractions.Ports;
using View.Properties.Langs;
using ViewModel.Services;

namespace View.Services
{
    /// <summary>Displays the server-applied account restriction in the selected interface language.</summary>
    public sealed class ChatModerationPresenter : IChatModerationPresenter
    {
        private const string LogAccountBanNoticeShown = "Displayed chat account ban notice ({BanType}).";

        private readonly ILoggerService _logger;

        public ChatModerationPresenter()
            : this(ClientLoggingRuntime.CreateLogger<ChatModerationPresenter>())
        {
        }

        public ChatModerationPresenter(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public string FormatChatSubmissionFeedback(LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome)
        {
            return ChatModerationTextFormatter.FormatSubmissionFeedback(chatMessageSubmissionOutcome);
        }

        public string FormatAccountBan(ChatAccountBanNotice chatAccountBanNotice)
        {
            return ChatModerationTextFormatter.FormatAccountBan(chatAccountBanNotice);
        }

        public void ShowChatAccountBan(ChatAccountBanNotice chatAccountBanNotice)
        {
            _logger.Warning(LogAccountBanNoticeShown, chatAccountBanNotice?.ChatAccountBanType);
            MessageBox.Show(ChatModerationTextFormatter.FormatAccountBan(chatAccountBanNotice),
                Resources.Chat_Title, MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }
}
