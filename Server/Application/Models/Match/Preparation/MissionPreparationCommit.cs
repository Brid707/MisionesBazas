using System;
using System.Collections.Generic;
using Domain;
using TrickTakingMissions.Rules.Enums;

namespace Application.Models
{
    /// <summary>Groups an immutable preparation request or staged state change inside Application.</summary>
    public sealed record MissionPreparationCommit
    {
        public Guid MissionPreparationSubmissionId { get; init; }

        public long CommittedMatchStateVersion { get; init; }

        public bool HasStateChanged { get; init; }

        public MissionPreparationRejection Rejection { get; init; }
    }
}
