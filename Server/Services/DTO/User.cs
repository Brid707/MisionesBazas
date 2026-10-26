using System.Runtime.Serialization;

namespace Services.DTO
{
    /// <summary>
    /// Data transfer object representing authenticated user profile information.
    /// </summary>
    [DataContract]
    public sealed class User
    {
        /// <summary>
        /// Gets or sets the unique database identifier of the user.
        /// </summary>
        [DataMember]
        public int IdUser { get; set; }

        /// <summary>
        /// Gets or sets the public username of the user.
        /// </summary>
        [DataMember]
        public string Username { get; set; }

        /// <summary>
        /// Gets or sets the registered email address of the user.
        /// </summary>
        [DataMember]
        public string Email { get; set; }
    }
}
