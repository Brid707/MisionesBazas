using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Transfers authorized radio communication data on the existing match channel.</summary>
    [DataContract]
    public sealed class RadioCommunicationSubmission
    {
        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public Guid RadioCommunicationSubmissionId { get; set; }

        [DataMember(Order = 5)]
        public long ExpectedMatchStateVersion { get; set; }

        [DataMember(Order = 6)]
        public int CardId { get; set; }

        [DataMember(Order = 7)]
        public RadioCommunicationMarker SelectedMarker { get; set; }
    }
}
