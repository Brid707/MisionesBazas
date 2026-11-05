using System;
using System.IO;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;

using Application;
using Application.Ports;
using Application.UseCases;
using Host.DependencyInjection;
using Infrastructure.Moderation;
using Persistence.Repository;
using Services.Security;
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
            ServiceHost loginHost = null;
            ServiceHost lobbyHost = null;
            ServiceHost accountManagementHost = null;

            try
            {
                IUserRepository userRepository = new UserRepository();

                IChatInfractionRepository chatInfractionRepository =
                    new ChatInfractionRepository(new ChatModerationLogger());
                IAccountAccessPolicy accountAccessPolicy = new AccountAccessPolicy(
                    new AuthenticatedAccountSessionRegistry(), chatInfractionRepository);
                IProhibitedChatExpressionCatalog prohibitedChatExpressionCatalog =
                    new ProhibitedChatExpressionCatalog(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ModerationCatalogs"));
                ILobbyChatMessageUseCase lobbyChatMessageUseCase = new LobbyChatMessageUseCase(
                    prohibitedChatExpressionCatalog, chatInfractionRepository);
                loginHost = CreateUserLoginServiceHost(userRepository, accountAccessPolicy);
                lobbyHost = CreateLobbyServiceHost(userRepository, lobbyChatMessageUseCase, accountAccessPolicy);
                accountManagementHost = CreateAccountManagementServiceHost(userRepository);

                loginHost.Open();
                lobbyHost.Open();
                accountManagementHost.Open();

                Console.WriteLine("TrickTakingMissions Server is running.");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/UserLoginService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/LobbyService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/AccountManagementService");
                Console.WriteLine("Press [Enter] to terminate the server.");
                Console.ReadLine();

                accountManagementHost.Close();
                lobbyHost.Close();
                loginHost.Close();
            }
            catch (TimeoutException)
            {
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();
                // TODO: Log timeout failure using official logging component once available.
            }
            catch (CommunicationException)
            {
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();
                // TODO: Log communication failure using official logging component once available.
            }
            catch (InvalidOperationException)
            {
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();
                // TODO: Log configuration/service startup failure using official logging component once available.
            }
        }

        private static ServiceHost CreateUserLoginServiceHost(IUserRepository userRepository,
            IAccountAccessPolicy accountAccessPolicy)
        {
            IUserLoginUseCase userLoginUseCase = new UserLoginUseCase(userRepository);
            IInstanceProvider instanceProvider = new FuncInstanceProvider<UserLoginService>(
                () => new UserLoginService(userLoginUseCase, accountAccessPolicy));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(UserLoginService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateLobbyServiceHost(IUserRepository userRepository,
            ILobbyChatMessageUseCase lobbyChatMessageUseCase, IAccountAccessPolicy accountAccessPolicy)
        {
            ILobbyUseCase lobbyUseCase = new LobbyUseCase(userRepository, new LobbyHostSelection());
            IInstanceProvider instanceProvider = new FuncInstanceProvider<LobbyService>(
                () => new LobbyService(lobbyUseCase, lobbyChatMessageUseCase, accountAccessPolicy));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(LobbyService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateAccountManagementServiceHost(IUserRepository userRepository)
        {
            IAccountManagementUseCase accountManagementUseCase = new AccountManagementUseCase(userRepository,
                new BlockedAccountEmailRepository(new ChatModerationLogger()));
            IInstanceProvider instanceProvider = new FuncInstanceProvider<AccountManagementService>(
                () => new AccountManagementService(accountManagementUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(AccountManagementService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }
    }
}
