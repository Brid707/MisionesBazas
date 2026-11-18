using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Submits one identified readiness confirmation for a failed attempt.</summary>
    [DataContract]
    public sealed class MissionRetrySubmission
    {
        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public Guid MissionRetrySubmissionId { get; set; }

        [DataMember(Order = 5)]
        public long ExpectedMatchStateVersion { get; set; }
    }
}
