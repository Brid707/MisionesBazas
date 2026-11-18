using System;
using System.Collections.Generic;
using System.Linq;

namespace Domain
{
    /// <summary>
    /// Governs sequential mission progression and unanimous player voting for transitioning between attempts and missions.
    /// </summary>
    public static class MissionProgressionRules
    {
        public const int MinimumMissionNumber = 1;
        public const int MaximumMissionNumber = 50;
        public const int InitialAttemptNumber = 1;

        /// <summary>
        /// Determines whether the active mission can sequentially advance to the next mission.
        /// </summary>
        /// <param name="currentMissionNumber">The current mission number.</param>
        /// <param name="targetMissionCount">The match target mission threshold configured for the lobby.</param>
        /// <returns>True if advancing to the next sequential mission is permitted; otherwise, false.</returns>
        public static bool CanAdvanceToNextMission(int currentMissionNumber, int targetMissionCount)
        {
            return currentMissionNumber >= MinimumMissionNumber &&
                   currentMissionNumber < targetMissionCount &&
                   currentMissionNumber < MaximumMissionNumber;
        }

        /// <summary>
        /// Registers a player's readiness vote for transitioning to the next mission or attempt.
        /// </summary>
        /// <param name="currentVotes">The current collection of seat indices that have voted ready.</param>
        /// <param name="votingSeat">The seat index casting the vote.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>An updated read-only collection containing all unique ready votes.</returns>
        public static IReadOnlyCollection<byte> RegisterVote(
            IReadOnlyCollection<byte> currentVotes,
            byte votingSeat,
            int playerCount)
        {
            if (votingSeat >= playerCount)
            {
                return currentVotes ?? Array.Empty<byte>();
            }

            var updatedVotes = new HashSet<byte>(currentVotes ?? Array.Empty<byte>())
            {
                votingSeat
            };

            return updatedVotes.ToList().AsReadOnly();
        }

        /// <summary>
        /// Determines whether all seated participants have unanimously cast their readiness vote.
        /// </summary>
        /// <param name="currentVotes">The collection of ready votes by seat.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>True if every seated player has voted ready; otherwise, false.</returns>
        public static bool IsVoteUnanimous(IReadOnlyCollection<byte> currentVotes, int playerCount)
        {
            if (currentVotes is null || playerCount <= 0)
            {
                return false;
            }

            return currentVotes.Count == playerCount &&
                   currentVotes.All(seat => seat < playerCount);
        }

        /// <summary>
        /// Increments the current mission number sequentially if within bounds, resetting attempt progression.
        /// </summary>
        /// <param name="currentMissionNumber">The current mission number.</param>
        /// <param name="targetMissionCount">The target mission threshold.</param>
        /// <returns>The next mission number if advancing is valid; otherwise, the unchanged current mission number.</returns>
        public static int AdvanceToNextMission(int currentMissionNumber, int targetMissionCount)
        {
            int nextMission = CanAdvanceToNextMission(currentMissionNumber, targetMissionCount)
                ? currentMissionNumber + 1
                : currentMissionNumber;

            return nextMission;
        }

        /// <summary>
        /// Increments the attempt counter following a failed attempt.
        /// </summary>
        /// <param name="currentAttemptNumber">The attempt count of the completed attempt.</param>
        /// <returns>The incremented attempt number.</returns>
        public static int RestartAttempt(int currentAttemptNumber)
        {
            return Math.Max(InitialAttemptNumber, currentAttemptNumber + 1);
        }
    }
}
