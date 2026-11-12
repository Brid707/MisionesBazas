using System;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace TrickTakingMissions.Logging
{
    /// <summary>Creates <see cref="LoggerService"/> instances backed by log4net.</summary>
    public sealed class LoggerFactory : ILoggerFactory
    {
        public ILoggerService CreateLogger(Type callerType)
        {
            return new LoggerService(callerType);
        }

        public ILoggerService CreateLogger<TCaller>()
        {
            return new LoggerService(typeof(TCaller));
        }
    }
}
