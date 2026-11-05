
using System;

using Application.Models;
using Application.Ports;

namespace ChatModeration.Tests
{
    internal sealed class TestUserRepository : IUserRepository
    {
        public UserAccount GetUserById(int userId)
        {
            return new UserAccount { IdUser = userId, Username = "Player" + userId };
        }

        public UserAccount GetUserByEmail(string email)
        {
            return new UserAccount { IdUser = 1, Username = "Player1", PasswordHash = "test-password-hash" };
        }

        public void UpdateLastLogin(int userId)
        {
        }

        public UserAccount GetUserByUsername(string username)
        {
            throw new NotSupportedException("Chat tests do not query registration usernames.");
        }

        public int CreateUser(UserAccount user, string displayName)
        {
            throw new NotSupportedException("Chat tests do not create registered accounts.");
        }
    }
}
