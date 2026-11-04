using System;
using System.Threading.Tasks;

namespace Model.Services
{
    /// <summary>
    /// Encapsulates the result of an account registration attempt returned to the client model.
    /// </summary>
    public sealed class AccountRegistrationResult
    {
        public bool IsSuccess { get; set; }

        public int ErrorCode { get; set; }

        public string Message { get; set; }
    }

    /// <summary>
    /// Service client contract for dispatching user registration requests across WCF.
    /// </summary>
    public interface IAccountManagementClient : IDisposable
    {
        /// <summary>
        /// Occurs when a network or communication fault prevents completing the request.
        /// </summary>
        event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        /// <summary>
        /// Dispatches a user registration request to the server asynchronously.
        /// </summary>
        /// <param name="username">The requested account username.</param>
        /// <param name="email">The email address of the account.</param>
        /// <param name="passwordHash">The pre-hashed password string.</param>
        /// <returns>A task yielding the registration outcome result.</returns>
        Task<AccountRegistrationResult> RegisterUserAsync(string username, string email, string passwordHash);
    }
}
