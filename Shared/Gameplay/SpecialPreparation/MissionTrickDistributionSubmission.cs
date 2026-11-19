using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies one final-mission preparation intention without sending private hands.</summary>
    [DataContract]
    public sealed class MissionTrickDistributionSubmission
    {
        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public Guid MissionPreparationStageId { get; set; }

        [DataMember(Order = 5)]
        public Guid MissionPreparationSubmissionId { get; set; }

        [DataMember(Order = 6)]
        public long ExpectedMatchStateVersion { get; set; }

        [DataMember(Order = 7)]
        public int FirstFourTricksWinnerParticipantUserId { get; set; }

        [DataMember(Order = 8)]
        public int LastTrickWinnerParticipantUserId { get; set; }
    }
}
