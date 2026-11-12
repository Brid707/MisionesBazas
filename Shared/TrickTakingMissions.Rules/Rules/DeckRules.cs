using System;
using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace TrickTakingMissions.Rules.Rules
{
    public static class DeckRules
    {
        private const int TotalDeckSize = 40;
        private const int FirstNormalCardId = 1;
        private const int FirstSpecialCardId = 37;
        private const int MinimumNormalNumber = 1;
        private const int MaximumNormalNumber = 9;
        private const int SpecialCardNumber = 0;
        private static readonly CardSuit[] _normalSuits =
        {
            CardSuit.Diamond,
            CardSuit.Club,
            CardSuit.Heart,
            CardSuit.Spade
        };
        private static readonly SpecialCardSymbol[] _specialSymbolsInCardIdOrder =
        {
            SpecialCardSymbol.Spade,
            SpecialCardSymbol.Heart,
            SpecialCardSymbol.Club,
            SpecialCardSymbol.Diamond
        };
        private static readonly IReadOnlyList<Card> _standardDeck = CreateStandardDeck();

        public static IReadOnlyList<Card> CreateStandardDeck()
        {
            List<Card> deckCards = new List<Card>(TotalDeckSize);
            AddNormalCards(deckCards);
            AddSpecialCards(deckCards);

            return deckCards.AsReadOnly();
        }

        public static Card GetCardById(int idCard)
        {
            if (idCard < FirstNormalCardId || idCard > TotalDeckSize)
            {
                throw new ArgumentOutOfRangeException(nameof(idCard));
            }

            return _standardDeck[idCard - FirstNormalCardId];
        }

        private static void AddNormalCards(List<Card> cards)
        {
            int nextCardId = FirstNormalCardId;

            foreach (CardSuit suit in _normalSuits)
            {
                for (int cardNumber = MinimumNormalNumber; cardNumber <= MaximumNormalNumber; cardNumber++)
                {
                    cards.Add(new Card
                    {
                        IdCard = nextCardId,
                        Suit = suit,
                        Number = cardNumber,
                        SpecialSymbol = SpecialCardSymbol.None
                    });
                    nextCardId++;
                }
            }
        }
        private static void AddSpecialCards(List<Card> cards)
        {
            int nextCardId = FirstSpecialCardId;
            foreach (SpecialCardSymbol specialSymbol in _specialSymbolsInCardIdOrder)
            {
                cards.Add(new Card
                {
                    IdCard = nextCardId,
                    Suit = CardSuit.Special,
                    Number = SpecialCardNumber,
                    SpecialSymbol = specialSymbol
                });
                nextCardId++;
            }
        }
    }
}
