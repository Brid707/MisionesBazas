using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    [DataContract]
    public enum RadioCommunicationFailureReason
    {
        [EnumMember] None = 0,
        [EnumMember] InvalidSubmission = 1,
        [EnumMember] MatchUnavailable = 2,
        [EnumMember] ParticipantNotAllowed = 3,
        [EnumMember] WrongMissionAttempt = 4,
        [EnumMember] SubmissionIdentityReused = 5,
        [EnumMember] StaleMatchState = 6,
        [EnumMember] MissionPreparationRequired = 7,
        [EnumMember] MissionAttemptFinished = 8,
        [EnumMember] CardNotInHand = 9,
        [EnumMember] SpecialCardNotAllowed = 10,
        [EnumMember] AlreadyCommunicatedThisAttempt = 11,
        [EnumMember] CannotCommunicateDuringActiveTrick = 12,
        [EnumMember] InvalidTokenPositionForCard = 13,
        [EnumMember] RequestLimitReached = 14,
        [EnumMember] OperationUnavailable = 15
    }
}
