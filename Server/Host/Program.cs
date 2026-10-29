using System;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using Application;
using Application.Ports;
using Host.DependencyInjection;
using Persistence.Repository;
using Services.Services;

namespace Host
{
    /// <summary>
    /// Host console application entry point and Composition Root for the WCF game server.
    /// </summary>
    internal static class Program
    {
        /// <summary>
        /// Defines the entry point of the server application, assembling dependencies and hosting WCF services.
        /// </summary>
        private static void Main()
        {
            ServiceHost host = null;
            try
            {
                host = CreateUserLoginServiceHost();
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

        private static ServiceHost CreateUserLoginServiceHost()
        {
            IUserRepository userRepository = new UserRepository();
            IUserLoginUseCase userLoginUseCase = new UserLoginUseCase(userRepository);
            IInstanceProvider instanceProvider = new FuncInstanceProvider<UserLoginService>(
                () => new UserLoginService(userLoginUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(UserLoginService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }
    }
}
