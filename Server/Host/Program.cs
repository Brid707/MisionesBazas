using System;
using System.ServiceModel;
using Services.Services;

namespace Host
{
    /// <summary>
    /// Host console application entry point for the WCF game server.
    /// </summary>
    internal static class Program
    {
        /// <summary>
        /// Defines the entry point of the server application.
        /// </summary>
        private static void Main()
        {
            ServiceHost host = null;
            try
            {
                host = new ServiceHost(typeof(UserLoginService));
                host.Open();

                Console.WriteLine("TrickTakingMissions Server is running.");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/UserLoginService");
                Console.WriteLine("Press [Enter] to terminate the server.");
                Console.ReadLine();

                host.Close();
            }
            catch (TimeoutException)
            {
                host?.Abort();
                // TODO: Log timeout failure using official logging component once available.
            }
            catch (CommunicationException)
            {
                host?.Abort();
                // TODO: Log communication failure using official logging component once available.
            }
            catch (InvalidOperationException)
            {
                host?.Abort();
                // TODO: Log configuration/service startup failure using official logging component once available.
            }
        }
    }
}
