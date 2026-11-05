namespace Domain
{
    /// <summary>
    /// Encapsulates pure domain invariants for lobby capacity, mission configuration, and match launch conditions.
    /// </summary>
    public static class LobbyRoomRules
    {
        public const byte DefaultTargetMissionCount = 5;
        public const byte MinimumTargetMissionCount = 1;
        public const byte MaximumTargetMissionCount = 50;

        public const byte DefaultPlayerLimit = 4;
        public const byte MinimumPlayerLimit = 3;
        public const byte MaximumPlayerLimit = 4;
        public const byte MinimumPlayersToStart = 3;

        public const byte StatusWaiting = 1;
        public const byte StatusInGame = 2;
        public const byte StatusClosed = 3;

        /// <summary>Checks explicit editing bounds without silently substituting default values.</summary>
        public static bool IsConfigurationValid(byte targetMissionCount, byte playerLimit, int currentPlayerCount)
        {
            return targetMissionCount >= MinimumTargetMissionCount && targetMissionCount <= MaximumTargetMissionCount &&
                playerLimit >= MinimumPlayerLimit && playerLimit <= MaximumPlayerLimit &&
                currentPlayerCount <= playerLimit;
        }

        /// <summary>
        /// Resolves a valid target mission count by applying domain bounds to the requested value.
        /// </summary>
        /// <param name="requestedMissionCount">The mission count requested by the room host.</param>
        /// <returns>The validated mission count within domain limits, or the default value if out of range.</returns>
        public static byte ResolveTargetMissionCount(byte requestedMissionCount)
        {
            bool isWithinBounds = requestedMissionCount >= MinimumTargetMissionCount &&
                                  requestedMissionCount <= MaximumTargetMissionCount;

            return isWithinBounds
                ? requestedMissionCount
                : DefaultTargetMissionCount;
        }

        /// <summary>
        /// Resolves a valid player limit by applying domain capacity bounds to the requested value.
        /// </summary>
        /// <param name="requestedPlayerLimit">The player limit requested by the room host.</param>
        /// <returns>The validated player limit within domain bounds, or the default capacity if out of range.</returns>
        public static byte ResolvePlayerLimit(byte requestedPlayerLimit)
        {
            bool isWithinBounds = requestedPlayerLimit >= MinimumPlayerLimit &&
                                  requestedPlayerLimit <= MaximumPlayerLimit;

            return isWithinBounds
                ? requestedPlayerLimit
                : DefaultPlayerLimit;
        }

        /// <summary>
        /// Determines whether a lobby room has available capacity to admit an additional participant.
        /// </summary>
        /// <param name="currentPlayerCount">The number of players currently inside the room.</param>
        /// <param name="playerLimit">The maximum player capacity configured for the room.</param>
        /// <returns>True if the room has at least one open slot; otherwise, false.</returns>
        public static bool HasAvailableSlot(int currentPlayerCount, byte playerLimit)
        {
            return currentPlayerCount >= 0 && currentPlayerCount < playerLimit;
        }

        /// <summary>
        /// Determines whether a lobby room is currently in the waiting state and open to new participants.
        /// </summary>
        /// <param name="roomStatus">The current lifecycle status of the room.</param>
        /// <returns>True if the room is waiting for players; otherwise, false.</returns>
        public static bool IsRoomWaitingForPlayers(byte roomStatus)
        {
            return roomStatus == StatusWaiting;
        }

        /// <summary>
        /// Determines whether a lobby room satisfies all domain conditions required to start a game match.
        /// </summary>
        /// <param name="currentPlayerCount">The number of players currently inside the room.</param>
        /// <param name="isEveryPlayerReady">Indicates whether all participants in the room are marked as ready.</param>
        /// <param name="roomStatus">The current lifecycle status of the room.</param>
        /// <returns>True if the match can be launched; otherwise, false.</returns>
        public static bool CanLaunchMatch(int currentPlayerCount, bool isEveryPlayerReady, byte roomStatus)
        {
            bool hasMinimumPlayers = currentPlayerCount >= MinimumPlayersToStart;
            bool isWaiting = IsRoomWaitingForPlayers(roomStatus);

            return isWaiting && hasMinimumPlayers && isEveryPlayerReady;
        }
    }
}
