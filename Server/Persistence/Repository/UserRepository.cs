using System;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using Application.Models;
using Application.Ports;
using Persistence.Entities;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Persistence.Repository
{
    /// <summary>
    /// Provides data access operations for user accounts, implementing the <see cref="IUserRepository"/> port.
    /// </summary>
    public sealed class UserRepository : IUserRepository
    {
        private readonly ILoggerService _logger;
        private const string GetUserByEmailEntityFailureTemplate =
    "Entity Framework connection failed while querying user by email {Email}.";
        private const string GetUserByEmailSqlFailureTemplate =
            "SQL execution failed while querying user by email {Email}.";

        private const string GetUserByIdEntityFailureTemplate =
            "Entity Framework connection failed while querying user by id {UserId}.";
        private const string GetUserByIdSqlFailureTemplate =
            "SQL execution failed while querying user by id {UserId}.";

        private const string GetUserByUsernameEntityFailureTemplate =
            "Entity Framework connection failed while querying user by username {Username}.";
        private const string GetUserByUsernameSqlFailureTemplate =
            "SQL execution failed while querying user by username {Username}.";

        private const string UpdateLastLoginEntityFailureTemplate =
            "Entity Framework connection failed while updating last login timestamp for user {UserId}.";

        private const string CreateUserDbUpdateFailureTemplate =
            "Database update failed while inserting user account for username {Username}.";
        private const string CreateUserEntityFailureTemplate =
            "Entity Framework connection failed while inserting user account for username {Username}.";
        private const string CreateUserSqlFailureTemplate =
            "SQL execution failed while inserting user account for username {Username}.";

        private const string DatabaseConnectionFailureMessage = "Failed to connect to the database.";
        private const string DatabaseQueryFailureMessage = "Failed to execute query in the database.";
        private const string UpdateUserSessionFailureMessage = "Failed to update user session in the database.";
        private const string InsertUserRecordsFailureMessage = "Failed to insert user account records into " +
            "the database.";
        private const string ExecuteInsertQueryFailureMessage = "Failed to execute insert query in the database.";

        public UserRepository(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

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
                _logger.Error(ex, GetUserByEmailEntityFailureTemplate, email);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetUserByEmailSqlFailureTemplate, email);
                throw new InvalidOperationException(DatabaseQueryFailureMessage, ex);
            }

            return foundUserAccount;
        }

        public UserAccount GetUserById(int userId)
        {
            UserAccount foundUserAccount = null;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    User foundUser = context.User.Find(userId);
                    if (foundUser != null)
                    {
                        foundUserAccount = MapToDomainModel(foundUser);
                    }
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, GetUserByIdEntityFailureTemplate, userId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetUserByIdSqlFailureTemplate, userId);
                throw new InvalidOperationException(DatabaseQueryFailureMessage, ex);
            }

            return foundUserAccount;
        }

        public UserAccount GetUserByUsername(string username)
        {
            UserAccount foundUserAccount = null;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<User> query = from user in context.User
                                             where user.Username == username
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
                _logger.Error(ex, GetUserByUsernameEntityFailureTemplate, username);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetUserByUsernameSqlFailureTemplate, username);
                throw new InvalidOperationException(DatabaseQueryFailureMessage, ex);
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
                _logger.Error(ex, UpdateLastLoginEntityFailureTemplate, userId);
                throw new InvalidOperationException(UpdateUserSessionFailureMessage, ex);
            }
        }

        public int CreateUser(UserAccount user, string displayName)
        {
            if (user == null)
            {
                throw new ArgumentNullException(nameof(user));
            }

            int createdUserId = 0;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    User userEntity = new User
                    {
                        Username = user.Username,
                        Email = user.Email,
                        PasswordHash = user.PasswordHash,
                        Status = user.Status,
                        CreatedAt = user.CreatedAt
                    };

                    context.User.Add(userEntity);
                    context.SaveChanges();

                    if (!string.IsNullOrWhiteSpace(displayName) && !string.Equals(displayName, user.Username,
                        StringComparison.Ordinal))
                    {
                        PlayerProfile profile = context.PlayerProfile.Find(userEntity.IdUser);
                        if (profile != null)
                        {
                            profile.DisplayName = displayName;
                            context.SaveChanges();
                        }
                    }

                    createdUserId = userEntity.IdUser;
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, CreateUserDbUpdateFailureTemplate, user.Username);
                throw new InvalidOperationException(InsertUserRecordsFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, CreateUserEntityFailureTemplate, user.Username);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, CreateUserSqlFailureTemplate, user.Username);
                throw new InvalidOperationException(ExecuteInsertQueryFailureMessage, ex);
            }

            return createdUserId;
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
