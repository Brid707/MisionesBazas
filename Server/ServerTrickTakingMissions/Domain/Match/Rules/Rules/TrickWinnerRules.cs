using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Domain
{
    public static class TrickWinnerRules
    {
        public static TrickCardPlay DetermineTrickWinner(IReadOnlyList<TrickCardPlay> trickPlays)
        {
            if (trickPlays is null)
            {
                throw new ArgumentNullException(nameof(trickPlays));
            }
            if (trickPlays.Count == 0)
            {
                throw new ArgumentOutOfRangeException(nameof(trickPlays));
            }

            TrickCardPlay leadPlay = LeadCardResolver.GetLeadPlay(trickPlays);
            CardSuit leadSuit = leadPlay.Card.Suit;
            TrickCardPlay winningPlay = leadPlay;

            foreach (TrickCardPlay trickPlay in trickPlays)
            {
                if (IsChallengerWinning(trickPlay.Card, winningPlay.Card, leadSuit))
                {
                    winningPlay = trickPlay;
                }
            }

            return winningPlay;
        }

        private static bool IsChallengerWinning(Card challengerCard, Card currentWinnerCard, CardSuit leadSuit)
        {
            bool isChallengerSpecial = challengerCard.Suit == CardSuit.Special;
            bool isCurrentWinnerSpecial = currentWinnerCard.Suit == CardSuit.Special;
            bool isChallengerWinning;

            if (isChallengerSpecial && isCurrentWinnerSpecial)
            {
                isChallengerWinning = challengerCard.SpecialSymbol > currentWinnerCard.SpecialSymbol;
            }
            else if (isChallengerSpecial || isCurrentWinnerSpecial)
            {
                isChallengerWinning = isChallengerSpecial;
            }
            else
            {
                isChallengerWinning = challengerCard.Suit == leadSuit
                    && challengerCard.Number > currentWinnerCard.Number;
            }

            return isChallengerWinning;
        }
    }
}
