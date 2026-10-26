using System;
using System.Data.Entity.Core;
using System.Data.SqlClient;
using System.Linq;
using Persistence.Entities;

namespace Persistence.Repository
{
    /// <summary>
    /// Provides data access operations for user accounts in the database.
    /// </summary>
    public sealed class UserRepository
    {
        /// <summary>
        /// Retrieves a user from the database matching the provided email address.
        /// </summary>
        /// <param name="email">The email address of the user to find.</param>
        /// <returns>The User entity if found; otherwise, null.</returns>
        /// <exception cref="InvalidOperationException">Thrown when a database connection or execution failure occurs.</exception>
        public User GetUserByEmail(string email)
        {
            User foundUser = null;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<User> query = from user in context.User
                                             where user.Email == email
                                             select user;
                    foundUser = query.FirstOrDefault();
                }
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to execute query in the database.", ex);
            }

            return foundUser;
        }

        /// <summary>
        /// Updates the last login timestamp for the specified user to UTC now.
        /// </summary>
        /// <param name="userId">The unique identifier of the user.</param>
        /// <exception cref="InvalidOperationException">Thrown when a database update failure occurs.</exception>
        public void UpdateLastLogin(int userId)
        {
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    User user = context.User.Find(userId);
                    if (user != null)
                    {
                        user.LastLoginAt = DateTime.UtcNow;
                        context.SaveChanges();
                    }
                }
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to update user session in the database.", ex);
            }
        }
    }
}
