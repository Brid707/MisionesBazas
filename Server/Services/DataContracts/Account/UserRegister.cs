using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Data transfer object carrying credentials and details for user account registration.
    /// </summary>
    [DataContract]
    public sealed class UserRegister
    {
        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string PasswordHash { get; set; }
    }
}
