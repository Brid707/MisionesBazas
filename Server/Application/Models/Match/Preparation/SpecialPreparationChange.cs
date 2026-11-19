using System;
using System.Collections.Generic;
using Domain;
using TrickTakingMissions.Rules.Enums;

namespace Application.Models
{
    /// <summary>Groups an immutable preparation request or staged state change inside Application.</summary>
    public sealed record SpecialPreparationChange
    {
        public MissionAttemptState UpdatedAttempt { get; init; }

        public IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> ResponsesBySeat { get; init; }

        public bool HasStageChanged { get; init; }
    }
}
