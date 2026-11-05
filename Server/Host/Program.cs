using System;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using Application;
using Application.Ports;
using Application.UseCases;
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
            ServiceHost loginHost = null;
            ServiceHost lobbyHost = null;
            ServiceHost accountManagementHost = null;
            ServiceHost friendshipHost = null;
            ServiceHost friendsRequestHost = null;

            try
            {
                IUserRepository userRepository = new UserRepository();
                IFriendshipRepository friendshipRepository = new FriendshipRepository();
                IFriendshipUseCase friendshipUseCase = new FriendshipUseCase(friendshipRepository, userRepository);

                loginHost = CreateUserLoginServiceHost(userRepository);
                lobbyHost = CreateLobbyServiceHost(userRepository);
                accountManagementHost = CreateAccountManagementServiceHost(userRepository);
                friendshipHost = CreateFriendshipServiceHost(friendshipUseCase);
                friendsRequestHost = CreateFriendsRequestServiceHost(friendshipUseCase);

                loginHost.Open();
                lobbyHost.Open();
                accountManagementHost.Open();
                friendshipHost.Open();
                friendsRequestHost.Open();

                Console.WriteLine("TrickTakingMissions Server is running.");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/UserLoginService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/LobbyService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/AccountManagementService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/FriendshipService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/FriendsRequestService");
                Console.WriteLine("Press [Enter] to terminate the server.");
                Console.ReadLine();

                friendsRequestHost.Close();
                friendshipHost.Close();
                accountManagementHost.Close();
                lobbyHost.Close();
                loginHost.Close();
            }
            catch (TimeoutException)
            {
                friendsRequestHost?.Abort();
                friendshipHost?.Abort();
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();
                // TODO: Log timeout failure using official logging component once available.
            }
            catch (CommunicationException)
            {
                friendsRequestHost?.Abort();
                friendshipHost?.Abort();
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();
                // TODO: Log communication failure using official logging component once available.
            }
            catch (InvalidOperationException)
            {
                friendsRequestHost?.Abort();
                friendshipHost?.Abort();
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();
                // TODO: Log configuration/service startup failure using official logging component once available.
            }
        }

        private static ServiceHost CreateUserLoginServiceHost(IUserRepository userRepository)
        {
            IUserLoginUseCase userLoginUseCase = new UserLoginUseCase(userRepository);
            IInstanceProvider instanceProvider = new FuncInstanceProvider<UserLoginService>(
                () => new UserLoginService(userLoginUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(UserLoginService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateLobbyServiceHost(IUserRepository userRepository)
        {
            ILobbyUseCase lobbyUseCase = new LobbyUseCase(userRepository);
            IInstanceProvider instanceProvider = new FuncInstanceProvider<LobbyService>(
                () => new LobbyService(lobbyUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(LobbyService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateAccountManagementServiceHost(IUserRepository userRepository)
        {
            IAccountManagementUseCase accountManagementUseCase = new AccountManagementUseCase(userRepository);
            IInstanceProvider instanceProvider = new FuncInstanceProvider<AccountManagementService>(
                () => new AccountManagementService(accountManagementUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(AccountManagementService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateFriendshipServiceHost(IFriendshipUseCase friendshipUseCase)
        {
            IInstanceProvider instanceProvider = new FuncInstanceProvider<FriendshipService>(
                () => new FriendshipService(friendshipUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(FriendshipService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateFriendsRequestServiceHost(IFriendshipUseCase friendshipUseCase)
        {
            IInstanceProvider instanceProvider = new FuncInstanceProvider<FriendsRequestService>(
                () => new FriendsRequestService(friendshipUseCase));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(FriendsRequestService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }
    }
}
