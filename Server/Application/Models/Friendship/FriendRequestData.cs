using System;

namespace Application.Models.Friendship
{
    public sealed class FriendRequestData
    {
        public int SenderIdUser { get; set; }

        public string SenderUsername { get; set; }

        public int ReceiverIdUser { get; set; }

        public string ReceiverUsername { get; set; }

        public byte Status { get; set; }

        public DateTime RequestDate { get; set; }
    }
}
