using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Governs validation and simultaneous non-special card passing for the distress signal mechanic.
    /// </summary>
    public static class DistressSignalRules
    {
        private const int FirstTrickNumber = 1;

        /// <summary>
        /// Validates whether a distress signal card pass can be executed under current attempt conditions.
        /// </summary>
        /// <param name="context">The distress signal context containing hands, selections, and attempt state.</param>
        /// <returns>True if the distress signal is valid and all selected cards are
        /// non-special cards in hand; otherwise, false.</returns>
        public static bool CanExecuteDistressSignal(DistressSignalContext context)
        {
            if (context is null || !AreTimingPrerequisitesMet(context))
            {
                return false;
            }

            if (context.HandsBySeat is null || context.SelectedPassCardBySeat is null)
            {
                return false;
            }

            int playerCount = context.HandsBySeat.Count;
            if (!MatchPlayerCountRules.IsPlayerCountSupported(playerCount) ||
                context.SelectedPassCardBySeat.Count != playerCount)
            {
                return false;
            }

            return Enumerable.Range(0, playerCount)
                .All(seat => IsValidPassSelection(
                    context.HandsBySeat[seat], context.SelectedPassCardBySeat, (byte)seat));
        }

        /// <summary>
        /// Executes the simultaneous card pass between adjacent seats in the agreed direction.
        /// </summary>
        /// <param name="context">The validated distress signal context.</param>
        /// <returns>The updated hands by seat after exchanging the selected cards.</returns>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="context"/> is null.</exception>
        /// <exception cref="InvalidOperationException">
        /// Thrown when the distress signal context does not satisfy domain rules.
        /// </exception>
        public static IReadOnlyList<IReadOnlyList<Card>> ExecuteCardPass(DistressSignalContext context)
        {
            if (context is null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            if (!CanExecuteDistressSignal(context))
            {
                throw new InvalidOperationException("Distress signal cannot be executed in the current state.");
            }

            int playerCount = context.HandsBySeat.Count;
            List<List<Card>> updatedHands = new List<List<Card>>(playerCount);

            for (int seat = 0; seat < playerCount; seat++)
            {
                Card passedOut = context.SelectedPassCardBySeat[(byte)seat];
                List<Card> remainingCards = context.HandsBySeat[seat]
                    .Where(card => card.IdCard != passedOut.IdCard)
                    .ToList();
                updatedHands.Add(remainingCards);
            }

            for (int senderSeat = 0; senderSeat < playerCount; senderSeat++)
            {
                int receiverSeat = ResolveReceivingSeat(senderSeat, playerCount, context.AgreedDirection);
                Card passedCard = context.SelectedPassCardBySeat[(byte)senderSeat];
                updatedHands[receiverSeat].Add(passedCard);
            }

            return updatedHands.Select(hand => (IReadOnlyList<Card>)hand.AsReadOnly()).ToList().AsReadOnly();
        }

        private static bool AreTimingPrerequisitesMet(DistressSignalContext context)
        {
            bool isBeforeFirstTrick = context.CurrentTrickNumber <= FirstTrickNumber && !context.IsTrickInProgress;
            bool isNotYetUsed = !context.HasUsedDistressSignal && !context.HasAnyPlayerCommunicated;
            bool hasValidDirection = context.AgreedDirection == PassDirection.Left ||
                                     context.AgreedDirection == PassDirection.Right;

            return isBeforeFirstTrick && isNotYetUsed && hasValidDirection;
        }

        private static bool IsValidPassSelection(
            IReadOnlyList<Card> hand,
            IReadOnlyDictionary<byte, Card> selections,
            byte seat)
        {
            if (hand is null || !selections.TryGetValue(seat, out Card selectedCard) || selectedCard is null)
            {
                return false;
            }

            bool isNonSpecial = selectedCard.Suit != CardSuit.Special;
            bool isInHand = hand.Any(card => card.IdCard == selectedCard.IdCard);

            return isNonSpecial && isInHand;
        }

        private static int ResolveReceivingSeat(int senderSeat, int playerCount, PassDirection direction)
        {
            return direction == PassDirection.Left
                ? (senderSeat + 1) % playerCount
                : (senderSeat - 1 + playerCount) % playerCount;
        }
    }
}
