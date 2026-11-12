using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Represents the specialized result contract for lobby room operations.
    /// </summary>
    [DataContract]
    public sealed class LobbyResult : OperationResult
    {
        [DataMember]
        public string GuestSessionToken { get; set; }

        [DataMember]
        public Lobby Lobby { get; set; }
    }
}
