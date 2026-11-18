using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Governs the pre-match draft phase, clockwise seat rotation, blind objective capability polling, and captain role assignments.
    /// </summary>
    public static class MissionSetupRules
    {
        /// <summary>
        /// Validates whether a participant is authorized to draft a specified objective card.
        /// </summary>
        /// <param name="context">The contextual state encapsulation for the draft request.</param>
        /// <returns>True if the draft action satisfies all rotation and role rules; otherwise, false.</returns>
        public static bool CanDraftObjective(MissionDraftContext context)
        {
            bool canDraft = false;
            if (IsDraftContextValid(context) && context.ObjectiveIndex >= 0 &&
                context.ObjectiveIndex < context.CurrentObjectives.Count)
            {
                canDraft = CanAssignDraftObjective(context);
            }
            return canDraft;
        }

        private static bool IsDraftContextValid(MissionDraftContext context)
        {
            return context != null && context.Definition != null && context.CurrentObjectives != null &&
                MatchPlayerCountRules.IsPlayerCountSupported(context.PlayerCount) &&
                context.CurrentObjectiveDraftSeat < context.PlayerCount && context.AttemptingSeat < context.PlayerCount;
        }

        private static bool CanAssignDraftObjective(MissionDraftContext context)
        {
            bool canAssign = !context.CurrentObjectives[context.ObjectiveIndex].AssignedSeat.HasValue;
            if (IsSoleAssigneeRule(context.Definition.SpecialRule))
            {
                canAssign = canAssign && context.RoleConfig != null &&
                    context.RoleConfig.SoleObjectiveAssigneeSeat == context.AttemptingSeat;
            }
            else
            {
                canAssign = canAssign && context.AttemptingSeat == context.CurrentObjectiveDraftSeat;
            }
            return canAssign;
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
                AssignedSeat = assignedSeat,
                IsRevealed = true
            };

            return updatedList.AsReadOnly();
        }

        /// <summary>
        /// Assigns all pending objectives in an attempt directly to a designated player seat and reveals them.
        /// </summary>
        /// <param name="currentObjectives">The current list of mission objectives.</param>
        /// <param name="assignedSeat">The single player seat index receiving all objectives.</param>
        /// <returns>An updated immutable list where all objectives belong to the assigned seat and are revealed.</returns>
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
                updatedList.Add(objective with
                {
                    AssignedSeat = assignedSeat,
                    IsRevealed = true
                });
            }

            return updatedList.AsReadOnly();
        }

        /// <summary>
        /// Verifies whether all seated players have answered Yes or No before the captain assigns blind objectives.
        /// </summary>
        /// <param name="responsesBySeat">The map of player responses indexed by seat.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>True if every seated player has submitted a non-pending response; otherwise, false.</returns>
        public static bool AreAllBlindResponsesRecorded(
            IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> responsesBySeat,
            int playerCount)
        {
            if (responsesBySeat is null || playerCount <= 0)
            {
                return false;
            }

            return Enumerable.Range(0, playerCount)
                .All(seat => responsesBySeat.TryGetValue((byte)seat, out BlindObjectiveCapableResponse response) &&
                             response != BlindObjectiveCapableResponse.Pending);
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

        public static bool CanPassObjectiveDraft(MissionDraftContext context)
        {
            return context != null && context.Definition != null && context.CurrentObjectives != null &&
                MatchPlayerCountRules.IsPlayerCountSupported(context.PlayerCount) &&
                !IsSoleAssigneeRule(context.Definition.SpecialRule) &&
                context.AttemptingSeat == context.CurrentObjectiveDraftSeat &&
                context.AttemptingSeat < context.PlayerCount &&
                context.CurrentObjectives.Any(objective => !objective.AssignedSeat.HasValue);
        }

        public static MissionAttemptState AdvanceObjectiveDraft(
            MissionAttemptState attemptState, bool hasSelectedObjective)
        {
            if (attemptState == null)
            {
                throw new ArgumentNullException(nameof(attemptState));
            }
            byte nextSeat = ParticipantSeatRules.GetNextClockwiseSeat(
                attemptState.CurrentObjectiveDraftSeat, attemptState.PlayerCount);
            int nextPassCount = hasSelectedObjective ? 0 : attemptState.ConsecutiveObjectiveDraftPassCount + 1;
            if (nextPassCount >= attemptState.PlayerCount)
            {
                nextPassCount = 0;
            }
            return attemptState with
            {
                CurrentObjectiveDraftSeat = nextSeat,
                ConsecutiveObjectiveDraftPassCount = nextPassCount
            };
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
