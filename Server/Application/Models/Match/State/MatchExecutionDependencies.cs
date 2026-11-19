using System;

namespace Application.Models
{
    /// <summary>Groups injected match runtime boundaries without extending constructor parameter lists.</summary>
    public sealed record MatchExecutionDependencies
    {
        public Application.Ports.IMatchClock MatchClock { get; init; }

        public Application.Ports.IMatchParticipantPresence ParticipantPresence { get; init; }

        public TrickTakingMissions.Logging.Abstractions.Ports.ILoggerService Logger { get; init; }
    }
}
