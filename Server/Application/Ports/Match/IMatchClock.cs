namespace Application.Ports
{
    /// <summary>Supplies monotonic server time independent of player clocks and wall-clock adjustments.</summary>
    public interface IMatchClock
    {
        long GetTimestampMilliseconds();
    }
}
