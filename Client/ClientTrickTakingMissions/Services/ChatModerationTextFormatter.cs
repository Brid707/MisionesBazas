using System;
using System.Globalization;

using Model.GameServices;
using View.Properties.Langs;

namespace View.Services
{
    /// <summary>Resolves moderation resources and expands explicitly named infraction placeholders.</summary>
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
                localizedAccountBanNotice = GetChatResource("Chat_TemporaryAccountBan")
                    .Replace("{chatAccountBanEndsAtLocalTime}", localBanEndText);
                TimeSpan remainingBanDuration = chatAccountBanNotice.ChatAccountBanEndsAtUtc.GetValueOrDefault() -
                    chatAccountBanNotice.EvaluatedAtUtc;
                localizedAccountBanNotice += " " + FormatRemainingBanDuration(remainingBanDuration);
            }

            return localizedAccountBanNotice;
        }

        private static string FormatRemainingBanDuration(TimeSpan remainingBanDuration)
        {
            string remainingBanText = GetChatResource("Chat_TemporaryBanExpired");
            if (remainingBanDuration > TimeSpan.Zero)
            {
                remainingBanText = GetChatResource("Chat_RemainingBanDuration")
                    .Replace("{remainingBanDays}", remainingBanDuration.Days.ToString(CultureInfo.CurrentCulture))
                    .Replace("{remainingBanHours}", remainingBanDuration.Hours.ToString(CultureInfo.CurrentCulture))
                    .Replace("{remainingBanMinutes}", remainingBanDuration.Minutes.ToString(CultureInfo.CurrentCulture))
                    .Replace("{remainingBanSeconds}",
                    remainingBanDuration.Seconds.ToString(CultureInfo.CurrentCulture));
            }

            return remainingBanText;
        }

        private static string FormatInfractionNotice(ChatInfractionNotice chatInfractionNotice)
        {
            return GetChatResource("Chat_InfractionWarning")
                .Replace("{accumulatedChatInfractionPoints}", chatInfractionNotice.AccumulatedChatInfractionPoints
                    .ToString(CultureInfo.CurrentCulture))
                .Replace("{chatInfractionPointThreshold}", chatInfractionNotice.ChatInfractionPointThreshold
                    .ToString(CultureInfo.CurrentCulture))
                .Replace("{remainingChatInfractionPointsBeforeBan}",
                chatInfractionNotice.RemainingChatInfractionPointsBeforeBan
                    .ToString(CultureInfo.CurrentCulture));
        }

        private static string GetChatResource(string chatResourceName)
        {
            return Resources.ResourceManager.GetString(chatResourceName, CultureInfo.CurrentUICulture) ??
                Resources.Common_Error_Unexpected;
        }
    }
}
