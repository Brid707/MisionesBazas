using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>
    /// Identifies business validation failures for distress signal operations without exposing internal server state.
    /// </summary>
    [DataContract]
    public enum DistressSignalFailureReason
    {
        [EnumMember] None = 0,
        [EnumMember] InvalidSubmission = 1,
        [EnumMember] MatchUnavailable = 2,
        [EnumMember] ParticipantNotAllowed = 3,
        [EnumMember] WrongMissionAttempt = 4,
        [EnumMember] MissionPreparationRequired = 5,
        [EnumMember] MissionAttemptFinished = 6,
        [EnumMember] DistressAlreadyUsed = 7,
        [EnumMember] TrickAlreadyStarted = 8,
        [EnumMember] RadioAlreadyUsed = 9,
        [EnumMember] CardNotInHand = 10,
        [EnumMember] SpecialCardNotAllowed = 11,
        [EnumMember] InvalidStepTransition = 12,
        [EnumMember] OperationUnavailable = 13
    }
}
