namespace Application.Models
{
    /// <summary>Identifies why a submitted chat message could not be accepted or confirmed.</summary>
    public enum ChatMessageRejectionReason
    {
        None = 0,
        InvalidChatMessage = 1,
        ChatAuthenticationRequired = 2,
        ChatParticipantNotInLobby = 3,
        ChatStorageUnavailable = 4,
        ChatModerationUnavailable = 5,
        ConflictingChatMessageIdentifier = 6,
        ChatAccountBanned = 7,
        ChatDeliveryUnknown = 8
    }
}
