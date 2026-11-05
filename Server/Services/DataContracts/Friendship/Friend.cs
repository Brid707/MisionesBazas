using System.Runtime.Serialization;

namespace Services.DataContracts.Friendship
{
    [DataContract]
    public sealed class Friend
    {
        [DataMember]
        public int UserId { get; set; }

        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public bool IsOnline { get; set; }
    }
}
