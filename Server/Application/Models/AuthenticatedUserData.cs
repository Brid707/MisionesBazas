namespace Application.Models
{
    /// <summary>
    /// Represents authenticated user data transferred across application layers.
    /// </summary>
    public sealed class AuthenticatedUserData
    {
        public int IdUser { get; set; }

        public string Username { get; set; }

        public string Email { get; set; }
    }
}
