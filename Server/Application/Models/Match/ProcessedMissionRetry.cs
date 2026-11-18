using System;
using System.Collections.Generic;

namespace Application.Models
{
    /// <summary>Stores one participant request and its stable confirmation.</summary>
    public sealed record ProcessedMissionRetry
    {
        public int ParticipantUserId { get; init; }

        public MissionRetryRequest MissionRetryRequest { get; init; }

        public MissionRetryConfirmation MissionRetryConfirmation { get; init; }
    }
}
