
namespace Application.Models
{
    /// <summary>
    /// Represents the public status of the distress signal mechanic for the active attempt.
    /// </summary>
    public sealed class DistressSignalSnapshot
    {
        public bool HasUsedDistressSignal { get; set; }

        public bool IsInProgress { get; set; }

        public DistressPassDirection AgreedDirection { get; set; }

        public int[] SubmittedParticipantUserIds { get; set; }

        public int InitiatorUserId { get; set; }

        public string InitiatorPlayerName { get; set; }

        public bool HasBeenRejected { get; set; }

        public DistressSignalPhase CurrentStep { get; set; }

        public int[] VotedYesUserIds { get; set; }

        public int LeftDirectionVotesCount { get; set; }

        public int RightDirectionVotesCount { get; set; }

        public int[] DirectionVotedUserIds { get; set; }
    }
}
