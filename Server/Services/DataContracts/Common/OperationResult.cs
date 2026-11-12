using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Represents the base result contract for non-generic service operations.
    /// </summary>
    [DataContract]
    [KnownType(typeof(LobbyResult))]
    public class OperationResult
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public int ErrorCode { get; set; }
    }
}
