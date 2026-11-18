using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Application.UseCases
{
    internal static partial class MatchSnapshotProjection
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

        private static PlayerMissionPreparationSnapshot CreateMissionPreparation(
            MatchState matchState, int participantSeat)
        {
            MissionAttemptState attempt = matchState.MissionAttempt;
            return new PlayerMissionPreparationSnapshot
            {
                AvailableObjectiveDraftSubmissionId = participantSeat == attempt.CurrentObjectiveDraftSeat &&
                    attempt.Phase == MissionAttemptPhase.ObjectiveDrafting
                    ? (Guid?)matchState.CurrentObjectiveDraftSubmissionId : null,
                MissionAttemptId = attempt.MissionAttemptId,
                MissionNumber = attempt.MissionNumber,
                IsPreparationComplete = attempt.Phase == MissionAttemptPhase.PlayingTricks ||
                    attempt.Phase == MissionAttemptPhase.Finished,
                CurrentObjectiveDraftPlayerUserId = matchState.ParticipantUserIds[attempt.CurrentObjectiveDraftSeat],
                Objectives = attempt.Objectives.Select(objective => CreateObjectiveSnapshot(matchState, objective))
                    .ToArray()
            };
        }

        private static MissionObjectiveSnapshot CreateObjectiveSnapshot(
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
