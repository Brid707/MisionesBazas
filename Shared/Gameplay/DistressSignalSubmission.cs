using System;
using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Identifies a player's distress signal vote and card pass selection.
    /// </summary>
    [DataContract]
    public sealed class DistressSignalSubmission
    {
        [DataMember(Order = 1)]
        public Guid MatchId { get; set; }

        [DataMember(Order = 2)]
        public string LobbyCode { get; set; }

        [DataMember(Order = 3)]
        public int MissionAttemptId { get; set; }

        [DataMember(Order = 4)]
        public int CardIdToPass { get; set; }

        [DataMember(Order = 5)]
        public DistressPassDirection SelectedDirection { get; set; }

        [DataMember(Order = 6)]
        public bool IsVoteAccepted { get; set; } = true;

        [DataMember(Order = 7)]
        public DistressSignalActionType ActionType { get; set; }
    }
}
