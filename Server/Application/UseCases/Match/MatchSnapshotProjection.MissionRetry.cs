using System;
using System.Collections.Generic;
using Application.Models;
using Gameplay;

namespace Application.UseCases
{
    internal static partial class MatchSnapshotProjection
    {
        private static readonly IReadOnlyDictionary<MissionRetryScheduleStatus, MissionRetryStatus> s_retryStatuses =
            new Dictionary<MissionRetryScheduleStatus, MissionRetryStatus>
            {
                { MissionRetryScheduleStatus.Inactive, MissionRetryStatus.Inactive },
                { MissionRetryScheduleStatus.WaitingForParticipants, MissionRetryStatus.WaitingForParticipants },
                { MissionRetryScheduleStatus.CountingDown, MissionRetryStatus.CountingDown },
                { MissionRetryScheduleStatus.Preparing, MissionRetryStatus.Preparing },
                { MissionRetryScheduleStatus.PreparationFailed, MissionRetryStatus.PreparationFailed },
                { MissionRetryScheduleStatus.AttemptLimitReached, MissionRetryStatus.AttemptLimitReached }
            };

        private static MissionRetrySnapshot CreateMissionRetry(MatchState matchState, long serverTimestampMilliseconds)
        {
            long remainingMilliseconds = Math.Max(0,
                matchState.MissionRetryDeadlineMilliseconds - serverTimestampMilliseconds);
            return new MissionRetrySnapshot
            {
                MissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                AttemptNumber = matchState.MissionAttempt.AttemptNumber,
                IsRetryAvailable = false,
                ReadyParticipantUserIds = Array.Empty<int>(),
                AvailableMissionRetrySubmissionId = null,
                Status = s_retryStatuses[matchState.MissionRetryStatus],
                MissionRetryScheduleId = matchState.MissionRetryScheduleId,
                RemainingDelayMilliseconds = (int)Math.Min(remainingMilliseconds,
                    MissionRetryPolicy.CountdownMilliseconds),
                MissingParticipantUserIds = (int[])matchState.MissingRetryParticipantUserIds.Clone()
            };
        }
    }
}
