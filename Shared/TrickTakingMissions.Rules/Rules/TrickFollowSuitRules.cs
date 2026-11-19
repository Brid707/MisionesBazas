using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace TrickTakingMissions.Rules.Rules
{
    public static class TrickFollowSuitRules
    {
        private const int MinimumPlayerCount = 3;
        private const int MaximumPlayerCount = 4;

        public static TrickPlayValidationResult ValidatePlay(TrickPlayContext trickPlayContext)
        {
            TrickPlayRejectionReason rejectionReason = GetRejectionReason(trickPlayContext);
            TrickPlayValidationResult validationResult = rejectionReason == TrickPlayRejectionReason.None
                ? TrickPlayValidationResult.Legal()
                : TrickPlayValidationResult.Illegal(rejectionReason);

            return validationResult;
        }

        public static IReadOnlyList<int> GetPlayableCards(IReadOnlyList<Card> playerHand,
            IReadOnlyList<TrickCardPlay> currentTrickPlayedCards)
        {
            List<int> playableCardIds = new List<int>();

            if (playerHand != null)
            {
                TrickCardPlay leadPlay = LeadCardResolver.GetLeadPlay(currentTrickPlayedCards);
                bool shouldFollowLeadSuit = leadPlay != null && HasCardOfSuit(playerHand, leadPlay.Card.Suit);

                foreach (Card card in playerHand)
                {
                    if (!shouldFollowLeadSuit || card.Suit == leadPlay.Card.Suit || card.Suit == CardSuit.Special)
                    {
                        playableCardIds.Add(card.IdCard);
                    }
                }
            }

            return playableCardIds.AsReadOnly();
        }

        private static TrickPlayRejectionReason GetRejectionReason(TrickPlayContext context)
        {
            TrickPlayRejectionReason rejectionReason = TrickPlayRejectionReason.None;
            if (!IsContextValid(context))
            {
                rejectionReason = TrickPlayRejectionReason.InvalidPlayContext;
            }
            else if (context.CurrentTrickPlayedCards.Count >= context.PlayerCount)
            {
                rejectionReason = TrickPlayRejectionReason.TrickAlreadyCompleted;
            }
            else if (context.PlayerSeat != context.CurrentTurnSeat)
            {
                rejectionReason = TrickPlayRejectionReason.NotPlayerTurn;
            }
            else if (!IsCardInHand(context.PlayerHand, context.CandidateCard))
            {
                rejectionReason = TrickPlayRejectionReason.CardNotInHand;
            }
            else if (IsFollowSuitViolated(context))
            {
                rejectionReason = TrickPlayRejectionReason.MustFollowLeadSuit;
            }
            return rejectionReason;
        }

        private static bool IsContextValid(TrickPlayContext context)
        {
            return context != null
                && context.PlayerHand != null
                && context.CurrentTrickPlayedCards != null
                && context.CandidateCard != null
                && context.PlayerCount >= MinimumPlayerCount
                && context.PlayerCount <= MaximumPlayerCount;
        }

        private static bool IsCardInHand(IReadOnlyList<Card> playerHand, Card candidateCard)
        {
            bool isCardInHand = false;
            int cardIndex = 0;

            while (!isCardInHand && cardIndex < playerHand.Count)
            {
                isCardInHand = playerHand[cardIndex].IdCard == candidateCard.IdCard;
                cardIndex++;
            }

            return isCardInHand;
        }

        private static bool IsFollowSuitViolated(TrickPlayContext context)
        {
            bool isFollowSuitViolated = false;
            TrickCardPlay leadPlay = LeadCardResolver.GetLeadPlay(context.CurrentTrickPlayedCards);

            if (leadPlay != null)
            {
                CardSuit leadSuit = leadPlay.Card.Suit;
                isFollowSuitViolated = context.CandidateCard.Suit != leadSuit
                    && context.CandidateCard.Suit != CardSuit.Special
                    && HasCardOfSuit(context.PlayerHand, leadSuit);
            }

            return isFollowSuitViolated;
        }

        private static bool HasCardOfSuit(IReadOnlyList<Card> playerHand, CardSuit suit)
        {
            bool hasCardOfSuit = false;
            int cardIndex = 0;

            while (!hasCardOfSuit && cardIndex < playerHand.Count)
            {
                hasCardOfSuit = playerHand[cardIndex].Suit == suit;
                cardIndex++;
            }

            return hasCardOfSuit;
        }
    }
}
