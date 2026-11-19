using System;
using System.Collections.Generic;

namespace Application.Models
{
    /// <summary>Identifies the mission attempt and participants whose private deal must be prepared.</summary>
    internal sealed record MissionAttemptPreparationContext
    {
        public int MissionNumber { get; init; }

        public int MissionAttemptId { get; init; }

        public int AttemptNumber { get; init; }

        public int[] ParticipantUserIds { get; init; }
    }
}
