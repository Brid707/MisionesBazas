namespace Application.Models
{
    /// <summary>
    /// Represents the outcome of a user registration operation executed within the application core.
    /// </summary>
    public sealed class UserRegistrationOutcome
    {
        public bool IsSuccess { get; set; }

        public string Message { get; set; }

        public int ErrorCode { get; set; }

        public int? CreatedUserId { get; set; }
    }
}
