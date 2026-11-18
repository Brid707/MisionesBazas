using System.Runtime.Serialization;

namespace Gameplay
{
    /// <summary>Provides explicit rejection reasons for objective draft actions.</summary>
    [DataContract]
    public enum MissionObjectiveDraftRejectionReason
    {
        [EnumMember]
        None = 0,

        [EnumMember]
        MatchUnavailable = 1,

        [EnumMember]
        ParticipantNotAllowed = 2,

        [EnumMember]
        InvalidSubmission = 3,

        [EnumMember]
        SubmissionIdentityReused = 4,

        [EnumMember]
        StaleMatchState = 5,

        [EnumMember]
        NotDraftTurn = 6,

        [EnumMember]
        ObjectiveUnavailable = 7,

        [EnumMember]
        PreparationCompleted = 8,

        [EnumMember]
        RequestLimitReached = 9,

        [EnumMember]
        UnsupportedDraftMode = 10,

        [EnumMember]
        SubmissionExpired = 11
    }
}
