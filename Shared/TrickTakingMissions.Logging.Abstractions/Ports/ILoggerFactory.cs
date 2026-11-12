using System;

namespace TrickTakingMissions.Logging.Abstractions.Ports
{
    /// <summary>Creates logger instances scoped to the declaring caller type.</summary>
    public interface ILoggerFactory
    {
        ILoggerService CreateLogger(Type callerType);

        ILoggerService CreateLogger<TCaller>();
    }
}
