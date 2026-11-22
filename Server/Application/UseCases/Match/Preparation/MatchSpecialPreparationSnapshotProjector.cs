using System;
using System.Linq;
using Application.Models;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static class MatchSpecialPreparationSnapshotProjector
    {
        internal static MissionPreparationStage GetPreparationStage(MatchState state)
        {
            MissionPreparationStage stage = MissionPreparationStage.None;
            switch (state.MissionAttempt.Phase)
            {
                case MissionAttemptPhase.RoleAndPreparation:
                    stage = GetSpecialPreparationStage(state);
                    break;
                case MissionAttemptPhase.ObjectiveDrafting:
                    stage = MissionPreparationStage.ObjectiveDrafting;
                    break;
                case MissionAttemptPhase.PlayingTricks:
                    stage = MissionPreparationStage.PlayingTricks;
                    break;
                case MissionAttemptPhase.Finished:
                    stage = MissionPreparationStage.Finished;
                    break;
                default:
                    break;
            }
            return stage;
        }

        internal static MissionPreparationStage GetSpecialPreparationStage(MatchState state)
        {
            bool isBlind = MissionSetupRules.IsBlindObjectiveAssignmentRule(
                MissionCatalog.GetMission(state.MissionAttempt.MissionNumber).SpecialRule);
            MissionPreparationStage stage = GetRolePreparationStage(state);
            if (isBlind)
            {
                stage = MissionSetupRules.AreAllBlindResponsesRecorded(state.BlindResponsesBySeat,
                    state.ParticipantUserIds.Length, (byte)state.MissionCaptainSeat)
                    ? MissionPreparationStage.AssigneeSelection : MissionPreparationStage.BlindResponses;
            }
            return stage;
        }

        internal static MissionPreparationStage GetRolePreparationStage(MatchState state)
        {
            SpecialMissionRuleType rule = MissionCatalog.GetMission(state.MissionAttempt.MissionNumber).SpecialRule;
            MissionPreparationStage stage = MissionPreparationStage.RoleSelection;
            if (rule == SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts)
            {
                stage = MissionPreparationStage.HeartNineIdentification;
            }
            else if (rule == SpecialMissionRuleType.M50_SplitTrickWinsDistribution)
            {
                stage = MissionPreparationStage.TrickDistributionSelection;
            }
            return stage;
        }

        internal static int? GetParticipantForRole(MatchState state, byte? seat)
        {
            return seat.HasValue ? (int?)state.ParticipantUserIds[seat.Value] : null;
        }

        internal static int[] GetEligibleRoleParticipants(MatchState state, int participantSeat)
        {
            int[] candidates;
            if (GetPreparationStage(state) == MissionPreparationStage.TrickDistributionSelection &&
                participantSeat == state.MissionCaptainSeat)
            {
                candidates = (int[])state.ParticipantUserIds.Clone();
            }
            else
            {
                candidates = Enumerable.Range(0, state.ParticipantUserIds.Length).Where(target =>
                    MissionSpecialPreparationRules.CanAssignRole(MatchUseCase.CreateRoleContext(state,
                        participantSeat, target))).Select(target => state.ParticipantUserIds[target]).ToArray();
            }
            return candidates;
        }

        internal static BlindObjectiveResponse MapBlindResponse(BlindObjectiveCapableResponse response)
        {
            return response == BlindObjectiveCapableResponse.Yes ? BlindObjectiveResponse.Yes :
                BlindObjectiveResponse.No;
        }
    }
}
