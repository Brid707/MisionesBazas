using System.Runtime.Serialization;

namespace Services.DataContracts.Friendship
{
    [DataContract]
    public sealed class GameInvitation
    {
        [DataMember]
        public int CurrentPlayerCount { get; set; }

        [DataMember]
        public string LobbyCode { get; set; }

        [DataMember]
        public byte PlayerLimit { get; set; }

        [DataMember]
        public int ReceiverUserId { get; set; }

        [DataMember]
        public int SenderUserId { get; set; }

        [DataMember]
        public string SenderUsername { get; set; }

        [DataMember]
        public byte TargetMissionCount { get; set; }
    }
}
