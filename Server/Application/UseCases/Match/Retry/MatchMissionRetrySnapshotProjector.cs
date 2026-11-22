using System;
using System.Collections.Generic;
using Gameplay;

namespace Application.UseCases
{
    internal static class MatchMissionRetrySnapshotProjector
    {
        private static readonly IReadOnlyDictionary<MissionTransitionStatus, MissionRetryStatus> s_legacyRetryStatuses =
            new Dictionary<MissionTransitionStatus, MissionRetryStatus>
            {
                { MissionTransitionStatus.Inactive, MissionRetryStatus.Inactive },
                { MissionTransitionStatus.WaitingForParticipants, MissionRetryStatus.WaitingForParticipants },
                { MissionTransitionStatus.CountingDown, MissionRetryStatus.CountingDown },
                { MissionTransitionStatus.Preparing, MissionRetryStatus.Preparing },
                { MissionTransitionStatus.PreparationFailed, MissionRetryStatus.PreparationFailed },
                { MissionTransitionStatus.AttemptLimitReached, MissionRetryStatus.AttemptLimitReached }
            };

        internal static MissionRetrySnapshot CreateMissionRetry(MissionTransitionSnapshot transition)
        {
            bool isRetry = transition.Kind == MissionTransitionKind.RetryCurrentMission;
            return new MissionRetrySnapshot
            {
                MissionAttemptId = transition.MissionAttemptId,
                AttemptNumber = transition.AttemptNumber,
                ReadyParticipantUserIds = Array.Empty<int>(),
                Status = isRetry ? s_legacyRetryStatuses[transition.Status] : MissionRetryStatus.Inactive,
                MissionRetryScheduleId = isRetry ? transition.MissionTransitionScheduleId : Guid.Empty,
                RemainingDelayMilliseconds = isRetry ? transition.RemainingDelayMilliseconds : 0,
                MissingParticipantUserIds = isRetry ? (int[])transition.MissingParticipantUserIds.Clone() :
                    Array.Empty<int>()
            };
        }
    }
}
