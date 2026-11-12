using System;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace TrickTakingMissions.Logging.Abstractions
{
    /// <summary>Returns <see cref="NullLoggerService.Instance"/> for isolated unit tests and XAML design mode.</summary>
    public sealed class NullLoggerFactory : ILoggerFactory
    {
        public static ILoggerFactory Instance { get; } = new NullLoggerFactory();

        private NullLoggerFactory()
        {
        }

        public ILoggerService CreateLogger(Type callerType)
        {
            return NullLoggerService.Instance;
        }

        public ILoggerService CreateLogger<TCaller>()
        {
            return NullLoggerService.Instance;
        }
    }
}
