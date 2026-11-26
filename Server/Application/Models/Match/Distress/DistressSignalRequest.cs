using System;
using TrickTakingMissions.Rules.Enums;

using Domain;

namespace Application.Models
{
    /// <summary>
    /// Encapsulates a participant's distress signal action request within the application boundary.
    /// </summary>
    public sealed record DistressSignalRequest
    {
        public Guid MatchId { get; init; }

        public string LobbyCode { get; init; }

        public int MissionAttemptId { get; init; }

        public int CardIdToPass { get; init; }

        public PassDirection SelectedDirection { get; init; }

        public bool IsVoteAccepted { get; init; }

        public DistressSignalActionType ActionType { get; init; }
    }
}
