using System;
using System.Linq;
using Application.Models;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static partial class MatchSnapshotProjection
    {
        private static MissionPreparationStage GetPreparationStage(MatchState state)
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

        private static MissionPreparationStage GetSpecialPreparationStage(MatchState state)
        {
            bool isBlind = MissionCatalog.GetMission(state.MissionAttempt.MissionNumber).SpecialRule ==
                SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer;
            MissionPreparationStage stage = MissionPreparationStage.RoleSelection;
            if (isBlind)
            {
                stage = MissionSetupRules.AreAllBlindResponsesRecorded(state.BlindResponsesBySeat,
                    state.ParticipantUserIds.Length, (byte)state.MissionCaptainSeat)
                    ? MissionPreparationStage.AssigneeSelection : MissionPreparationStage.BlindResponses;
            }
            return stage;
        }

        private static int[] GetEligibleRoleParticipants(MatchState state, int participantSeat)
        {
            return Enumerable.Range(0, state.ParticipantUserIds.Length).Where(target =>
                MissionSpecialPreparationRules.CanAssignRole(MatchUseCase.CreateRoleContext(state,
                    participantSeat, target))).Select(target => state.ParticipantUserIds[target]).ToArray();
        }

        private static BlindObjectiveResponse MapBlindResponse(BlindObjectiveCapableResponse response)
        {
            return response == BlindObjectiveCapableResponse.Yes ? BlindObjectiveResponse.Yes :
                BlindObjectiveResponse.No;
        }
    }
}
