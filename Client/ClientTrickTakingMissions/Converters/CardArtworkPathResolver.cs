using System;
using System.Collections.Generic;
using System.Globalization;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace View.Converters
{
    internal static class CardArtworkPathResolver
    {
        private const string CardBackPath = "/View;component/Assets/Images/Cards/Card_Back_Default.png";
        private const string StandardCardPath = "/View;component/Assets/Images/Cards/Card_{0}_{1}.png";
        private const string ObjectiveCardPath =
            "/View;component/Assets/Images/ObjectiveCards/Card_Objective_{0}_{1}.png";
        private static readonly IReadOnlyDictionary<int, string> s_numberNames = new Dictionary<int, string>
        {
            { 1, "One" }, { 2, "Two" }, { 3, "Three" }, { 4, "Four" }, { 5, "Five" },
            { 6, "Six" }, { 7, "Seven" }, { 8, "Eight" }, { 9, "Nine" }
        };

        internal static string ResolveCardPath(object value, bool isObjectiveCard)
        {
            string artworkPath = CardBackPath;
            if (value is int cardId)
            {
                try
                {
                    Card card = DeckRules.GetCardById(cardId);
                    artworkPath = ResolveOfficialCardPath(card, isObjectiveCard);
                }
                catch (ArgumentOutOfRangeException)
                {
                    artworkPath = CardBackPath;
                }
            }
            return artworkPath;
        }

        private static string ResolveOfficialCardPath(Card card, bool isObjectiveCard)
        {
            string artworkPath = CardBackPath;
            bool isSpecialCard = card.Suit == CardSuit.Special;
            if (!isObjectiveCard || !isSpecialCard)
            {
                string suitName = isSpecialCard ? card.SpecialSymbol.ToString() : card.Suit.ToString();
                string numberName = isSpecialCard ? "King" : s_numberNames[card.Number];
                artworkPath = string.Format(CultureInfo.InvariantCulture,
                    isObjectiveCard ? ObjectiveCardPath : StandardCardPath, suitName, numberName);
            }
            return artworkPath;
        }
    }
}
