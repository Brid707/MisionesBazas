using System;

namespace Application.Models
{
    /// <summary>Describes a draft request after transport-to-application mapping.</summary>
    public sealed record ObjectiveDraftSubmission
    {
        public string LobbyCode { get; init; }

        public Guid MatchId { get; init; }

        public int MissionAttemptId { get; init; }

        public Guid ObjectiveDraftSubmissionId { get; init; }

        public long ExpectedMatchStateVersion { get; init; }

        public ObjectiveDraftAction ObjectiveDraftAction { get; init; }

        public Guid? SelectedMissionObjectiveId { get; init; }
    }
}
