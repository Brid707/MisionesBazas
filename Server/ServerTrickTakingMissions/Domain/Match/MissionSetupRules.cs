using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Governs the pre-match draft phase, clockwise seat rotation, and captain role assignments.
    /// </summary>
    public static class MissionSetupRules
    {
        /// <summary>
        /// Calculates the zero-based seat index entitled to draft the next objective card in clockwise order.
        /// </summary>
        /// <param name="captainSeat">The seat index of the mission captain.</param>
        /// <param name="draftedCount">The total number of objectives already drafted in the attempt.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>The seat index expected to draft next.</returns>
        /// <exception cref="ArgumentOutOfRangeException">Thrown when <paramref name="playerCount"/> is less than or equal to zero.</exception>
        public static byte GetCurrentDraftingSeat(byte captainSeat, int draftedCount, int playerCount)
        {
            if (playerCount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(playerCount));
            }

            return (byte)((captainSeat + draftedCount) % playerCount);
        }

        /// <summary>
        /// Validates whether a participant is authorized to draft a specified objective card.
        /// </summary>
        /// <param name="context">The contextual state encapsulation for the draft request.</param>
        /// <returns>True if the draft action satisfies all rotation and role rules; otherwise, false.</returns>
        public static bool CanDraftObjective(MissionDraftContext context)
        {
            if (context is null || context.Definition is null || context.CurrentObjectives is null)
            {
                return false;
            }

            if (context.ObjectiveIndex < 0 || context.ObjectiveIndex >= context.CurrentObjectives.Count)
            {
                return false;
            }

            if (context.CurrentObjectives[context.ObjectiveIndex].AssignedSeat.HasValue)
            {
                return false;
            }

            if (IsSoleAssigneeRule(context.Definition.SpecialRule))
            {
                return context.RoleConfig != null &&
                       context.RoleConfig.SoleObjectiveAssigneeSeat.HasValue &&
                       context.AttemptingSeat == context.RoleConfig.SoleObjectiveAssigneeSeat.Value;
            }

            int draftedCount = context.CurrentObjectives.Count(objective => objective.AssignedSeat.HasValue);
            byte expectedSeat = GetCurrentDraftingSeat(context.CaptainSeat, draftedCount, context.PlayerCount);

            return context.AttemptingSeat == expectedSeat;
        }

        /// <summary>
        /// Assigns a selected objective to a player seat and returns an updated immutable list.
        /// </summary>
        /// <param name="currentObjectives">The current list of mission objectives.</param>
        /// <param name="objectiveIndex">The zero-based index of the target objective to assign.</param>
        /// <param name="assignedSeat">The player seat index receiving the objective.</param>
        /// <returns>An updated immutable list of objectives.</returns>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="currentObjectives"/> is null.</exception>
        /// <exception cref="ArgumentOutOfRangeException">Thrown when <paramref name="objectiveIndex"/> is out of bounds.</exception>
        public static IReadOnlyList<MissionObjective> AssignObjective(
            IReadOnlyList<MissionObjective> currentObjectives,
            int objectiveIndex,
            byte assignedSeat)
        {
            if (currentObjectives is null)
            {
                throw new ArgumentNullException(nameof(currentObjectives));
            }

            if (objectiveIndex < 0 || objectiveIndex >= currentObjectives.Count)
            {
                throw new ArgumentOutOfRangeException(nameof(objectiveIndex));
            }

            var updatedList = new List<MissionObjective>(currentObjectives);
            updatedList[objectiveIndex] = updatedList[objectiveIndex] with
            {
                AssignedSeat = assignedSeat
            };

            return updatedList.AsReadOnly();
        }

        /// <summary>
        /// Assigns all pending objectives in an attempt directly to a designated player seat.
        /// </summary>
        /// <param name="currentObjectives">The current list of mission objectives.</param>
        /// <param name="assignedSeat">The single player seat index receiving all objectives.</param>
        /// <returns>An updated immutable list where all objectives belong to the assigned seat.</returns>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="currentObjectives"/> is null.</exception>
        public static IReadOnlyList<MissionObjective> AutoAssignAllObjectives(
            IReadOnlyList<MissionObjective> currentObjectives,
            byte assignedSeat)
        {
            if (currentObjectives is null)
            {
                throw new ArgumentNullException(nameof(currentObjectives));
            }

            var updatedList = new List<MissionObjective>(currentObjectives.Count);
            foreach (MissionObjective objective in currentObjectives)
            {
                updatedList.Add(objective with { AssignedSeat = assignedSeat });
            }

            return updatedList.AsReadOnly();
        }

        /// <summary>
        /// Determines whether the captain's role configuration is valid for the current mission definition.
        /// </summary>
        /// <param name="definition">The active mission definition.</param>
        /// <param name="roleConfig">The role assignments chosen by the captain.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>True if the required roles are properly assigned within bounds; otherwise, false.</returns>
        public static bool ValidateRoleConfiguration(
            MissionDefinition definition,
            MissionRoleConfiguration roleConfig,
            int playerCount)
        {
            if (definition is null || roleConfig is null || playerCount <= 0)
            {
                return false;
            }

            switch (definition.SpecialRule)
            {
                case SpecialMissionRuleType.M11_CaptainSilencesOnePlayer:
                    return IsValidSeatRole(roleConfig.SilencedPlayerSeat, playerCount);

                case SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer:
                case SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer:
                    return IsValidSeatRole(roleConfig.SoleObjectiveAssigneeSeat, playerCount);

                case SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard:
                    return IsValidSeatRole(roleConfig.SingleTrickWinnerSeat, playerCount);

                case SpecialMissionRuleType.M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard:
                    return IsValidSeatRole(roleConfig.FirstAndLastTrickWinnerSeat, playerCount);

                case SpecialMissionRuleType.M50_SplitTrickWinsDistribution:
                    return ValidateSplitRoles(roleConfig, playerCount);

                default:
                    return true;
            }
        }

        private static bool IsSoleAssigneeRule(SpecialMissionRuleType specialRule)
        {
            return specialRule == SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer ||
                   specialRule == SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer;
        }

        private static bool IsValidSeatRole(byte? seat, int playerCount)
        {
            return seat.HasValue && seat.Value < playerCount;
        }

        private static bool ValidateSplitRoles(MissionRoleConfiguration roleConfig, int playerCount)
        {
            bool hasValidFirstFourSeat = IsValidSeatRole(roleConfig.FirstFourTricksWinnerSeat, playerCount);
            bool hasValidLastTrickSeat = IsValidSeatRole(roleConfig.LastTrickWinnerSeat, playerCount);
            bool areRolesDistinct = roleConfig.FirstFourTricksWinnerSeat.GetValueOrDefault() !=
                                    roleConfig.LastTrickWinnerSeat.GetValueOrDefault();

            return hasValidFirstFourSeat && hasValidLastTrickSeat && areRolesDistinct;
        }
    }
}
