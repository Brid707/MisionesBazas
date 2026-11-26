using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Identifies a server-issued draft action and the version on which it was requested.</summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class MissionObjectiveDraftSubmission
    {
        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public Guid ObjectiveDraftSubmissionId { get; set; }

        [DataMember(Order = 5)]
        public long ExpectedMatchStateVersion { get; set; }

        [DataMember(Order = 6)]
        public MissionObjectiveDraftAction ObjectiveDraftAction { get; set; }

        [DataMember(Order = 7)]
        public Guid? SelectedMissionObjectiveId { get; set; }
    }
}
