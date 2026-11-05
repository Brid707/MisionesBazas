using System;

namespace Application.Models.Friendship
{
    public sealed class FriendshipRecordData
    {
        public int IdUserLow { get; set; }

        public int IdUserHigh { get; set; }

        public bool IsRequestedByLow { get; set; }

        public byte Status { get; set; }

        public DateTime RequestedAt { get; set; }

        public DateTime? RespondedAt { get; set; }
    }
}
