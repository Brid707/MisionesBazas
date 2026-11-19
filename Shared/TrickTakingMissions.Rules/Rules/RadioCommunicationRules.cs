using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace TrickTakingMissions.Rules.Rules
{
    /// <summary>
    /// Evaluates domain rules for player radio communications and token placement.
    /// </summary>
    public static class RadioCommunicationRules
    {
        private const int DisruptionTrickTwoThreshold = 2;
        private const int DisruptionTrickThreeThreshold = 3;

        /// <summary>
        /// Validates whether a requested radio communication satisfies all timing, hand,
        /// and token placement invariants.
        /// </summary>
        /// <param name="context">The contextual state of the player hand, mission rules, and trick progress.</param>
        /// <returns>A <see cref="RadioCommunicationValidationResult"/> indicating success or the specific rejection
        /// reason.</returns>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="context"/> is null.</exception>
        public static RadioCommunicationValidationResult ValidateCommunication(RadioCommunicationContext context)
        {
            if (context is null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            RadioCommunicationRejectionReason prerequisiteFailure = EvaluatePrerequisites(context);
            RadioCommunicationValidationResult result = RadioCommunicationValidationResult.Reject(prerequisiteFailure);

            if (prerequisiteFailure == RadioCommunicationRejectionReason.None)
            {
                if (context.CommunicationRule == CommunicationRuleType.Interference)
                {
                    result = EvaluateInterference(context);
                }
                else
                {
                    result = EvaluateTokenPosition(context);
                }
            }

            return result;
        }

        private static RadioCommunicationValidationResult EvaluateInterference(RadioCommunicationContext context)
        {
            bool isEligibleCard = ResolveNonInterferencePositions(context.HandCards,
                context.CardToCommunicate).Count > 0;
            RadioCommunicationValidationResult radioCommunicationValidationResult;

            if (isEligibleCard && context.SelectedPosition == RadioTokenPosition.Interference)
            {
                radioCommunicationValidationResult = RadioCommunicationValidationResult.Success(
                    RadioTokenPosition.Interference);
            }
            else
            {
                radioCommunicationValidationResult = RadioCommunicationValidationResult.Reject(
                    RadioCommunicationRejectionReason.InvalidTokenPositionForCard);
            }

            return radioCommunicationValidationResult;
        }

        /// <summary>
        /// Resolves the collection of allowable radio token positions for a specified candidate card in hand.
        /// </summary>
        /// <param name="handCards">The current cards held in the player hand.</param>
        /// <param name="candidateCard">The candidate card intended to be revealed.</param>
        /// <param name="communicationRule">The active communication constraint for the mission.</param>
        /// <returns>A read-only collection of valid <see cref="RadioTokenPosition"/> placements.</returns>
        public static IReadOnlyList<RadioTokenPosition> GetValidPositionsForCard(IReadOnlyList<Card> handCards,
            Card candidateCard, CommunicationRuleType communicationRule)
        {
            IReadOnlyList<RadioTokenPosition> positions = Array.Empty<RadioTokenPosition>();
            if (handCards != null && candidateCard != null && candidateCard.Suit != CardSuit.Special &&
                handCards.Any(card => card.IdCard == candidateCard.IdCard))
            {
                positions = ResolveNonInterferencePositions(handCards, candidateCard);

                if (communicationRule == CommunicationRuleType.Interference && positions.Count > 0)
                {
                    positions = new[] { RadioTokenPosition.Interference };
                }
            }

            return positions;
        }

        private static RadioCommunicationRejectionReason EvaluatePrerequisites(RadioCommunicationContext context)
        {
            RadioCommunicationRejectionReason rejection = GetAvailabilityRejection(context);
            if (rejection == RadioCommunicationRejectionReason.None)
            {
                rejection = EvaluateCandidatePrerequisites(context);
            }
            return rejection;
        }

        private static RadioCommunicationRejectionReason EvaluateCandidatePrerequisites(
            RadioCommunicationContext context)
        {
            RadioCommunicationRejectionReason rejection = RadioCommunicationRejectionReason.None;

            if (context.CardToCommunicate == null || context.HandCards == null ||
                !context.HandCards.Any(card => card.IdCard == context.CardToCommunicate.IdCard))
            {
                rejection = RadioCommunicationRejectionReason.CardNotInHand;
            }

            else if (context.CardToCommunicate.Suit == CardSuit.Special)
            {
                rejection = RadioCommunicationRejectionReason.SpecialCardNotAllowed;
            }

            return rejection;
        }

        /// <summary>Evaluates timing and role availability without revealing a candidate card.</summary>
        public static RadioCommunicationRejectionReason GetAvailabilityRejection(RadioCommunicationContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            RadioCommunicationRejectionReason rejection = RadioCommunicationRejectionReason.None;

            if (IsDisrupted(context.CommunicationRule, context.CurrentTrickNumber))
            {
                rejection = RadioCommunicationRejectionReason.DisruptedUntilTrick;
            }
            if (context.IsTrickInProgress)
            {
                rejection = RadioCommunicationRejectionReason.CannotCommunicateDuringActiveTrick;
            }
            if (context.IsSilencedByCaptain)
            {
                rejection = RadioCommunicationRejectionReason.SilencedByCaptain;
            }
            if (context.HasCommunicatedThisAttempt)
            {
                rejection = RadioCommunicationRejectionReason.AlreadyCommunicatedThisAttempt;
            }

            return rejection;
        }

        private static bool IsDisrupted(CommunicationRuleType rule, int currentTrickNumber)
        {
            bool isDisruptedAtTrickTwo = rule == CommunicationRuleType.DisruptionUntilTrick2 &&
                currentTrickNumber < DisruptionTrickTwoThreshold;
            bool isDisruptedAtTrickThree = rule == CommunicationRuleType.DisruptionUntilTrick3 &&
                currentTrickNumber < DisruptionTrickThreeThreshold;

            return isDisruptedAtTrickTwo || isDisruptedAtTrickThree;
        }

        private static RadioCommunicationValidationResult EvaluateTokenPosition(RadioCommunicationContext context)
        {
            List<Card> cardsOfSameSuit =
                context.HandCards.Where(card => card.Suit == context.CardToCommunicate.Suit).ToList();
            RadioCommunicationValidationResult validationResult;

            if (cardsOfSameSuit.Count == 1)
            {
                if (context.SelectedPosition == RadioTokenPosition.Only)
                {
                    validationResult = RadioCommunicationValidationResult.Success(RadioTokenPosition.Only);
                }
                else
                {
                    validationResult = RadioCommunicationValidationResult.Reject(
                        RadioCommunicationRejectionReason.InvalidTokenPositionForCard);
                }
            }
            else
            {
                int highestNumberInSuit = cardsOfSameSuit.Max(card => card.Number);
                int lowestNumberInSuit = cardsOfSameSuit.Min(card => card.Number);

                bool isHighest = context.CardToCommunicate.Number == highestNumberInSuit &&
                                 context.SelectedPosition == RadioTokenPosition.Highest;
                bool isLowest = context.CardToCommunicate.Number == lowestNumberInSuit &&
                                context.SelectedPosition == RadioTokenPosition.Lowest;

                if (isHighest)
                {
                    validationResult = RadioCommunicationValidationResult.Success(RadioTokenPosition.Highest);
                }
                else if (isLowest)
                {
                    validationResult = RadioCommunicationValidationResult.Success(RadioTokenPosition.Lowest);
                }
                else
                {
                    validationResult = RadioCommunicationValidationResult.Reject(
                        RadioCommunicationRejectionReason.InvalidTokenPositionForCard);
                }
            }

            return validationResult;
        }

        private static IReadOnlyList<RadioTokenPosition> ResolveNonInterferencePositions(IReadOnlyList<Card> handCards,
            Card candidateCard)
        {
            List<Card> cardsOfSameSuit =
                handCards.Where(card => card.Suit == candidateCard.Suit).ToList();
            IReadOnlyList<RadioTokenPosition> validPositions;

            if (cardsOfSameSuit.Count == 1)
            {
                validPositions = new[] { RadioTokenPosition.Only };
            }
            else
            {
                var positions = new List<RadioTokenPosition>(2);
                int highestNumberInSuit = cardsOfSameSuit.Max(card => card.Number);
                int lowestNumberInSuit = cardsOfSameSuit.Min(card => card.Number);

                if (candidateCard.Number == highestNumberInSuit)
                {
                    positions.Add(RadioTokenPosition.Highest);
                }

                if (candidateCard.Number == lowestNumberInSuit)
                {
                    positions.Add(RadioTokenPosition.Lowest);
                }

                validPositions = positions.AsReadOnly();
            }

            return validPositions;
        }
    }
}
