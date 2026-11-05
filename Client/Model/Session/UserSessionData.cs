namespace Model.Session
{
    /// <summary>
    /// Represents the profile and identity data for an active user session.
    /// </summary>
    public sealed class UserSessionData
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

        public string AccountSessionToken { get; set; }
    }
}
