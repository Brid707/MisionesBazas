using System;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using Application.Models;
using Persistence.Entities;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Persistence.Repository
{
    internal static class PlayerProfileDatabaseAccess
    {
        private const int ConnectionTimeoutSeconds = 4;
        private const int CommandTimeoutSeconds = 5;
        private const string DatabaseUnavailableMessage = "Profile persistence is unavailable.";
        private const string DatabaseFailureTemplate = "Profile persistence failed with {ExceptionType}.";

        internal static T Execute<T>(Func<TrickTakingMissionsBDEntities, T> profileOperation, ILoggerService logger)
        {
            T profileResult;
            try
            {
                using (var context = new TrickTakingMissionsBDEntities())
                {
                    var sqlConnection = new SqlConnectionStringBuilder(context.Database.Connection.ConnectionString)
                    {
                        ConnectTimeout = ConnectionTimeoutSeconds,
                        ConnectRetryCount = 0
                    };
                    context.Database.Connection.ConnectionString = sqlConnection.ConnectionString;
                    context.Database.CommandTimeout = CommandTimeoutSeconds;
                    profileResult = profileOperation(context);
                }
            }
            catch (EntityException ex)
            {
                throw TranslateDatabaseFailure(ex, logger);
            }
            catch (DbUpdateException ex)
            {
                throw TranslateDatabaseFailure(ex, logger);
            }
            catch (SqlException ex)
            {
                throw TranslateDatabaseFailure(ex, logger);
            }
            catch (InvalidOperationException ex)
            {
                throw TranslateDatabaseFailure(ex, logger);
            }
            return profileResult;
        }

        private static PlayerProfileUnavailableException TranslateDatabaseFailure(Exception failure,
            ILoggerService logger)
        {
            logger.Error(failure, DatabaseFailureTemplate, failure.GetType().Name);
            return new PlayerProfileUnavailableException(DatabaseUnavailableMessage, failure);
        }
    }
}
