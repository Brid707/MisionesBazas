using System;
using System.Collections.Generic;
using Domain;
using TrickTakingMissions.Rules.Enums;

namespace Application.Models
{
    /// <summary>Groups an immutable preparation request or staged state change inside Application.</summary>
    public sealed record PreparedTrickEvaluation
    {
        public MissionEvaluationContext Context { get; init; }

        public MissionTrickStatistics Statistics { get; init; }
    }
}
