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
        /// Updates the last login timestamp of the specified user to the current UTC time.
        /// </summary>
        /// <param name="userId">The unique identifier of the user.</param>
        /// <exception cref="InvalidOperationException">Thrown when a persistence update error occurs.</exception>
        void UpdateLastLogin(int userId);
    }
}
