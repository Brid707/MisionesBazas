using System;
using System.Globalization;
using System.IO;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using Application;
using Application.Models;
using Application.Ports;
using Application.UseCases;
using Host.DependencyInjection;
using Host.Gameplay;
using Infrastructure.Moderation;
using Persistence.Repository;
using Services.Security;
using Services.Services;
using TrickTakingMissions.Logging;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Host
{
    /// <summary>
    /// Host console application entry point and Composition Root for the WCF game server.
    /// </summary>
    internal static class Program
    {
        private const int Port = 8090;
        private const string LogsDirectoryName = "Logs";
        private const string ServerLogFileName = "ServerTrickTakingMissions.log";
        private const string ServerStartedTemplate =
            "TrickTakingMissions server started and is listening on TCP port {Port}.";
        private const string ServerStoppedTemplate =
            "TrickTakingMissions server stopped cleanly on TCP port {Port}.";
        private const string TimeoutFatalTemplate =
            "Server host operation timed out on TCP port {Port}.";
        private const string CommunicationFatalTemplate =
            "WCF communication failure occurred on TCP port {Port}.";
        private const string InvalidOperationFatalTemplate =
            "Invalid service configuration prevented server startup on TCP port {Port}.";

        /// <summary>
        /// Defines the entry point of the server application, assembling dependencies and hosting WCF services.
        /// </summary>
        private static void Main()
        {
            CultureInfo serverCulture = CultureInfo.GetCultureInfo("en-US");
            CultureInfo.DefaultThreadCurrentCulture = serverCulture;
            CultureInfo.DefaultThreadCurrentUICulture = serverCulture;

            ServiceHost profileImageHost = null;
            ServiceHost loginHost = null;
            ServiceHost lobbyHost = null;
            ServiceHost accountManagementHost = null;
            ServiceHost friendshipHost = null;
            ServiceHost friendsRequestHost = null;

            string logsDirectory = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, LogsDirectoryName);
            Log4NetConfigurator.Configure(logsDirectory, ServerLogFileName);
            ILoggerFactory loggerFactory = new LoggerFactory();
            ILoggerService hostLogger = loggerFactory.CreateLogger(typeof(Program));

            try
            {
                IUserRepository userRepository = new UserRepository(loggerFactory.CreateLogger<UserRepository>());
                IFriendshipRepository friendshipRepository = new FriendshipRepository(
                    loggerFactory.CreateLogger<FriendshipRepository>());
                IFriendshipUseCase friendshipUseCase = new FriendshipUseCase(
                    friendshipRepository,
                    userRepository,
                    loggerFactory.CreateLogger<FriendshipUseCase>());

                var chatInfractionRepository = new ChatInfractionRepository(
                    loggerFactory.CreateLogger<ChatInfractionRepository>());
                var accountAccessPolicy = new AccountAccessPolicy(
                    new AuthenticatedAccountSessionRegistry(),
                    chatInfractionRepository,
                    loggerFactory.CreateLogger<AccountAccessPolicy>());
                var catalogBackup = new ChatModerationCatalogBackup(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                        "ModerationCatalogBackups", "ValidatedCatalog.xml"));
                ChatModerationStartup moderationStartup = new ChatModerationStartup(
                    catalogBackup,
                    loggerFactory.CreateLogger<ChatModerationStartup>());
                ChatModerationPreparation moderationPreparation = moderationStartup.PrepareChatModeration(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ModerationCatalogs"));
                var lobbyChatMessageUseCase = new LobbyChatMessageUseCase(
                    moderationPreparation,
                    chatInfractionRepository,
                    loggerFactory.CreateLogger<LobbyChatMessageUseCase>());
                profileImageHost = ProfileImageHosting.Create(accountAccessPolicy, loggerFactory);
                loginHost = CreateUserLoginServiceHost(userRepository, accountAccessPolicy, loggerFactory);
                lobbyHost = CreateLobbyServiceHost(new LobbyHostingContext
                {
                    UserRepository = userRepository,
                    ChatMessageUseCase = lobbyChatMessageUseCase,
                    AccountAccessPolicy = accountAccessPolicy,
                    LoggerFactory = loggerFactory
                });
                accountManagementHost = CreateAccountManagementServiceHost(userRepository, loggerFactory);
                friendshipHost = CreateFriendshipServiceHost(friendshipUseCase, loggerFactory);
                friendsRequestHost = CreateFriendsRequestServiceHost(friendshipUseCase, loggerFactory);

                profileImageHost.Open();
                loginHost.Open();
                lobbyHost.Open();
                accountManagementHost.Open();
                friendshipHost.Open();
                friendsRequestHost.Open();

                hostLogger.Information(ServerStartedTemplate, Port);

                Console.WriteLine("TrickTakingMissions Server is running.");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/UserLoginService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/LobbyService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/AccountManagementService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/FriendshipService");
                Console.WriteLine("TCP Endpoint: net.tcp://localhost:8090/FriendsRequestService");
                Console.WriteLine("Press [Enter] to terminate the server.");
                Console.ReadLine();

                profileImageHost.Close();
                friendsRequestHost.Close();
                friendshipHost.Close();
                accountManagementHost.Close();
                lobbyHost.Close();
                loginHost.Close();

                hostLogger.Information(ServerStoppedTemplate, Port);
            }
            catch (TimeoutException ex)
            {
                profileImageHost?.Abort();
                friendsRequestHost?.Abort();
                friendshipHost?.Abort();
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();

                hostLogger.Fatal(ex, TimeoutFatalTemplate, Port);
            }
            catch (CommunicationException ex)
            {
                profileImageHost?.Abort();
                friendsRequestHost?.Abort();
                friendshipHost?.Abort();
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();

                hostLogger.Fatal(ex, CommunicationFatalTemplate, Port);
            }
            catch (InvalidOperationException ex)
            {
                profileImageHost?.Abort();
                friendsRequestHost?.Abort();
                friendshipHost?.Abort();
                accountManagementHost?.Abort();
                lobbyHost?.Abort();
                loginHost?.Abort();

                hostLogger.Fatal(ex, InvalidOperationFatalTemplate, Port);
            }
        }

        private static ServiceHost CreateUserLoginServiceHost(IUserRepository userRepository,
            IAccountAccessPolicy accountAccessPolicy, ILoggerFactory loggerFactory)
        {
            IUserLoginUseCase userLoginUseCase = new UserLoginUseCase(
                userRepository,
                loggerFactory.CreateLogger<UserLoginUseCase>());
            ILoggerService userLoginServiceLogger = loggerFactory.CreateLogger<UserLoginService>();
            var instanceProvider = new FuncInstanceProvider<UserLoginService>(
                () => new UserLoginService(userLoginUseCase, accountAccessPolicy, userLoginServiceLogger));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(UserLoginService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateLobbyServiceHost(LobbyHostingContext context)
        {
            IUserRepository userRepository = context.UserRepository;
            ILobbyChatMessageUseCase lobbyChatMessageUseCase = context.ChatMessageUseCase;
            IAccountAccessPolicy accountAccessPolicy = context.AccountAccessPolicy;
            ILoggerFactory loggerFactory = context.LoggerFactory;
            var matchUseCase = new MatchUseCase(new InMemoryMatchStateStore(), new SecureMissionDeckDealer(),
                new MatchExecutionDependencies
                {
                    Logger = loggerFactory.CreateLogger<MatchUseCase>(),
                    MatchClock = new MonotonicMatchClock(),
                    ParticipantPresence = new LobbyMatchPresence(loggerFactory.CreateLogger<LobbyMatchPresence>())
                });
            var lobbyUseCase = new LobbyUseCase(userRepository, new LobbyHostSelection(), matchUseCase,
                loggerFactory.CreateLogger<LobbyUseCase>());
            ILoggerService lobbyServiceLogger = loggerFactory.CreateLogger<LobbyService>();
            var instanceProvider = new FuncInstanceProvider<LobbyService>(
                () => new LobbyService(lobbyUseCase, lobbyChatMessageUseCase, accountAccessPolicy, lobbyServiceLogger));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(LobbyService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            var scheduler = new MissionTransitionScheduler(matchUseCase,
                new LobbyService(lobbyUseCase, lobbyChatMessageUseCase, accountAccessPolicy, lobbyServiceLogger),
                loggerFactory.CreateLogger<MissionTransitionScheduler>());
            serviceHost.Opened += scheduler.OnHostOpened;
            serviceHost.Closing += scheduler.OnHostStopped;
            serviceHost.Faulted += scheduler.OnHostStopped;
            return serviceHost;
        }

        private static ServiceHost CreateAccountManagementServiceHost(IUserRepository userRepository,
            ILoggerFactory loggerFactory)
        {
            var blockedAccountEmailRepository = new BlockedAccountEmailRepository(
                loggerFactory.CreateLogger<BlockedAccountEmailRepository>());
            var accountManagementUseCase = new AccountManagementUseCase(
                userRepository,
                blockedAccountEmailRepository,
                loggerFactory.CreateLogger<AccountManagementUseCase>());
            ILoggerService accountManagementServiceLogger = loggerFactory.CreateLogger<AccountManagementService>();
            var instanceProvider = new FuncInstanceProvider<AccountManagementService>(
                () => new AccountManagementService(accountManagementUseCase, accountManagementServiceLogger));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(AccountManagementService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateFriendshipServiceHost(IFriendshipUseCase friendshipUseCase,
            ILoggerFactory loggerFactory)
        {
            ILoggerService friendshipServiceLogger = loggerFactory.CreateLogger<FriendshipService>();
            var instanceProvider = new FuncInstanceProvider<FriendshipService>(
                () => new FriendshipService(friendshipUseCase, friendshipServiceLogger));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(FriendshipService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }

        private static ServiceHost CreateFriendsRequestServiceHost(IFriendshipUseCase friendshipUseCase,
            ILoggerFactory loggerFactory)
        {
            ILoggerService friendsRequestServiceLogger = loggerFactory.CreateLogger<FriendsRequestService>();
            var instanceProvider = new FuncInstanceProvider<FriendsRequestService>(
                () => new FriendsRequestService(friendshipUseCase, friendsRequestServiceLogger));
            IServiceBehavior injectionBehavior = new DependencyInjectionServiceBehavior(instanceProvider);

            ServiceHost serviceHost = new ServiceHost(typeof(FriendsRequestService));
            serviceHost.Description.Behaviors.Add(injectionBehavior);
            return serviceHost;
        }
    }
}
