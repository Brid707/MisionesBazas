using System;


namespace Domain
{
    /// <summary>Applies per-message weights, expiry resets and account sanctions without infrastructure.</summary>
    public static class ChatInfractionRules
    {
        public const int ProfaneChatMessageInfractionPoints = 1;
        public const int ThreateningChatMessageInfractionPoints = 3;
        public const int ChatInfractionPointThreshold = 15;
        public const int ThreateningChatMessageThresholdForPermanentBan = 3;
        public const int TemporaryChatBanLimit = 2;
        public const int TemporaryChatBanDurationDays = 7;
        public const int MaximumChatMessageLength = 500;

        public static bool IsAccountBanned(ChatAccountInfractionState accountInfractionState, DateTime evaluatedAtUtc)
        {
            return accountInfractionState.IsChatAccountPermanentlyBanned ||
                accountInfractionState.ChatAccountBanEndsAtUtc > evaluatedAtUtc;
        }

        public static void ResetExpiredCycle(ChatAccountInfractionState accountInfractionState, DateTime evaluatedAtUtc)
        {
            if (accountInfractionState.ChatAccountBanEndsAtUtc <= evaluatedAtUtc &&
                !accountInfractionState.IsChatAccountPermanentlyBanned)
            {
                accountInfractionState.AccumulatedChatInfractionPoints = 0;
                accountInfractionState.ThreateningChatMessageCount = 0;
                accountInfractionState.ChatAccountBanEndsAtUtc = null;
            }
        }

        public static int GetMessageInfractionPoints(ChatInfractionCategory detectedInfractionCategory)
        {
            int currentMessageInfractionPoints = 0;
            if (detectedInfractionCategory == ChatInfractionCategory.Threat)
            {
                currentMessageInfractionPoints = ThreateningChatMessageInfractionPoints;
            }
            else if (detectedInfractionCategory == ChatInfractionCategory.Profanity)
            {
                currentMessageInfractionPoints = ProfaneChatMessageInfractionPoints;
            }

            return currentMessageInfractionPoints;
        }

        /// <summary>
        /// Counts one infraction per message and evaluates a ban only after reaching the point threshold.
        /// </summary>
        public static void ApplyMessageInfraction(ChatAccountInfractionState accountInfractionState,
            ChatInfractionCategory detectedInfractionCategory, DateTime evaluatedAtUtc)
        {
            ResetExpiredCycle(accountInfractionState, evaluatedAtUtc);
            if (!IsAccountBanned(accountInfractionState, evaluatedAtUtc))
            {
                accountInfractionState.AccumulatedChatInfractionPoints +=
                    GetMessageInfractionPoints(detectedInfractionCategory);
                if (detectedInfractionCategory == ChatInfractionCategory.Threat)
                {
                    accountInfractionState.ThreateningChatMessageCount++;
                }

                if (accountInfractionState.AccumulatedChatInfractionPoints >= ChatInfractionPointThreshold)
                {
                    ApplyThresholdSanction(accountInfractionState, evaluatedAtUtc);
                }
            }
        }

        private static void ApplyThresholdSanction(ChatAccountInfractionState accountInfractionState,
            DateTime evaluatedAtUtc)
        {
            bool hasPermanentBanCondition = accountInfractionState.ThreateningChatMessageCount >=
                ThreateningChatMessageThresholdForPermanentBan ||
                accountInfractionState.PreviousTemporaryChatBanCount >= TemporaryChatBanLimit;
            if (hasPermanentBanCondition)
            {
                accountInfractionState.IsChatAccountPermanentlyBanned = true;
                accountInfractionState.ChatAccountBanEndsAtUtc = null;
            }
            else
            {
                accountInfractionState.PreviousTemporaryChatBanCount++;
                accountInfractionState.ChatAccountBanEndsAtUtc = evaluatedAtUtc.AddDays(TemporaryChatBanDurationDays);
            }
        }
    }
}
