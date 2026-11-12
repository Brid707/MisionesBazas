using System;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace TrickTakingMissions.Logging.Abstractions
{
    /// <summary>No-op logger implementation reserved for isolated unit tests and XAML design-time rendering.</summary>
    public sealed class NullLoggerService : ILoggerService
    {
        public static ILoggerService Instance { get; } = new NullLoggerService();

        private NullLoggerService()
        {
        }

        public void Trace(string messageTemplate, params object[] messageArguments)
        {
        }

        public void Debug(string messageTemplate, params object[] messageArguments)
        {
        }

        public void Information(string messageTemplate, params object[] messageArguments)
        {
        }

        public void Warning(string messageTemplate, params object[] messageArguments)
        {
        }

        public void Error(string messageTemplate, params object[] messageArguments)
        {
        }

        public void Error(Exception exception, string messageTemplate, params object[] messageArguments)
        {
        }

        public void Fatal(string messageTemplate, params object[] messageArguments)
        {
        }

        public void Fatal(Exception exception, string messageTemplate, params object[] messageArguments)
        {
        }
    }
}
