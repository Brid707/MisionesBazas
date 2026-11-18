using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using Application.Ports;
using Domain;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Host.Gameplay
{
    /// <summary>Uses unpredictable draws; neither a clock seed nor the future deck leaves the server.</summary>
    internal sealed class SecureMissionDeckDealer : IMissionDeckDealer
    {
        private const int ThreePlayerMatchParticipantCount = 3;

        public MissionDeal CreateMissionDeal(int participantCount)
        {
            var shuffledCards = new List<Card>(DeckRules.CreateStandardDeck());
            int firstSpecialCardReceivingSeat = 0;
            using (RandomNumberGenerator randomGenerator = RandomNumberGenerator.Create())
            {
                if (participantCount == ThreePlayerMatchParticipantCount)
                {
                    firstSpecialCardReceivingSeat = GetUnbiasedIndex(randomGenerator, participantCount);
                }
                ShuffleCards(shuffledCards, randomGenerator);
            }
            return DeckDealRules.DealCards(shuffledCards.AsReadOnly(), participantCount, firstSpecialCardReceivingSeat);
        }

        public IReadOnlyList<MissionObjective> CreateMissionObjectives(MissionDefinition definition)
        {
            var shuffledCards = new List<Card>(DeckRules.CreateStandardDeck());
            using (RandomNumberGenerator randomGenerator = RandomNumberGenerator.Create())
            {
                ShuffleCards(shuffledCards, randomGenerator);
            }
            return MissionObjectiveDealRules.CreateObjectives(definition,
                shuffledCards.FindAll(card => card.Suit != CardSuit.Special).ConvertAll(card => card.IdCard));
        }

        private static void ShuffleCards(List<Card> shuffledCards, RandomNumberGenerator randomGenerator)
        {
            for (int cardIndex = shuffledCards.Count - 1; cardIndex > 0; cardIndex--)
            {
                int swapIndex = GetUnbiasedIndex(randomGenerator, cardIndex + 1);
                Card displacedCard = shuffledCards[cardIndex];
                shuffledCards[cardIndex] = shuffledCards[swapIndex];
                shuffledCards[swapIndex] = displacedCard;
            }
        }

        private static int GetUnbiasedIndex(RandomNumberGenerator randomGenerator, int exclusiveMaximum)
        {
            var randomBytes = new byte[sizeof(uint)];
            uint randomValue;
            uint acceptedLimit = uint.MaxValue - (uint.MaxValue % (uint)exclusiveMaximum);
            do
            {
                randomGenerator.GetBytes(randomBytes);
                randomValue = BitConverter.ToUInt32(randomBytes, 0);
            }
            while (randomValue >= acceptedLimit);
            return (int)(randomValue % exclusiveMaximum);
        }
    }
}
