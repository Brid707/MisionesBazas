using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Data transfer object representing authenticated user profile information.
    /// </summary>
    [DataContract]
    public sealed class User
    {
        [DataMember]
        public ChatAccountBanNotice ChatAccountBanNotice { get; set; }

        [DataMember]
        public int IdUser { get; set; }

        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string AccountSessionToken { get; set; }
    }
}
