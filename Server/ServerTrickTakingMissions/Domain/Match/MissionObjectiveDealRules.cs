using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Handles the randomized drawing of mission objectives and assignment of priority tokens.
    /// </summary>
    public static class MissionObjectiveDealRules
    {
        private const int FirstNormalObjectiveCardId = 1;
        public const int NormalObjectiveDeckSize = 36;
        public const int HeartNineCardId = 27;

        /// <summary>
        /// Randomly selects the required number of distinct objective cards and associates configured ordering tokens.
        /// </summary>
        /// <param name="definition">The mission definition specifying the objective count and tokens.</param>
        /// <param name="randomGenerator">The random number generator instance used for shuffling.</param>
        /// <returns>An immutable collection of drawn <see cref="MissionObjective"/> instances.</returns>
        /// <exception cref="ArgumentNullException">Thrown when a required argument is null.</exception>
        /// <exception cref="ArgumentException">Thrown when the definition or objective deck is invalid.</exception>
        public static IReadOnlyList<MissionObjective> DrawObjectives(
            MissionDefinition definition,
            Random randomGenerator)
        {
            if (randomGenerator is null)
            {
                throw new ArgumentNullException(nameof(randomGenerator));
            }

            int[] normalCardIds = Enumerable.Range(FirstNormalObjectiveCardId, NormalObjectiveDeckSize).ToArray();
            ShuffleCardIds(normalCardIds, randomGenerator);

            return CreateObjectives(definition, normalCardIds);
        }

        public static IReadOnlyList<MissionObjective> CreateObjectives(
            MissionDefinition definition, IReadOnlyList<int> shuffledNormalCardIds)
        {
            if (definition == null)
            {
                throw new ArgumentNullException(nameof(definition));
            }
            if (shuffledNormalCardIds == null)
            {
                throw new ArgumentNullException(nameof(shuffledNormalCardIds));
            }
            if (definition.Tokens == null)
            {
                throw new ArgumentException(nameof(definition));
            }
            ValidateObjectiveDeck(definition, shuffledNormalCardIds);
            bool shouldStartRevealed = !IsBlindObjectiveMission(definition.SpecialRule);
            var drawnObjectives = new List<MissionObjective>(definition.ObjectiveCardCount);

            for (int index = 0; index < definition.ObjectiveCardCount; index++)
            {
                int cardId = shuffledNormalCardIds[index];
                ObjectiveTokenType token = index < definition.Tokens.Count
                    ? definition.Tokens[index]
                    : ObjectiveTokenType.None;

                drawnObjectives.Add(new MissionObjective
                {
                    CardId = cardId,
                    Token = token,
                    AssignedSeat = null,
                    IsRevealed = shouldStartRevealed,
                    Status = ObjectiveStatus.Pending,
                    CompletedAtTrickNumber = null
                });
            }

            return drawnObjectives.AsReadOnly();
        }

        /// <summary>
        /// Identifies the zero-based player seat index currently holding the Heart 9 card.
        /// </summary>
        /// <param name="handsBySeat">The read-only collection of player hands indexed by seat.</param>
        /// <returns>The seat index holding Heart 9.</returns>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="handsBySeat"/> is null.</exception>
        /// <exception cref="InvalidOperationException">Thrown when Heart 9 is not present in any dealt hand.</exception>
        public static byte GetHeartNineOwnerSeat(IReadOnlyList<IReadOnlyList<Card>> handsBySeat)
        {
            if (handsBySeat is null)
            {
                throw new ArgumentNullException(nameof(handsBySeat));
            }

            for (int seatIndex = 0; seatIndex < handsBySeat.Count; seatIndex++)
            {
                IReadOnlyList<Card> hand = handsBySeat[seatIndex];
                if (hand != null && hand.Any(card => card.Suit == CardSuit.Heart && card.Number == MissionFailureReasons.ForbiddenTrickWinnerCardNumber))
                {
                    return (byte)seatIndex;
                }
            }

            throw new InvalidOperationException("Heart 9 was not found in any dealt player hand.");
        }

        /// <summary>
        /// Resolves the player seat situated immediately to the left of the Heart 9 owner in clockwise order.
        /// </summary>
        /// <param name="heartNineOwnerSeat">The seat index of the player holding Heart 9.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>The seat index of the target Heart cards winner.</returns>
        /// <exception cref="ArgumentOutOfRangeException">Thrown when <paramref name="playerCount"/> is less than or equal to zero.</exception>
        public static byte GetTargetHeartWinnerSeat(byte heartNineOwnerSeat, int playerCount)
        {
            if (playerCount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(playerCount));
            }

            return (byte)((heartNineOwnerSeat + 1) % playerCount);
        }

        private static void ValidateObjectiveDeck(
            MissionDefinition definition, IReadOnlyList<int> shuffledNormalCardIds)
        {
            if (definition.ObjectiveCardCount < 0 || definition.ObjectiveCardCount > NormalObjectiveDeckSize ||
                shuffledNormalCardIds.Count != NormalObjectiveDeckSize ||
                shuffledNormalCardIds.Distinct().Count() != NormalObjectiveDeckSize ||
                shuffledNormalCardIds.Any(cardId =>
                    cardId < FirstNormalObjectiveCardId || cardId > NormalObjectiveDeckSize))
            {
                throw new ArgumentException(nameof(shuffledNormalCardIds));
            }
        }

        private static bool IsBlindObjectiveMission(SpecialMissionRuleType specialRule)
        {
            return specialRule == SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer ||
                   specialRule == SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer;
        }

        private static void ShuffleCardIds(int[] cardIds, Random randomGenerator)
        {
            for (int currentIndex = cardIds.Length - 1; currentIndex > 0; currentIndex--)
            {
                int swapIndex = randomGenerator.Next(currentIndex + 1);
                int displacedId = cardIds[currentIndex];
                cardIds[currentIndex] = cardIds[swapIndex];
                cardIds[swapIndex] = displacedId;
            }
        }
    }
}
