using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Services.DataContracts.Friendship
{
    [DataContract]
    public sealed class FriendRequest
    {
        [DataMember]
        public int SenderUserId { get; set; }

        [DataMember]
        public string SenderUsername { get; set; }

        [DataMember]
        public int ReceiverUserId { get; set; }

        [DataMember]
        public string ReceiverUsername { get; set; }

        [DataMember]
        public byte Status { get; set; }

        [DataMember]
        public DateTime RequestedAt { get; set; }
    }
}
