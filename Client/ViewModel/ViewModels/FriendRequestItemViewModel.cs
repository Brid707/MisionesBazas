using System;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model representing a pending incoming or outgoing friend request row.
    /// </summary>
    public sealed class FriendRequestItemViewModel : ViewModelBase
    {
        public FriendRequestItemViewModel(
            int senderUserId,
            string senderUsername,
            int receiverUserId,
            string receiverUsername,
            DateTime requestedAt)
        {
            SenderUserId = senderUserId;
            SenderUsername = senderUsername ?? string.Empty;
            ReceiverUserId = receiverUserId;
            ReceiverUsername = receiverUsername ?? string.Empty;
            RequestedAt = requestedAt;
        }

        public int SenderUserId { get; }

        public string SenderUsername { get; }

        public int ReceiverUserId { get; }

        public string ReceiverUsername { get; }

        public DateTime RequestedAt { get; }
    }
}
