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
        private const string InvalidExecutionStateMessage = "Distress signal cannot be executed in the current state.";

        /// <summary>
        /// Validates whether a distress signal card pass can be executed under current attempt conditions.
        /// </summary>
        /// <param name="context">The distress signal context containing hands, selections, and attempt state.</param>
        /// <returns>True if the distress signal is valid and all selected cards are
        /// non-special cards in hand; otherwise, false.</returns>
        public static bool CanExecuteDistressSignal(DistressSignalContext context)
        {
            bool canExecute = false;

            if (context is not null && AreTimingPrerequisitesMet(context) && context.HandsBySeat is not null &&
                context.SelectedPassCardBySeat is not null)
            {
                int playerCount = context.HandsBySeat.Count;

                if (MatchPlayerCountRules.IsPlayerCountSupported(playerCount) &&
                    context.SelectedPassCardBySeat.Count == playerCount)
                {
                    canExecute = Enumerable.Range(0,
                        playerCount).All(seat => IsValidPassSelection(context.HandsBySeat[seat],
                        context.SelectedPassCardBySeat, (byte)seat));
                }
            }

            return canExecute;
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
                throw new InvalidOperationException(InvalidExecutionStateMessage);
            }

            int playerCount = context.HandsBySeat.Count;
            var updatedHands = new List<List<Card>>(playerCount);

            for (int seat = 0; seat < playerCount; seat++)
            {
                Card passedCard = context.SelectedPassCardBySeat[(byte)seat];
                List<Card> remainingCards =
                    context.HandsBySeat[seat].Where(card => card.IdCard != passedCard.IdCard).ToList();
                updatedHands.Add(remainingCards);
            }

            for (int senderSeat = 0; senderSeat < playerCount; senderSeat++)
            {
                int receiverSeat = ResolveReceivingSeat(senderSeat, playerCount, context.AgreedDirection);
                Card passedCard = context.SelectedPassCardBySeat[(byte)senderSeat];
                updatedHands[receiverSeat].Add(passedCard);
            }

            IReadOnlyList<IReadOnlyList<Card>> exchangedHands =
                updatedHands.Select(hand => (IReadOnlyList<Card>)hand.AsReadOnly()).ToList().AsReadOnly();

            return exchangedHands;
        }

        private static bool AreTimingPrerequisitesMet(DistressSignalContext context)
        {
            bool isBeforeFirstTrick = context.CurrentTrickNumber <= FirstTrickNumber && !context.IsTrickInProgress;
            bool isNotYetUsed = !context.HasUsedDistressSignal && !context.HasAnyPlayerCommunicated;
            bool hasValidDirection = context.AgreedDirection == PassDirection.Left ||
                                     context.AgreedDirection == PassDirection.Right;

            return isBeforeFirstTrick && isNotYetUsed && hasValidDirection;
        }

        private static bool IsValidPassSelection(IReadOnlyList<Card> hand, IReadOnlyDictionary<byte, Card> selections,
            byte seat)
        {
            bool isValid = false;

            if (hand is not null && selections.TryGetValue(seat, out Card selectedCard) && selectedCard is not null)
            {
                bool isNonSpecial = selectedCard.Suit != CardSuit.Special;
                bool isInHand = hand.Any(card => card.IdCard == selectedCard.IdCard);
                isValid = isNonSpecial && isInHand;
            }

            return isValid;
        }

        private static int ResolveReceivingSeat(int senderSeat, int playerCount, PassDirection direction)
        {
            int receivingSeat;

            switch (direction)
            {
                case PassDirection.Left:
                    receivingSeat = (senderSeat + 1) % playerCount;
                    break;

                case PassDirection.Right:
                    receivingSeat = (senderSeat - 1 + playerCount) % playerCount;
                    break;

                default:
                    throw new ArgumentOutOfRangeException(nameof(direction));
            }

            return receivingSeat;
        }
    }
}
