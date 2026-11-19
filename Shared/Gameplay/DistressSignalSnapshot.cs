using System.Runtime.Serialization;
using TrickTakingMissions.Rules.Enums;

namespace Gameplay
{
    /// <summary>
    /// Represents the public status of the distress signal mechanic for the active attempt.
    /// </summary>
    [DataContract]
    public sealed class DistressSignalSnapshot
    {
        [DataMember(Order = 1)]
        public bool HasUsedDistressSignal { get; set; }

        [DataMember(Order = 2)]
        public bool IsInProgress { get; set; }

        [DataMember(Order = 3)]
        public PassDirection AgreedDirection { get; set; }

        [DataMember(Order = 4)]
        public int[] SubmittedParticipantUserIds { get; set; }

        [DataMember(Order = 5)]
        public int InitiatorUserId { get; set; }

        [DataMember(Order = 6)]
        public string InitiatorPlayerName { get; set; }

        [DataMember(Order = 7)]
        public bool HasBeenRejected { get; set; }

        [DataMember(Order = 8)]
        public DistressSignalStep CurrentStep { get; set; }

        [DataMember(Order = 9)]
        public int[] VotedYesUserIds { get; set; }

        [DataMember(Order = 10)]
        public int LeftDirectionVotesCount { get; set; }

        [DataMember(Order = 11)]
        public int RightDirectionVotesCount { get; set; }

        [DataMember(Order = 12)]
        public int[] DirectionVotedUserIds { get; set; }
    }
}
