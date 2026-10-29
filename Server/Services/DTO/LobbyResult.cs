using System.Runtime.Serialization;

namespace Services.DTO
{
    /// <summary>
    /// Represents the specialized result contract for lobby room operations.
    /// </summary>
    [DataContract]
    public sealed class LobbyResult : OperationResult
    {
        [DataMember]
        public Lobby Lobby { get; set; }
    }
}
