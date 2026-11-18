using Application.Models;
using Services.DataContracts;

namespace Services.Mapping
{
    internal static class LobbyChatMessageRejectionMapper
    {
        internal static LobbyChatMessageRejectionReason MapRejectionReason(
            ChatMessageRejectionReason applicationRejectionReason)
        {
            LobbyChatMessageRejectionReason contractRejectionReason;
            switch (applicationRejectionReason)
            {
                case ChatMessageRejectionReason.None:
                    contractRejectionReason = LobbyChatMessageRejectionReason.None;
                    break;
                case ChatMessageRejectionReason.InvalidChatMessage:
                    contractRejectionReason = LobbyChatMessageRejectionReason.InvalidChatMessage;
                    break;
                case ChatMessageRejectionReason.ChatAuthenticationRequired:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatAuthenticationRequired;
                    break;
                case ChatMessageRejectionReason.ChatParticipantNotInLobby:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatParticipantNotInLobby;
                    break;
                case ChatMessageRejectionReason.ChatStorageUnavailable:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatStorageUnavailable;
                    break;
                case ChatMessageRejectionReason.ChatModerationUnavailable:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatModerationUnavailable;
                    break;
                case ChatMessageRejectionReason.ConflictingChatMessageIdentifier:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ConflictingChatMessageIdentifier;
                    break;
                case ChatMessageRejectionReason.ChatAccountBanned:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatAccountBanned;
                    break;
                case ChatMessageRejectionReason.ChatDeliveryUnknown:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatDeliveryUnknown;
                    break;
                default:
                    contractRejectionReason = LobbyChatMessageRejectionReason.ChatDeliveryUnknown;
                    break;
            }

            return contractRejectionReason;
        }
    }
}
