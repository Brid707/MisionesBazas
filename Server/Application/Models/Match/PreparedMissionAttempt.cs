using System;
using System.Collections.Generic;

namespace Application.Models
{
    /// <summary>Stages the complete private deal and objective identities before replacing a live attempt.</summary>
    internal sealed record PreparedMissionAttempt
    {
        public Domain.MissionAttemptState MissionAttempt { get; init; }

        public List<int>[] PlayerHandCardIdsBySeat { get; init; }

        public List<int>[] WonCardIdsBySeat { get; init; }

        public int[] WonTrickCountsBySeat { get; init; }

        public int MaximumMissionTrickCount { get; init; }

        public Dictionary<Guid, int> ObjectiveCardIdsByObjectiveId { get; init; }

        public Guid ObjectiveDraftSubmissionId { get; init; }
    }
}
