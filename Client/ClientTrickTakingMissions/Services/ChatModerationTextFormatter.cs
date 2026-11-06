using System;
using System.Globalization;

using Model.GameServices;
using View.Properties.Langs;

namespace View.Services
{
    /// <summary>Formats localized moderation notices using positional resource placeholders.</summary>
    public static class ChatModerationTextFormatter
    {
        public static string FormatSubmissionFeedback(LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome)
        {
            string localizedChatFeedback = string.Empty;
            if (chatMessageSubmissionOutcome != null)
            {
                if (chatMessageSubmissionOutcome.ChatMessageRejectionReason != ChatMessageRejectionReason.None)
                {
                    localizedChatFeedback = GetChatResource(
                        "Chat_" + chatMessageSubmissionOutcome.ChatMessageRejectionReason);
                }
                else if (chatMessageSubmissionOutcome.ChatInfractionNotice?.CurrentMessageInfractionPoints > 0)
                {
                    localizedChatFeedback = FormatInfractionNotice(chatMessageSubmissionOutcome.ChatInfractionNotice);
                }
            }

            return localizedChatFeedback;
        }

        public static string FormatAccountBan(ChatAccountBanNotice chatAccountBanNotice)
        {
            string localizedAccountBanNotice = GetChatResource("Chat_PermanentAccountBan");
            if (chatAccountBanNotice.ChatAccountBanType == ChatAccountBanType.Temporary)
            {
                string localBanEndText = chatAccountBanNotice.ChatAccountBanEndsAtUtc?.ToLocalTime()
                    .ToString("g", CultureInfo.CurrentCulture) ?? string.Empty;
                TimeSpan remainingBanDuration = chatAccountBanNotice.ChatAccountBanEndsAtUtc.GetValueOrDefault() -
                    chatAccountBanNotice.EvaluatedAtUtc;
                localizedAccountBanNotice = string.Format(CultureInfo.CurrentCulture,
                    Resources.Chat_TemporaryAccountBan,
                    new object[] { localBanEndText, FormatRemainingBanDuration(remainingBanDuration) });
            }

            return localizedAccountBanNotice;
        }

        private static string FormatRemainingBanDuration(TimeSpan remainingBanDuration)
        {
            string remainingBanText = GetChatResource("Chat_TemporaryBanExpired");
            if (remainingBanDuration > TimeSpan.Zero)
            {
                remainingBanText = string.Format(CultureInfo.CurrentCulture, Resources.Chat_RemainingBanDuration,
                    new object[]
                    {
                        remainingBanDuration.Days,
                        remainingBanDuration.Hours,
                        remainingBanDuration.Minutes,
                        remainingBanDuration.Seconds
                    });
            }

            return remainingBanText;
        }

        private static string FormatInfractionNotice(ChatInfractionNotice chatInfractionNotice)
        {
            return string.Format(CultureInfo.CurrentCulture, Resources.Chat_InfractionWarning,
                new object[]
                {
                    chatInfractionNotice.AccumulatedChatInfractionPoints,
                    chatInfractionNotice.ChatInfractionPointThreshold,
                    chatInfractionNotice.RemainingChatInfractionPointsBeforeBan
                });
        }

        private static string GetChatResource(string chatResourceName)
        {
            return Resources.ResourceManager.GetString(chatResourceName, CultureInfo.CurrentUICulture) ??
                Resources.Common_Error_Unexpected;
        }
    }
}
