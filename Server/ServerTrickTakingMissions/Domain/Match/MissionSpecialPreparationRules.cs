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
            bool isRoleAssignmentRequired = definition.SpecialRule ==
                SpecialMissionRuleType.M11_CaptainSilencesOnePlayer ||
                definition.SpecialRule == SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer;
            MissionAttemptPhase phase = definition.ObjectiveCardCount == 0
                ? MissionAttemptPhase.PlayingTricks : MissionAttemptPhase.ObjectiveDrafting;
            if (isRoleAssignmentRequired)
            {
                phase = MissionAttemptPhase.RoleAndPreparation;
            }
            return phase;
        }

        public static bool CanAssignRole(MissionRoleAssignmentContext context)
        {
            bool isAllowed = IsRoleContextValid(context);
            if (isAllowed && context.Definition.SpecialRule ==
                SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer)
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
                (context.Definition.SpecialRule == SpecialMissionRuleType.M11_CaptainSilencesOnePlayer ||
                    context.Definition.SpecialRule ==
                        SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer) &&
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
            byte targetSeat = (byte)context.SelectedParticipantSeat;
            bool isBlindAssignment = context.Definition.SpecialRule ==
                SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer;
            MissionRoleConfiguration roles = context.Attempt.RoleConfig ?? MissionRoleConfiguration.Default;
            return context.Attempt with
            {
                RoleConfig = isBlindAssignment ? roles with { SoleObjectiveAssigneeSeat = targetSeat } :
                    roles with { SilencedPlayerSeat = targetSeat },
                Objectives = isBlindAssignment ? MissionSetupRules.AutoAssignAllObjectives(context.Attempt.Objectives,
                    targetSeat) : context.Attempt.Objectives,
                Phase = isBlindAssignment ? MissionAttemptPhase.PlayingTricks : MissionAttemptPhase.ObjectiveDrafting
            };
        }
    }
}
