using System;
using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Defines the secondary port for querying and persisting user account data.
    /// </summary>
    public interface IUserRepository
    {
        /// <summary>
        /// Retrieves a user account matching the specified email address.
        /// </summary>
        /// <param name="email">The email address of the user to find.</param>
        /// <returns>The <see cref="UserAccount"/> if found; otherwise, null.</returns>
        /// <exception cref="InvalidOperationException">Thrown when a persistence access error occurs.</exception>
        UserAccount GetUserByEmail(string email);

        /// <summary>
        /// Retrieves a user account matching the specified unique user identifier.
        /// </summary>
        /// <param name="userId">The unique identifier of the user to find.</param>
        /// <returns>The <see cref="UserAccount"/> if found; otherwise, null.</returns>
        /// <exception cref="InvalidOperationException">Thrown when a persistence access error occurs.</exception>
        UserAccount GetUserById(int userId);

        /// <summary>
        /// Retrieves a user account matching the specified username.
        /// </summary>
        /// <param name="username">The username of the user to find.</param>
        /// <returns>The <see cref="UserAccount"/> if found; otherwise, null.</returns>
        /// <exception cref="InvalidOperationException">Thrown when a persistence access error occurs.</exception>
        UserAccount GetUserByUsername(string username);

        /// <summary>
        /// Updates the last login timestamp of the specified user to the current UTC time.
        /// </summary>
        /// <param name="userId">The unique identifier of the user.</param>
        /// <exception cref="InvalidOperationException">Thrown when a persistence update error occurs.</exception>
        void UpdateLastLogin(int userId);

        /// <summary>
        /// Persists a new user account along with their initial profile and experience records.
        /// </summary>
        /// <param name="user">The domain user account entity containing credentials and status.</param>
        /// <param name="displayName">The default display name assigned to the player's initial profile.</param>
        /// <returns>The generated unique identifier of the created user.</returns>
        /// <exception cref="InvalidOperationException">Thrown when a persistence access or constraint error occurs.</exception>
        int CreateUser(UserAccount user, string displayName);
    }
}
