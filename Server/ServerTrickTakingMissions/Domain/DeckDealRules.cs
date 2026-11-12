using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Domain
{
    /// <summary>
    /// Shuffles the official deck and deals it among the seated players, identifying the mission captain.
    /// </summary>
    public static class DeckDealRules
    {
        private const int NormalDeckCardCount = 36;

        public static IReadOnlyList<Card> ShuffleDeck(IReadOnlyList<Card> deck, Random randomGenerator)
        {
            if (deck is null)
            {
                throw new ArgumentNullException(nameof(deck));
            }

            if (randomGenerator is null)
            {
                throw new ArgumentNullException(nameof(randomGenerator));
            }

            var shuffledCards = new List<Card>(deck);

            for (int currentIndex = shuffledCards.Count - 1; currentIndex > 0; currentIndex--)
            {
                int swapIndex = randomGenerator.Next(currentIndex + 1);
                Card displacedCard = shuffledCards[currentIndex];
                shuffledCards[currentIndex] = shuffledCards[swapIndex];
                shuffledCards[swapIndex] = displacedCard;
            }

            return shuffledCards.AsReadOnly();
        }

        public static MissionDeal DealCards(IReadOnlyList<Card> shuffledDeck, int playerCount,
            int firstSpecialCardReceivingSeat = 0)
        {
            if (shuffledDeck is null)
            {
                throw new ArgumentNullException(nameof(shuffledDeck));
            }

            if (shuffledDeck.Count != DeckRules.TotalDeckSize)
            {
                throw new ArgumentOutOfRangeException(nameof(shuffledDeck));
            }

            if (!MatchPlayerCountRules.IsPlayerCountSupported(playerCount))
            {
                throw new ArgumentOutOfRangeException(nameof(playerCount));
            }

            if (firstSpecialCardReceivingSeat < 0 || firstSpecialCardReceivingSeat >= playerCount)
            {
                throw new ArgumentOutOfRangeException(nameof(firstSpecialCardReceivingSeat));
            }

            List<List<Card>> handsBySeat = CreateEmptyHands(playerCount);
            byte captainSeat = 0;
            bool hasCaptainCard = false;
            ValidateOfficialDeck(shuffledDeck);
            List<Card> separatedDeck = shuffledDeck.Where(card => card.Suit != CardSuit.Special)
                .Concat(shuffledDeck.Where(card => card.Suit == CardSuit.Special)).ToList();
            for (int cardIndex = 0; cardIndex < separatedDeck.Count; cardIndex++)
            {
                Card dealtCard = separatedDeck[cardIndex];
                int receivingSeat = GetReceivingPlayerSeat(cardIndex, playerCount, firstSpecialCardReceivingSeat);
                handsBySeat[receivingSeat].Add(dealtCard);

                if (IsCaptainCard(dealtCard))
                {
                    captainSeat = (byte)receivingSeat;
                    hasCaptainCard = true;
                }
            }

            if (!hasCaptainCard)
            {
                throw new ArgumentException(nameof(shuffledDeck));
            }

            return new MissionDeal
            {
                HandsBySeat = ToReadOnlyHands(handsBySeat),
                CaptainSeat = captainSeat,
                TotalTricksInMission = DeckRules.TotalDeckSize / playerCount
            };
        }

        private static int GetReceivingPlayerSeat(int dealtCardIndex, int participantCount,
            int firstSpecialCardReceivingSeat)
        {
            int receivingPlayerSeat = dealtCardIndex % participantCount;
            if (dealtCardIndex >= NormalDeckCardCount)
            {
                receivingPlayerSeat = (dealtCardIndex - NormalDeckCardCount + firstSpecialCardReceivingSeat)
                    % participantCount;
            }
            return receivingPlayerSeat;
        }

        private static void ValidateOfficialDeck(IReadOnlyList<Card> shuffledDeck)
        {
            if (shuffledDeck.Any(card => card == null) ||
                shuffledDeck.Select(card => card.IdCard).Distinct().Count() != DeckRules.TotalDeckSize ||
                shuffledDeck.Any(card => !IsOfficialCard(card)))
            {
                throw new ArgumentException(nameof(shuffledDeck));
            }
        }

        private static List<List<Card>> CreateEmptyHands(int playerCount)
        {
            var emptyHands = new List<List<Card>>(playerCount);

            for (int seat = 0; seat < playerCount; seat++)
            {
                emptyHands.Add(new List<Card>());
            }

            return emptyHands;
        }

        private static IReadOnlyList<IReadOnlyList<Card>> ToReadOnlyHands(List<List<Card>> handsBySeat)
        {
            var readOnlyHands = new List<IReadOnlyList<Card>>(handsBySeat.Count);
            foreach (List<Card> hand in handsBySeat)
            {
                readOnlyHands.Add(hand.AsReadOnly());
            }

            return readOnlyHands.AsReadOnly();
        }

        private static bool IsOfficialCard(Card card)
        {
            Card officialCard = card.IdCard >= 1 && card.IdCard <= DeckRules.TotalDeckSize
                ? DeckRules.GetCardById(card.IdCard) : null;
            return officialCard != null && card.Suit == officialCard.Suit &&
                card.Number == officialCard.Number && card.SpecialSymbol == officialCard.SpecialSymbol;
        }

        private static bool IsCaptainCard(Card card)
        {
            return card.Suit == CardSuit.Special && card.SpecialSymbol == SpecialCardSymbol.Spade;
        }
    }
}
