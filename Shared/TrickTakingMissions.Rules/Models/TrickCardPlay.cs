namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Represents a single card played by a seated participant during a trick.
    /// </summary>
    public sealed record TrickCardPlay
    {
        public byte Seat { get; init; }

        public Card Card { get; init; }

        public byte PlayOrder { get; init; }
    }
}
