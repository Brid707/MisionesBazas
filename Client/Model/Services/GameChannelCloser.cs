using System;
using System.ServiceModel;

namespace Model.Services
{
    /// <summary>
    /// Utility class for safely closing and aborting WCF communication channels.
    /// Implements standard rule 16.3.2 (CloseOrAbort pattern).
    /// </summary>
    public static class GameChannelCloser
    {
        /// <summary>
        /// Safely terminates a communication object, invoking Close or Abort depending on channel state and faults.
        /// </summary>
        /// <param name="channel">The channel or communication object to release.</param>
        public static void CloseChannel(ICommunicationObject channel)
        {
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
                catch (CommunicationException)
                {
                    channel.Abort();
                }
                catch (TimeoutException)
                {
                    channel.Abort();
                }
            }
        }
    }
}
