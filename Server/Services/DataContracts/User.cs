using System.Runtime.Serialization;

namespace Services.DTO
{
    /// <summary>
    /// Data transfer object representing authenticated user profile information.
    /// </summary>
    [DataContract]
    public sealed class User
    {
        [DataMember]
        public int IdUser { get; set; }

        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public string Email { get; set; }
    }
}
