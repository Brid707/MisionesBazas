namespace Domain
{
    /// <summary>
    /// Holds player seat assignments for special mission roles configured by the captain.
    /// </summary>
    public sealed record MissionRoleConfiguration
    {
        public byte? HeartNineOwnerSeat { get; init; }

        public bool HasIdentifiedHeartNineOwner { get; init; }

        public byte? SilencedPlayerSeat { get; init; }

        public byte? SoleObjectiveAssigneeSeat { get; init; }

        public byte? SingleTrickWinnerSeat { get; init; }

        public byte? FirstAndLastTrickWinnerSeat { get; init; }

        public byte? FirstFourTricksWinnerSeat { get; init; }

        public byte? LastTrickWinnerSeat { get; init; }

        public static MissionRoleConfiguration Default { get; } = new MissionRoleConfiguration();
    }
}
