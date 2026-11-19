using System;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>Controls special preparation without lobby-host or transport dependencies.</summary>
    public static class MissionSpecialPreparationRules
    {
        public static MissionAttemptPhase GetInitialPhase(MissionDefinition definition)
        {
            MissionAttemptPhase phase = definition.ObjectiveCardCount == 0
                ? MissionAttemptPhase.PlayingTricks : MissionAttemptPhase.ObjectiveDrafting;
            if (IsRoleSelectionRequired(definition.SpecialRule))
            {
                phase = MissionAttemptPhase.RoleAndPreparation;
            }
            return phase;
        }

        public static bool CanAssignRole(MissionRoleAssignmentContext context)
        {
            bool isAllowed = IsRoleContextValid(context);
            if (isAllowed && MissionSetupRules.IsBlindObjectiveAssignmentRule(context.Definition.SpecialRule))
            {
                isAllowed = context.SelectedParticipantSeat != context.Attempt.CaptainSeat &&
                    MissionSetupRules.AreAllBlindResponsesRecorded(context.ResponsesBySeat,
                        context.Attempt.PlayerCount, context.Attempt.CaptainSeat);
            }
            return isAllowed;
        }

        private static bool IsRoleContextValid(MissionRoleAssignmentContext context)
        {
            return context?.Attempt != null && context.Definition != null &&
                IsRoleSelectionRequired(context.Definition.SpecialRule) &&
                context.Attempt.Phase == MissionAttemptPhase.RoleAndPreparation &&
                context.ActingParticipantSeat == context.Attempt.CaptainSeat &&
                context.SelectedParticipantSeat >= 0 && context.SelectedParticipantSeat < context.Attempt.PlayerCount;
        }

        public static MissionAttemptState AssignRole(MissionRoleAssignmentContext context)
        {
            if (!CanAssignRole(context))
            {
                throw new ArgumentException(nameof(context));
            }
            bool isBlindAssignment = MissionSetupRules.IsBlindObjectiveAssignmentRule(context.Definition.SpecialRule);
            return context.Attempt with
            {
                RoleConfig = CreateAssignedRoles(context),
                Objectives = isBlindAssignment ? MissionSetupRules.AutoAssignAllObjectives(context.Attempt.Objectives,
                    (byte)context.SelectedParticipantSeat) : context.Attempt.Objectives,
                Phase = context.Definition.SpecialRule == SpecialMissionRuleType.M11_CaptainSilencesOnePlayer
                    ? MissionAttemptPhase.ObjectiveDrafting : MissionAttemptPhase.PlayingTricks
            };
        }
        private static bool IsRoleSelectionRequired(SpecialMissionRuleType specialRule)
        {
            return MissionSetupRules.IsBlindObjectiveAssignmentRule(specialRule) ||
                specialRule == SpecialMissionRuleType.M11_CaptainSilencesOnePlayer ||
                specialRule == SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard;
        }

        private static MissionRoleConfiguration CreateAssignedRoles(MissionRoleAssignmentContext context)
        {
            byte selectedParticipantSeat = (byte)context.SelectedParticipantSeat;
            MissionRoleConfiguration roles = context.Attempt.RoleConfig ?? MissionRoleConfiguration.Default;
            if (MissionSetupRules.IsBlindObjectiveAssignmentRule(context.Definition.SpecialRule))
            {
                roles = roles with { SoleObjectiveAssigneeSeat = selectedParticipantSeat };
            }
            else if (context.Definition.SpecialRule == SpecialMissionRuleType.M11_CaptainSilencesOnePlayer)
            {
                roles = roles with { SilencedPlayerSeat = selectedParticipantSeat };
            }
            else
            {
                roles = roles with { SingleTrickWinnerSeat = selectedParticipantSeat };
            }
            return roles;
        }
    }
}
