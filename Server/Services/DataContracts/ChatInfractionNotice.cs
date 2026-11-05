using System.Runtime.Serialization;
using System;


namespace Services.DataContracts
{
    /// <summary>Communicates private per-message and accumulated chat infraction totals.</summary>
    [DataContract]
    public sealed class ChatInfractionNotice
    {
        [DataMember(Order = 1)]
        public Guid ChatMessageSubmissionId { get; set; }

        [DataMember(Order = 2)]
        public int CurrentMessageInfractionPoints { get; set; }

        [DataMember(Order = 3)]
        public int AccumulatedChatInfractionPoints { get; set; }

        [DataMember(Order = 4)]
        public int ChatInfractionPointThreshold { get; set; }

        [DataMember(Order = 5)]
        public int RemainingChatInfractionPointsBeforeBan { get; set; }

        [DataMember(Order = 6)]
        public int ThreateningChatMessageCount { get; set; }
    }
}
