using System.Diagnostics;
using Application.Ports;

namespace Host.Gameplay
{
    /// <summary>Measures elapsed server milliseconds without consulting wall-clock or client time.</summary>
    internal sealed class MonotonicMatchClock : IMatchClock
    {
        private readonly Stopwatch _elapsedServerTime = Stopwatch.StartNew();

        public long GetTimestampMilliseconds()
        {
            return _elapsedServerTime.ElapsedMilliseconds;
        }
    }
}
