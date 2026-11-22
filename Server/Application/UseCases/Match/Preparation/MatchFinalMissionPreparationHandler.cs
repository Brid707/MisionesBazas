using System;
using System.Linq;
using Application.Models;
using Domain;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static class MatchFinalMissionPreparationHandler
    {
        internal static MissionPreparationCommit IdentifyRequestedHeartNineOwner(MatchState state,
            MissionPreparationRequest request, int participantUserId)
        {
            MissionPreparationCommit commit = MatchSpecialPreparationHandler.RejectPreparation(
                request, MissionPreparationRejection.InvalidTarget);
            int actorSeat = Array.IndexOf(state.ParticipantUserIds, participantUserId);
            bool isIdentificationMission = MissionCatalog.GetMission(state.MissionAttempt.MissionNumber).SpecialRule ==
                SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts;
            if (isIdentificationMission && state.MissionAttempt.RoleConfig?.HeartNineOwnerSeat == actorSeat &&
                state.PlayerHandCardIdsBySeat[actorSeat].Contains(MissionObjectiveDealRules.HeartNineCardId))
            {
                commit = state.CommitSpecialPreparation(request, participantUserId, new SpecialPreparationChange
                {
                    UpdatedAttempt = state.MissionAttempt with
                    {
                        RoleConfig = state.MissionAttempt.RoleConfig with { HasIdentifiedHeartNineOwner = true },
                        Phase = MissionAttemptPhase.PlayingTricks
                    },
                    ResponsesBySeat = state.BlindResponsesBySeat,
                    HasStageChanged = true
                });
            }
            return commit;
        }

        internal static MissionPreparationCommit AssignRequestedTrickDistribution(MatchState state,
            MissionPreparationRequest request, int participantUserId)
        {
            var context = new MissionTrickDistributionContext
            {
                Attempt = state.MissionAttempt,
                Definition = MissionCatalog.GetMission(state.MissionAttempt.MissionNumber),
                ActingParticipantSeat = Array.IndexOf(state.ParticipantUserIds, participantUserId),
                FirstFourTricksWinnerSeat = Array.IndexOf(state.ParticipantUserIds,
                    request.FirstFourTricksWinnerParticipantUserId),
                LastTrickWinnerSeat = Array.IndexOf(state.ParticipantUserIds, request.LastTrickWinnerParticipantUserId)
            };
            MissionPreparationRejection rejection = context.ActingParticipantSeat == state.MissionCaptainSeat
                ? MissionPreparationRejection.InvalidTarget : MissionPreparationRejection.CaptainRequired;
            MissionPreparationCommit commit = MatchSpecialPreparationHandler.RejectPreparation(request, rejection);
            if (MissionSpecialPreparationRules.CanAssignTrickDistribution(context))
            {
                commit = state.CommitSpecialPreparation(request, participantUserId, new SpecialPreparationChange
                {
                    UpdatedAttempt = MissionSpecialPreparationRules.AssignTrickDistribution(context),
                    ResponsesBySeat = state.BlindResponsesBySeat,
                    HasStageChanged = true
                });
            }
            return commit;
        }

        internal static int CountCapturedHearts(MatchState state)
        {
            byte? targetSeat = MissionSpecialPreparationRules.GetRequiredHeartCaptureSeat(
                state.MissionAttempt.RoleConfig, state.ParticipantUserIds.Length);
            return targetSeat.HasValue ? state.WonCardIdsBySeat[targetSeat.Value].Count(cardId =>
                DeckRules.GetCardById(cardId).Suit == CardSuit.Heart) : 0;
        }
    }
}
