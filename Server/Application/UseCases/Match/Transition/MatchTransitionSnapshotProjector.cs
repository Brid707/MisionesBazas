using System;
using System.Collections.Generic;
using Application.Models;
using Gameplay;

namespace Application.UseCases
{
    internal static class MatchTransitionSnapshotProjector
    {
        private static readonly IReadOnlyDictionary<MissionTransitionScheduleStatus,
            MissionTransitionStatus> s_transitionStatuses =
            new Dictionary<MissionTransitionScheduleStatus, MissionTransitionStatus>
            {
                { MissionTransitionScheduleStatus.Inactive, MissionTransitionStatus.Inactive },
                { MissionTransitionScheduleStatus.WaitingForParticipants,
                    MissionTransitionStatus.WaitingForParticipants },
                { MissionTransitionScheduleStatus.CountingDown, MissionTransitionStatus.CountingDown },
                { MissionTransitionScheduleStatus.Preparing, MissionTransitionStatus.Preparing },
                { MissionTransitionScheduleStatus.PreparationFailed, MissionTransitionStatus.PreparationFailed },
                { MissionTransitionScheduleStatus.AttemptLimitReached, MissionTransitionStatus.AttemptLimitReached },
                { MissionTransitionScheduleStatus.CampaignCompleted, MissionTransitionStatus.CampaignCompleted },
                { MissionTransitionScheduleStatus.MissionUnavailable, MissionTransitionStatus.MissionUnavailable }
            };

        internal static MissionTransitionKind GetTransitionKind(MissionTransitionAction transitionAction)
        {
            MissionTransitionKind transitionKind = MissionTransitionKind.None;
            if (transitionAction == MissionTransitionAction.RetryCurrentMission)
            {
                transitionKind = MissionTransitionKind.RetryCurrentMission;
            }
            else if (transitionAction == MissionTransitionAction.AdvanceToNextMission)
            {
                transitionKind = MissionTransitionKind.AdvanceToNextMission;
            }
            return transitionKind;
        }

        internal static MissionTransitionSnapshot CreateMissionTransition(MatchState matchState,
            long serverTimestampMilliseconds)
        {
            long remainingMilliseconds = Math.Max(0,
                matchState.MissionTransitionDeadlineMilliseconds - serverTimestampMilliseconds);
            return new MissionTransitionSnapshot
            {
                MissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                AttemptNumber = matchState.MissionAttempt.AttemptNumber,
                Kind = GetTransitionKind(matchState.TransitionAction),
                DestinationMissionNumber = matchState.DestinationMissionNumber,
                TargetMissionCount = matchState.TargetMissionCount,
                Status = s_transitionStatuses[matchState.MissionTransitionStatus],
                MissionTransitionScheduleId = matchState.MissionTransitionScheduleId,
                RemainingDelayMilliseconds = (int)Math.Min(remainingMilliseconds,
                    MissionTransitionPolicy.CountdownMilliseconds),
                MissingParticipantUserIds = (int[])matchState.MissingTransitionParticipantUserIds.Clone()
            };
        }
    }
}
