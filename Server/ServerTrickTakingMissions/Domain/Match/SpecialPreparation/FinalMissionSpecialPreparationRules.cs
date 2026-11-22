using System;
using TrickTakingMissions.Rules.Enums;

namespace Domain
{
    public static class FinalMissionSpecialPreparationRules
    {
        public static bool CanAssignTrickDistribution(MissionTrickDistributionContext context)
        {
            return context?.Attempt != null && context.Definition?.SpecialRule ==
                SpecialMissionRuleType.M50_SplitTrickWinsDistribution &&
                context.Attempt.Phase == MissionAttemptPhase.RoleAndPreparation &&
                context.ActingParticipantSeat == context.Attempt.CaptainSeat &&
                    HasDistinctValidDistributionSeats(context);
        }

        private static bool HasDistinctValidDistributionSeats(MissionTrickDistributionContext context)
        {
            int participantCount = context.Attempt.PlayerCount;
            return context.FirstFourTricksWinnerSeat >= 0 && context.FirstFourTricksWinnerSeat < participantCount &&
                context.LastTrickWinnerSeat >= 0 && context.LastTrickWinnerSeat < participantCount &&
                context.FirstFourTricksWinnerSeat != context.LastTrickWinnerSeat;
        }

        public static MissionAttemptState AssignTrickDistribution(MissionTrickDistributionContext context)
        {
            if (!CanAssignTrickDistribution(context))
            {
                throw new ArgumentException(nameof(context));
            }
            MissionRoleConfiguration roles = context.Attempt.RoleConfig ?? MissionRoleConfiguration.Default;
            return context.Attempt with
            {
                RoleConfig = roles with
                {
                    FirstFourTricksWinnerSeat = (byte)context.FirstFourTricksWinnerSeat,
                    LastTrickWinnerSeat = (byte)context.LastTrickWinnerSeat
                },
                Phase = MissionAttemptPhase.PlayingTricks
            };
        }

        public static byte? GetRequiredHeartCaptureSeat(MissionRoleConfiguration roles, int participantCount)
        {
            byte? requiredSeat = null;
            if (roles?.HeartNineOwnerSeat.HasValue == true)
            {
                requiredSeat = ParticipantSeatRules.GetNextClockwiseSeat(roles.HeartNineOwnerSeat.Value,
                    participantCount);
            }
            return requiredSeat;
        }
    }
}
