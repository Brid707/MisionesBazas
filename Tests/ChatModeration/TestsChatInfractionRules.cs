using System;

using Domain;

namespace ChatModeration.Tests
{
    public static class TestsChatInfractionRules
    {
        private static readonly DateTime EvaluationTimeUtc = new DateTime(2026, 11, 4, 12, 0, 0, DateTimeKind.Utc);

        public static void ApplyMessageInfraction_ThreeThreatsBelowThreshold_DoesNotBanAccount()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState();

            ApplyMessages(accountInfractionState, ChatInfractionCategory.Threat, 3);

            TestAssert.Equal(false, ChatInfractionRules.IsAccountBanned(accountInfractionState, EvaluationTimeUtc));
        }

        public static void ApplyMessageInfraction_ThreeThreatsAndSixInsults_PermanentlyBansAccount()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState();

            ApplyMessages(accountInfractionState, ChatInfractionCategory.Threat, 3);
            ApplyMessages(accountInfractionState, ChatInfractionCategory.Profanity, 6);

            TestAssert.Equal(true, accountInfractionState.IsChatAccountPermanentlyBanned);
        }

        public static void ApplyMessageInfraction_TwoThreatsAndNineInsults_TemporarilyBansForOneWeek()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState();

            ApplyMessages(accountInfractionState, ChatInfractionCategory.Threat, 2);
            ApplyMessages(accountInfractionState, ChatInfractionCategory.Profanity, 9);

            TestAssert.Equal<DateTime?>(EvaluationTimeUtc.AddDays(7), accountInfractionState.ChatAccountBanEndsAtUtc);
        }

        public static void ApplyMessageInfraction_ThirdProfanitySanction_PermanentlyBansAccount()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState
            {
                PreviousTemporaryChatBanCount = 2
            };

            ApplyMessages(accountInfractionState, ChatInfractionCategory.Profanity, 15);

            TestAssert.Equal(true, accountInfractionState.IsChatAccountPermanentlyBanned);
        }

        public static void ApplyMessageInfraction_FourteenPointsThenThreat_AppliesSanctionAboveThreshold()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState
            {
                AccumulatedChatInfractionPoints = 14
            };

            ChatInfractionRules.ApplyMessageInfraction(accountInfractionState, ChatInfractionCategory.Threat, EvaluationTimeUtc);

            TestAssert.Equal(true, ChatInfractionRules.IsAccountBanned(accountInfractionState, EvaluationTimeUtc));
        }

        public static void ResetExpiredCycle_ExpiredTemporaryBan_ClearsPointsAndThreatsButRetainsBanHistory()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState
            {
                AccumulatedChatInfractionPoints = 15,
                ThreateningChatMessageCount = 2,
                PreviousTemporaryChatBanCount = 1,
                ChatAccountBanEndsAtUtc = EvaluationTimeUtc
            };

            ChatInfractionRules.ResetExpiredCycle(accountInfractionState, EvaluationTimeUtc);

            TestAssert.Equal("0:0:1", accountInfractionState.AccumulatedChatInfractionPoints + ":" +
                accountInfractionState.ThreateningChatMessageCount + ":" + accountInfractionState.PreviousTemporaryChatBanCount);
        }

        public static void ApplyMessageInfraction_ActiveBan_DoesNotAccumulateAdditionalPoints()
        {
            ChatAccountInfractionState accountInfractionState = new ChatAccountInfractionState
            {
                AccumulatedChatInfractionPoints = 15,
                ChatAccountBanEndsAtUtc = EvaluationTimeUtc.AddDays(1)
            };

            ChatInfractionRules.ApplyMessageInfraction(accountInfractionState, ChatInfractionCategory.Threat, EvaluationTimeUtc);

            TestAssert.Equal(15, accountInfractionState.AccumulatedChatInfractionPoints);
        }

        private static void ApplyMessages(ChatAccountInfractionState accountInfractionState,
            ChatInfractionCategory infractionCategory, int messageCount)
        {
            for (int messageIndex = 0; messageIndex < messageCount; messageIndex++)
            {
                ChatInfractionRules.ApplyMessageInfraction(accountInfractionState, infractionCategory, EvaluationTimeUtc);
            }
        }
    }
}
