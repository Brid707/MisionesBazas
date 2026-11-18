using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Describes public mission evaluation with explicit serialized values.</summary>
    [DataContract]
    public enum MissionEvaluationFailureReason
    {
        [EnumMember] None = 0,
        [EnumMember] ObjectiveCapturedByWrongSeat = 1,
        [EnumMember] MultipleOrderedTokensInSameTrick = 2,
        [EnumMember] MultipleArrowTokensInSameTrick = 3,
        [EnumMember] OmegaSimultaneousCompletion = 4,
        [EnumMember] PrecedingOrderTokenNotCompleted = 5,
        [EnumMember] PrecedingArrowTokenNotCompleted = 6,
        [EnumMember] OmegaObjectiveNotCompletedLast = 7,
        [EnumMember] ObjectivesIncompleteAtMissionEnd = 8,
        [EnumMember] Mission48OmegaNotInLastTrick = 9,
        [EnumMember] Mission48PendingNonOmegaBeforeLastTrick = 10,
        [EnumMember] SpecialMissionConstraint = 11,
        [EnumMember] AllParticipantsWonAtLeastOneTrick = 12
    }
}
