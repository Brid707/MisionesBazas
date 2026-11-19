using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;

namespace Domain
{
    /// <summary>
    /// Encapsulates the 60-second reconnection grace period policy and post-timeout match resolution rules.
    /// </summary>
    public static class DisconnectionPolicyRules
    {
        public const int ReconnectionGracePeriodSeconds = 60;

        /// <summary>
        /// Determines whether the reconnection grace period has expired.
        /// </summary>
        /// <param name="disconnectedAtUtc">The UTC timestamp when the disconnection occurred.</param>
        /// <param name="currentUtc">The current UTC timestamp.</param>
        /// <returns>True if at least 60 seconds have elapsed since disconnection; otherwise, false.</returns>
        public static bool HasGracePeriodExpired(DateTime disconnectedAtUtc, DateTime currentUtc)
        {
            return (currentUtc - disconnectedAtUtc).TotalSeconds >= ReconnectionGracePeriodSeconds;
        }

        /// <summary>
        /// Determines whether a timeout requires mandatory return to the lobby because fewer than 3 players remain.
        /// </summary>
        /// <param name="remainingConnectedPlayers">The number of connected players remaining in the match.</param>
        /// <returns>True if remaining players are fewer than the minimum of 3; otherwise, false.</returns>
        public static bool MustReturnToLobbyImmediately(int remainingConnectedPlayers)
        {
            return remainingConnectedPlayers < LobbyRoomRules.MinimumPlayerLimit;
        }

        /// <summary>
        /// Resolves the collective decision of the 3 remaining players when a 4-player match loses a participant.
        /// </summary>
        /// <param name="votesBySeat">The resolution option voted by each remaining connected player.</param>
        /// <param name="remainingPlayerCount">The number of remaining connected players.</param>
        /// <returns>
        /// <see cref="DisconnectionResolutionOption.RestartMissionWithThreePlayers"/> if all remaining players voted to continue;
        /// <see cref="DisconnectionResolutionOption.ReturnToLobby"/> if any player voted to return to lobby or if fewer than 3 players remain;
        /// otherwise, <see cref="DisconnectionResolutionOption.None"/> while votes are still pending.
        /// </returns>
        public static DisconnectionResolutionOption ResolveRemainingPlayersDecision(
            IReadOnlyDictionary<byte, DisconnectionResolutionOption> votesBySeat,
            int remainingPlayerCount)
        {
            if (MustReturnToLobbyImmediately(remainingPlayerCount))
            {
                return DisconnectionResolutionOption.ReturnToLobby;
            }

            if (votesBySeat is null || votesBySeat.Count == 0)
            {
                return DisconnectionResolutionOption.None;
            }

            if (votesBySeat.Values.Any(vote => vote == DisconnectionResolutionOption.ReturnToLobby))
            {
                return DisconnectionResolutionOption.ReturnToLobby;
            }

            bool allVotedRestart = votesBySeat.Count == remainingPlayerCount &&
                                   votesBySeat.Values.All(vote => vote == DisconnectionResolutionOption.RestartMissionWithThreePlayers);

            return allVotedRestart
                ? DisconnectionResolutionOption.RestartMissionWithThreePlayers
                : DisconnectionResolutionOption.None;
        }
    }
}
