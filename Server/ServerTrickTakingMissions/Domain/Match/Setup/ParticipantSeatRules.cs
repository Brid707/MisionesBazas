using System;

namespace Domain
{
    public static class ParticipantSeatRules
    {
        public static byte GetNextClockwiseSeat(byte currentSeat, int playerCount)
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
    }
}
