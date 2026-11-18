namespace TrickTakingMissions.Rules.Enums
{
    /// <summary>
    /// Specifies the domain reason why an attempted radio communication was rejected.
    /// </summary>
    public enum RadioCommunicationRejectionReason
    {
        None = 0,
        CardNotInHand = 1,
        SpecialCardNotAllowed = 2,
        AlreadyCommunicatedThisAttempt = 3,
        CannotCommunicateDuringActiveTrick = 4,
        DisruptedUntilTrick = 5,
        SilencedByCaptain = 6,
        InvalidTokenPositionForCard = 7
    }
}
