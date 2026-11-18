using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>Publishes chat rejection reasons while preserving the established XML contract identity.</summary>
    [DataContract(Name = "ChatMessageRejectionReason",
        Namespace = "http://schemas.datacontract.org/2004/07/Application.Models")]
    public enum LobbyChatMessageRejectionReason
    {
        [EnumMember]
        None = 0,

        [EnumMember]
        InvalidChatMessage = 1,

        [EnumMember]
        ChatAuthenticationRequired = 2,

        [EnumMember]
        ChatParticipantNotInLobby = 3,

        [EnumMember]
        ChatStorageUnavailable = 4,

        [EnumMember]
        ChatModerationUnavailable = 5,

        [EnumMember]
        ConflictingChatMessageIdentifier = 6,

        [EnumMember]
        ChatAccountBanned = 7,

        [EnumMember]
        ChatDeliveryUnknown = 8
    }
}
