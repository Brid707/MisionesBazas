using System;
using System.Collections.Generic;
using Domain;
using TrickTakingMissions.Rules.Enums;

namespace Application.Models
{
    /// <summary>Groups an immutable preparation request or staged state change inside Application.</summary>
    public sealed record MissionPreparationRequest
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public Guid MissionPreparationStageId { get; init; }

        public Guid MissionPreparationSubmissionId { get; init; }

        public long ExpectedMatchStateVersion { get; init; }

        public MissionPreparationAction Action { get; init; }

        public int SelectedParticipantUserId { get; init; }

        public BlindObjectiveCapableResponse Response { get; init; }
    }
}
