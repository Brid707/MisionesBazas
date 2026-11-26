using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Identifies an attempted card play and the state on which it was selected.
    /// </summary>
    [DataContract(Namespace = "http://schemas.datacontract.org/2004/07/Gameplay")]
    public sealed class CardPlaySubmission
    {
        [DataMember(Order = 6)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 1)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 2)]
        public System.Guid MatchId { get; set; }

        [DataMember(Order = 3)]
        public System.Guid CardPlaySubmissionId { get; set; }

        [DataMember(Order = 4)]
        public long ExpectedMatchStateVersion { get; set; }

        [DataMember(Order = 5)]
        public int CardId { get; set; }
    }
}
