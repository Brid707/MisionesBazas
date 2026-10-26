namespace Application.Models
{
    /// <summary>
    /// Represents authenticated user data transfered across application layers.
    /// </summary>
    public sealed class AuthenticatedUserData
    {
        /// <summary>
        /// Gets or sets the unique identifier of the user.
        /// </summary>
        public int IdUser { get; set; }

        /// <summary>
        /// Gets or sets the username of the user.
        /// </summary>
        public string Username { get; set; }

        /// <summary>
        /// Gets or sets the email address of the user.
        /// </summary>
        public string Email { get; set; }
    }
}
