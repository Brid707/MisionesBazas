using System;
using System.ServiceModel;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    /// <summary>
    /// Utility class for safely closing and aborting WCF communication channels.
    /// Implements standard rule 16.3.2 (CloseOrAbort pattern).
    /// </summary>
    public static class GameChannelCloser
    {
        private const string CommunicationAbortTemplate =
            "Channel close faulted with {ExceptionType}; aborting channel.";
        private const string TimeoutAbortTemplate =
            "Channel close timed out ({ExceptionType}); aborting channel.";

        /// <summary>
        /// Safely terminates a communication object, invoking Close or Abort depending on channel state and faults.
        /// </summary>
        /// <param name="channel">The channel or communication object to release.</param>
        /// <param name="logger">The logger used to record channel abort warnings.</param>
        public static void CloseChannel(ICommunicationObject channel, ILoggerService logger)
        {
            if (logger == null)
            {
                throw new ArgumentNullException(nameof(logger));
            }

            if (channel != null)
            {
                try
                {
                    if (channel.State == CommunicationState.Faulted)
                    {
                        channel.Abort();
                    }
                    else if (channel.State != CommunicationState.Closed)
                    {
                        channel.Close();
                    }
                }
                catch (CommunicationException ex)
                {
                    logger.Warning(CommunicationAbortTemplate, ex.GetType().Name);
                    channel.Abort();
                }
                catch (TimeoutException ex)
                {
                    logger.Warning(TimeoutAbortTemplate, ex.GetType().Name);
                    channel.Abort();
                }
            }
        }
    }
}
