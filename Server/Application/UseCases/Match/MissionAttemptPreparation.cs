using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Application.Ports;
using Domain;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    /// <summary>
    /// Prepares initial, repeated and sequential mission attempts through the same private dealing path.
    /// </summary>
    internal static class MissionAttemptPreparation
    {
        internal const int InitialMissionAttemptId = 1;

        internal static PreparedMissionAttempt Prepare(MissionAttemptPreparationContext preparationContext,
            IMissionDeckDealer missionDeckDealer)
        {
            MissionDefinition missionDefinition = MissionCatalog.GetMission(preparationContext.MissionNumber);
            if (!CanPrepareMission(preparationContext.MissionNumber))
            {
                throw new InvalidOperationException(nameof(missionDefinition.SpecialRule));
            }
            MissionDeal missionDeal = missionDeckDealer.CreateMissionDeal(preparationContext.ParticipantUserIds.Length);
            IReadOnlyList<MissionObjective> objectives = missionDeckDealer.CreateMissionObjectives(missionDefinition);
            ValidatePreparedDeal(preparationContext, missionDeal);
            ValidatePreparedObjectives(missionDefinition, objectives);
            return CreatePreparedAttempt(preparationContext, missionDeal, objectives);
        }

        internal static bool CanPrepareMission(int missionNumber)
        {
            return MissionImplementationPolicy.CanPrepare(missionNumber);
        }

        private static void ValidatePreparedDeal(MissionAttemptPreparationContext preparationContext,
            MissionDeal missionDeal)
        {
            int participantCount = preparationContext.ParticipantUserIds.Length;
            if (missionDeal?.HandsBySeat == null || missionDeal.HandsBySeat.Count != participantCount ||
                missionDeal.CaptainSeat >= participantCount || missionDeal.HandsBySeat.Any(hand => hand == null))
            {
                throw new InvalidOperationException(nameof(missionDeal));
            }
            Card[] cards = missionDeal.HandsBySeat.SelectMany(hand => hand).ToArray();
            ValidatePreparedCards(cards);
            bool hasValidTrickCount = missionDeal.TotalTricksInMission == DeckRules.TotalDeckSize / participantCount &&
                missionDeal.HandsBySeat.All(hand => hand.Count >= missionDeal.TotalTricksInMission &&
                    hand.Count <= missionDeal.TotalTricksInMission + 1);
            if (!hasValidTrickCount)
            {
                throw new InvalidOperationException(nameof(missionDeal));
            }
        }

        private static void ValidatePreparedCards(Card[] cards)
        {
            if (cards.Any(card => card == null))
            {
                throw new InvalidOperationException(nameof(cards));
            }
            foreach (Card card in cards)
            {
                DeckRules.GetCardById(card.IdCard);
            }
            bool hasCompleteDeck = cards.Length == DeckRules.TotalDeckSize &&
                cards.Select(card => card.IdCard).Distinct().Count() == DeckRules.TotalDeckSize;
            if (!hasCompleteDeck)
            {
                throw new InvalidOperationException(nameof(cards));
            }
        }

        private static void ValidatePreparedObjectives(MissionDefinition missionDefinition,
            IReadOnlyList<MissionObjective> objectives)
        {
            if (objectives == null || objectives.Count != missionDefinition.ObjectiveCardCount ||
                objectives.Any(objective => objective == null))
            {
                throw new InvalidOperationException(nameof(objectives));
            }
            bool hasUniqueCards = objectives.Select(objective => objective.CardId).Distinct().Count() ==
                objectives.Count;
            bool hasFreshObjectives = objectives.All(objective => !objective.AssignedSeat.HasValue &&
                objective.Status == ObjectiveStatus.Pending &&
                DeckRules.GetCardById(objective.CardId).Suit != CardSuit.Special);
            if (!hasUniqueCards || !hasFreshObjectives)
            {
                throw new InvalidOperationException(nameof(objectives));
            }
        }

        private static PreparedMissionAttempt CreatePreparedAttempt(MissionAttemptPreparationContext preparationContext,
            MissionDeal missionDeal, IReadOnlyList<MissionObjective> objectives)
        {
            return new PreparedMissionAttempt
            {
                MissionAttempt = new MissionAttemptState
                {
                    MissionAttemptId = preparationContext.MissionAttemptId,
                    MissionNumber = preparationContext.MissionNumber,
                    AttemptNumber = preparationContext.AttemptNumber,
                    CaptainSeat = missionDeal.CaptainSeat,
                    CurrentObjectiveDraftSeat = missionDeal.CaptainSeat,
                    PlayerCount = preparationContext.ParticipantUserIds.Length,
                    Phase = MissionSpecialPreparationRules.GetInitialPhase(
                        MissionCatalog.GetMission(preparationContext.MissionNumber)),
                    RoleConfig = CreateInitialMissionRoles(preparationContext.MissionNumber, missionDeal),
                    Status = MissionAttemptStatus.InProgress,
                    Objectives = objectives.ToArray(),
                    HasUsedDistressSignal = false,
                    RadioCommunicationsBySeat = Enumerable.Range(0, preparationContext.ParticipantUserIds.Length)
                        .Select(seatIndex => new PlayerRadioCommunicationState
                        {
                            Seat = (byte)seatIndex,
                            HasUsedCommunicationToken = false,
                            IsSilencedByCaptain = false,
                            CommunicatedCard = null,
                            TokenPosition = RadioTokenPosition.Highest
                        }).ToArray()
                },
                PlayerHandCardIdsBySeat = missionDeal.HandsBySeat.Select(hand =>
                    hand.Select(card => card.IdCard).ToList()).ToArray(),
                WonCardIdsBySeat = preparationContext.ParticipantUserIds.Select(_ => new List<int>()).ToArray(),
                WonTrickCountsBySeat = new int[preparationContext.ParticipantUserIds.Length],
                MaximumMissionTrickCount = missionDeal.TotalTricksInMission,
                ObjectiveCardIdsByObjectiveId = objectives.ToDictionary(_ => Guid.NewGuid(),
                    objective => objective.CardId),
                ObjectiveDraftSubmissionId = Guid.NewGuid()
            };
        }
        private static MissionRoleConfiguration CreateInitialMissionRoles(int missionNumber, MissionDeal missionDeal)
        {
            MissionRoleConfiguration roles = MissionRoleConfiguration.Default;
            if (MissionCatalog.GetMission(missionNumber).SpecialRule ==
                SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts)
            {
                roles = roles with { HeartNineOwnerSeat =
                    MissionObjectiveDealRules.GetHeartNineOwnerSeat(missionDeal.HandsBySeat) };
            }
            return roles;
        }
    }
}
