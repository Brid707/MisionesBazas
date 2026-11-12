using System;
using System.Collections.Generic;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Domain
{
    /// <summary>
    /// Governs clockwise turn rotation within a trick and the leader assignment for the next trick.
    /// </summary>
    public static class TrickTurnRules
    {
        public static byte GetNextTurnSeat(byte currentSeat, int playerCount)
        {
            if (!MatchPlayerCountRules.IsPlayerCountSupported(playerCount))
            {
                throw new ArgumentOutOfRangeException(nameof(playerCount));
            }

            if (currentSeat >= playerCount)
            {
                throw new ArgumentOutOfRangeException(nameof(currentSeat));
            }

            return (byte)((currentSeat + 1) % playerCount);
        }

        public static bool IsTrickComplete(IReadOnlyList<TrickCardPlay> trickPlays, int playerCount)
        {
            if (!MatchPlayerCountRules.IsPlayerCountSupported(playerCount))
            {
                throw new ArgumentOutOfRangeException(nameof(playerCount));
            }

            return trickPlays != null && trickPlays.Count == playerCount;
        }

        public static byte GetNextTrickLeaderSeat(IReadOnlyList<TrickCardPlay> trickPlays, int playerCount)
        {
            if (trickPlays is null)
            {
                throw new ArgumentNullException(nameof(trickPlays));
            }

            if (!IsTrickComplete(trickPlays, playerCount))
            {
                throw new ArgumentOutOfRangeException(nameof(trickPlays));
            }

            TrickCardPlay winningPlay = TrickWinnerRules.DetermineTrickWinner(trickPlays);
            return winningPlay.Seat;
        }
    }
}
