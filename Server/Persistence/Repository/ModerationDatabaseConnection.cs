using System.Data.SqlClient;

using Persistence.Entities;

namespace Persistence.Repository
{
    /// <summary>Opens the configured moderation connection without maintaining a second connection string.</summary>
    internal static class ModerationDatabaseConnection
    {
        internal static SqlConnection Open()
        {
            string moderationConnectionString;
            using (TrickTakingMissionsBDEntities databaseContext = new TrickTakingMissionsBDEntities())
            {
                moderationConnectionString = databaseContext.Database.Connection.ConnectionString;
            }

            SqlConnection moderationConnection = new SqlConnection(moderationConnectionString);
            try
            {
                moderationConnection.Open();
            }
            catch (SqlException)
            {
                moderationConnection.Dispose();
                throw;
            }

            return moderationConnection;
        }
    }
}
