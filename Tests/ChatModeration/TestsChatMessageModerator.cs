using System.IO;
using System;

using Domain;
using Infrastructure.Moderation;

namespace ChatModeration.Tests
{
    public static class TestsChatMessageModerator
    {
        public static void EvaluateChatMessage_MixedLanguages_MasksBothCatalogs()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("idiota asshole");

            TestAssert.Equal("*** ***", chatModerationDecision.CensoredChatMessageText);
        }

        public static void EvaluateChatMessage_ObfuscatedSpanish_MasksOriginalCharacters()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("Hola P3ND3J0!");

            TestAssert.Equal("Hola ***!", chatModerationDecision.CensoredChatMessageText);
        }

        public static void EvaluateChatMessage_SeparatedLetters_MasksEntireExpression()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("p.e.n.d.e.j.o");

            TestAssert.Equal("***", chatModerationDecision.CensoredChatMessageText);
        }

        public static void EvaluateChatMessage_CombiningAccentAndInvisibleCharacter_MasksOriginalSpan()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("i\u0301mbe\u200bcil");

            TestAssert.Equal("***", chatModerationDecision.CensoredChatMessageText);
        }

        public static void EvaluateChatMessage_BenignWordsContainingFragments_LeavesTextUnchanged()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("Scunthorpe, clásico y disputar la baza");

            TestAssert.Equal("Scunthorpe, clásico y disputar la baza", chatModerationDecision.CensoredChatMessageText);
        }

        public static void EvaluateChatMessage_ThreatAndProfanity_UsesThreatCategory()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("idiota, te voy a matar");

            TestAssert.Equal(ChatInfractionCategory.Threat, chatModerationDecision.DetectedInfractionCategory);
        }

        public static void EvaluateChatMessage_EnglishThreat_DetectsRegardlessOfInterfaceLanguage()
        {
            ChatMessageModerator chatMessageModerator = CreateModerator();

            ChatMessageModerationDecision chatModerationDecision = chatMessageModerator.EvaluateChatMessage("I WILL FIND YOUR ADDRESS");

            TestAssert.Equal(ChatInfractionCategory.Threat, chatModerationDecision.DetectedInfractionCategory);
        }

        private static ChatMessageModerator CreateModerator()
        {
            ProhibitedChatExpressionCatalog catalog = new ProhibitedChatExpressionCatalog(
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ModerationCatalogs"));
            return new ChatMessageModerator(catalog.GetAllSupportedLanguageExpressions());
        }
    }
}
