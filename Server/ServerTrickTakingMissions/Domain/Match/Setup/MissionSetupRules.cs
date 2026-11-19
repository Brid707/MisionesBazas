using System;
using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Governs the pre-match draft phase, clockwise seat rotation, blind objective capability polling, and captain
    /// role assignments.
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

            if (IsDraftContextValid(context))
            {
                bool isObjectiveIndexValid = context.ObjectiveIndex >= 0 &&
                    context.ObjectiveIndex < context.CurrentObjectives.Count;

                if (isObjectiveIndexValid)
                {
                    canDraft = CanAssignDraftObjective(context);
                }
            }

            return canDraft;
        }

        private static bool IsDraftContextValid(MissionDraftContext context)
        {
            bool isValid = false;

            if (context != null && context.Definition != null)
            {
                bool hasRequiredObjectives = context.CurrentObjectives != null;
                bool isPlayerCountSupported = MatchPlayerCountRules.IsPlayerCountSupported(context.PlayerCount);
                bool areSeatsValid = context.CurrentObjectiveDraftSeat < context.PlayerCount &&
                    context.AttemptingSeat < context.PlayerCount;

                isValid = hasRequiredObjectives && isPlayerCountSupported && areSeatsValid;
            }

            return isValid;
        }

        private static bool CanAssignDraftObjective(MissionDraftContext context)
        {
            bool isObjectiveUnassigned = !context.CurrentObjectives[context.ObjectiveIndex].AssignedSeat.HasValue;
            bool canAssign = false;

            if (isObjectiveUnassigned)
            {
                if (IsBlindObjectiveAssignmentRule(context.Definition.SpecialRule))
                {
                    bool isSoleAssignee = context.RoleConfig != null &&
                        context.RoleConfig.SoleObjectiveAssigneeSeat == context.AttemptingSeat;
                    canAssign = isSoleAssignee;
                }
                else
                {
                    canAssign = context.AttemptingSeat == context.CurrentObjectiveDraftSeat;
                }
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
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="currentObjectives"/> is
        /// null.</exception>
        /// <exception cref="ArgumentOutOfRangeException">Thrown when <paramref name="objectiveIndex"/> is out of
        /// bounds.</exception>
        public static IReadOnlyList<MissionObjective> AssignObjective(
            IReadOnlyList<MissionObjective> currentObjectives, int objectiveIndex, byte assignedSeat)
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
        /// <returns>An updated immutable list where all objectives belong to the assigned seat and are
        /// revealed.</returns>
        /// <exception cref="ArgumentNullException">Thrown when <paramref name="currentObjectives"/> is
        /// null.</exception>
        public static IReadOnlyList<MissionObjective> AutoAssignAllObjectives(
            IReadOnlyList<MissionObjective> currentObjectives, byte assignedSeat)
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
        /// <param name="captainSeat">The seat index of the mission captain.</param>
        /// <returns>True if every participant except the captain has answered yes or no.</returns>
        public static bool AreAllBlindResponsesRecorded(
            IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> responsesBySeat, int playerCount,
            byte captainSeat)
        {
            bool areResponsesComplete = false;
            bool hasValidParameters = responsesBySeat != null &&
                MatchPlayerCountRules.IsPlayerCountSupported(playerCount);

            if (hasValidParameters && captainSeat < playerCount)
            {
                areResponsesComplete = Enumerable.Range(0, playerCount).Where(seat => seat != captainSeat)
                    .All(seat => HasValidBlindResponse(responsesBySeat, (byte)seat));
            }

            return areResponsesComplete;
        }

        private static bool HasValidBlindResponse(
            IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> responsesBySeat, byte seat)
        {
            bool hasResponse = responsesBySeat.TryGetValue(seat, out BlindObjectiveCapableResponse response);
            bool isValidAnswer = response == BlindObjectiveCapableResponse.Yes ||
                response == BlindObjectiveCapableResponse.No;

            return hasResponse && isValidAnswer;
        }

        /// <summary>
        /// Determines whether the captain's role configuration is valid for the current mission definition.
        /// </summary>
        /// <param name="definition">The active mission definition.</param>
        /// <param name="roleConfig">The role assignments chosen by the captain.</param>
        /// <param name="playerCount">The total number of seated participants.</param>
        /// <returns>True if the required roles are properly assigned within bounds; otherwise, false.</returns>
        public static bool ValidateRoleConfiguration(MissionDefinition definition, MissionRoleConfiguration roleConfig,
            int playerCount)
        {
            bool isValid = false;
            bool hasValidReferences = definition != null && roleConfig != null;

            if (hasValidReferences && playerCount > 0)
            {
                switch (definition.SpecialRule)
                {
                    case SpecialMissionRuleType.M11_CaptainSilencesOnePlayer:
                        isValid = IsValidSeatRole(roleConfig.SilencedPlayerSeat, playerCount);
                        break;

                    case SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer:
                    case SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer:
                        isValid = IsValidSeatRole(roleConfig.SoleObjectiveAssigneeSeat, playerCount);
                        break;

                    case SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard:
                        isValid = IsValidSeatRole(roleConfig.SingleTrickWinnerSeat, playerCount);
                        break;

                    case SpecialMissionRuleType.M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard:
                        isValid = IsValidSeatRole(roleConfig.FirstAndLastTrickWinnerSeat, playerCount);
                        break;

                    case SpecialMissionRuleType.M50_SplitTrickWinsDistribution:
                        isValid = ValidateSplitRoles(roleConfig, playerCount);
                        break;

                    default:
                        isValid = true;
                        break;
                }
            }

            return isValid;
        }

        public static bool CanPassObjectiveDraft(MissionDraftContext context)
        {
            bool canPass = false;

            if (IsDraftContextValid(context))
            {
                bool isDraftTurn = context.AttemptingSeat == context.CurrentObjectiveDraftSeat;
                bool isNotBlind = !IsBlindObjectiveAssignmentRule(context.Definition.SpecialRule);
                bool hasUnassignedObjectives = context.CurrentObjectives.Any(objective =>
                    !objective.AssignedSeat.HasValue);

                canPass = isDraftTurn && isNotBlind && hasUnassignedObjectives;
            }

            return canPass;
        }

        public static MissionAttemptState AdvanceObjectiveDraft(MissionAttemptState attemptState,
            bool hasSelectedObjective)
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

        public static bool IsBlindObjectiveAssignmentRule(SpecialMissionRuleType specialRule)
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
