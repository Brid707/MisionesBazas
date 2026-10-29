using System;
using System.Data.Entity.Core;
using System.Data.SqlClient;
using System.Linq;
using Application.Models;
using Application.Ports;
using Persistence.Entities;

namespace Persistence.Repository
{
    /// <summary>
    /// Provides data access operations for user accounts, implementing the <see cref="IUserRepository"/> port.
    /// </summary>
    public sealed class UserRepository : IUserRepository
    {
        public UserAccount GetUserByEmail(string email)
        {
            UserAccount foundUserAccount = null;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<User> query = from user in context.User
                                             where user.Email == email
                                             select user;
                    User foundUser = query.FirstOrDefault();

                    if (foundUser != null)
                    {
                        foundUserAccount = MapToDomainModel(foundUser);
                    }
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

            return foundUserAccount;
        }

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

        private static UserAccount MapToDomainModel(User entity)
        {
            return new UserAccount
            {
                IdUser = entity.IdUser,
                Username = entity.Username,
                Email = entity.Email,
                PasswordHash = entity.PasswordHash,
                Status = entity.Status,
                CreatedAt = entity.CreatedAt,
                LastLoginAt = entity.LastLoginAt
            };
        }
    }
}
