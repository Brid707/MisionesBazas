using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Application.UseCases
{
    internal static class MatchObjectiveDraftSnapshotProjector
    {
        private static readonly IReadOnlyDictionary<ObjectiveTokenType, MissionObjectiveToken> s_objectiveTokens =
            new Dictionary<ObjectiveTokenType, MissionObjectiveToken>
            {
                { ObjectiveTokenType.None, MissionObjectiveToken.None },
                { ObjectiveTokenType.OrderOne, MissionObjectiveToken.OrderOne },
                { ObjectiveTokenType.OrderTwo, MissionObjectiveToken.OrderTwo },
                { ObjectiveTokenType.OrderThree, MissionObjectiveToken.OrderThree },
                { ObjectiveTokenType.OrderFour, MissionObjectiveToken.OrderFour },
                { ObjectiveTokenType.OrderFive, MissionObjectiveToken.OrderFive },
                { ObjectiveTokenType.ArrowOne, MissionObjectiveToken.ArrowOne },
                { ObjectiveTokenType.ArrowTwo, MissionObjectiveToken.ArrowTwo },
                { ObjectiveTokenType.ArrowThree, MissionObjectiveToken.ArrowThree },
                { ObjectiveTokenType.ArrowFour, MissionObjectiveToken.ArrowFour },
                { ObjectiveTokenType.Omega, MissionObjectiveToken.Omega }
            };

        internal static PlayerMissionPreparationSnapshot CreateMissionPreparation(
            MatchState matchState, int participantSeat)
        {
            MissionAttemptState attempt = matchState.MissionAttempt;
            var snapshot = new PlayerMissionPreparationSnapshot
            {
                AvailableObjectiveDraftSubmissionId = participantSeat == attempt.CurrentObjectiveDraftSeat &&
                    attempt.Phase == MissionAttemptPhase.ObjectiveDrafting
                    ? (Guid?)matchState.CurrentObjectiveDraftSubmissionId : null,
                MissionAttemptId = attempt.MissionAttemptId,
                MissionNumber = attempt.MissionNumber,
                Stage = MatchSpecialPreparationSnapshotProjector.GetPreparationStage(matchState),
                MissionPreparationStageId = matchState.MissionPreparationStageId,
                EligibleRoleParticipantUserIds = MatchSpecialPreparationSnapshotProjector.GetEligibleRoleParticipants(matchState, participantSeat),
                CanRespondToBlindObjectives = MatchSpecialPreparationSnapshotProjector.GetPreparationStage(matchState) ==
                    MissionPreparationStage.BlindResponses &&
                    participantSeat != matchState.MissionCaptainSeat &&
                    !matchState.BlindResponsesBySeat.ContainsKey((byte)participantSeat),
                BlindObjectiveResponses = matchState.BlindResponsesBySeat.Select(entry =>
                    new BlindObjectiveParticipantSnapshot { ParticipantUserId =
                        matchState.ParticipantUserIds[entry.Key],
                        Response = MatchSpecialPreparationSnapshotProjector.MapBlindResponse(entry.Value) }).ToArray(),
                SilencedParticipantUserId = attempt.RoleConfig?.SilencedPlayerSeat.HasValue == true
                    ? (int?)matchState.ParticipantUserIds[attempt.RoleConfig.SilencedPlayerSeat.Value] : null,
                SoleObjectiveAssigneeUserId = attempt.RoleConfig?.SoleObjectiveAssigneeSeat.HasValue == true
                    ? (int?)matchState.ParticipantUserIds[attempt.RoleConfig.SoleObjectiveAssigneeSeat.Value] : null,
                SingleTrickWinnerParticipantUserId = attempt.RoleConfig?.SingleTrickWinnerSeat.HasValue == true
                    ? (int?)matchState.ParticipantUserIds[attempt.RoleConfig.SingleTrickWinnerSeat.Value] : null,
                IsPreparationComplete = attempt.Phase == MissionAttemptPhase.PlayingTricks ||
                    attempt.Phase == MissionAttemptPhase.Finished,
                CurrentObjectiveDraftPlayerUserId = matchState.ParticipantUserIds[attempt.CurrentObjectiveDraftSeat],
                Objectives = attempt.Objectives.Select(objective => CreateObjectiveSnapshot(matchState, objective))
                    .ToArray()
            };
            ApplyFinalPreparationSnapshot(snapshot, matchState, participantSeat);
            return snapshot;
        }

        private static void ApplyFinalPreparationSnapshot(PlayerMissionPreparationSnapshot snapshot,
            MatchState matchState, int participantSeat)
        {
            MissionAttemptState attempt = matchState.MissionAttempt;
            snapshot.FirstAndLastTrickWinnerParticipantUserId = MatchSpecialPreparationSnapshotProjector.GetParticipantForRole(matchState,
                attempt.RoleConfig?.FirstAndLastTrickWinnerSeat);
            snapshot.FirstFourTricksWinnerParticipantUserId = MatchSpecialPreparationSnapshotProjector.GetParticipantForRole(matchState,
                attempt.RoleConfig?.FirstFourTricksWinnerSeat);
            snapshot.LastTrickWinnerParticipantUserId = MatchSpecialPreparationSnapshotProjector.GetParticipantForRole(matchState,
                attempt.RoleConfig?.LastTrickWinnerSeat);
            snapshot.HeartNineOwnerParticipantUserId = attempt.RoleConfig?.HasIdentifiedHeartNineOwner == true
                ? MatchSpecialPreparationSnapshotProjector.GetParticipantForRole(matchState, attempt.RoleConfig.HeartNineOwnerSeat) : null;
            snapshot.RequiredHeartCaptureParticipantUserId = attempt.RoleConfig?.HasIdentifiedHeartNineOwner == true
                ? MatchSpecialPreparationSnapshotProjector.GetParticipantForRole(matchState, MissionSpecialPreparationRules.GetRequiredHeartCaptureSeat(
                    attempt.RoleConfig, attempt.PlayerCount)) : null;
            snapshot.CanIdentifyHeartNineOwnership = MatchSpecialPreparationSnapshotProjector.GetPreparationStage(matchState) ==
                MissionPreparationStage.HeartNineIdentification && attempt.RoleConfig?.HeartNineOwnerSeat ==
                    participantSeat;
        }

        internal static MissionObjectiveSnapshot CreateObjectiveSnapshot(
            MatchState matchState, MissionObjective objective)
        {
            return new MissionObjectiveSnapshot
            {
                MissionObjectiveId = matchState.ObjectiveCardIdsByObjectiveId
                    .Single(entry => entry.Value == objective.CardId).Key,
                CardId = objective.IsRevealed ? (int?)objective.CardId : null,
                Token = s_objectiveTokens[objective.Token],
                AssignedPlayerUserId = objective.AssignedSeat.HasValue
                    ? (int?)matchState.ParticipantUserIds[objective.AssignedSeat.Value] : null,
                Status = MissionEvaluationMapper.MapObjectiveStatus(objective.Status),
                CompletedAtTrickNumber = objective.CompletedAtTrickNumber,
                IsRevealed = objective.IsRevealed
            };
        }
    }
}
