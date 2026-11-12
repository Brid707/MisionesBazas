using System;
using Model.Services;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Session
{
    /// <summary>
    /// Manages the active client-side social communication channels as a thread-safe singleton.
    /// </summary>
    public sealed class FriendshipSession : IFriendshipSession
    {
        private const string LoggingNotConfiguredMessage =
            "FriendshipSession logging must be configured during App.OnStartup before creating social clients.";
        private const string SocialSessionClearedTemplate = "Friendship session state cleared.";

        private static readonly object s_syncRoot = new object();
        private static FriendshipSession s_instance;

        private ILoggerFactory _loggerFactory;
        private ILoggerService _sessionLogger;
        private IFriendshipClient _client;
        private IFriendsRequestClient _requestClient;

        private FriendshipSession()
        {
        }

        public static FriendshipSession Current
        {
            get
            {
                if (s_instance == null)
                {
                    lock (s_syncRoot)
                    {
                        if (s_instance == null)
                        {
                            s_instance = new FriendshipSession();
                        }
                    }
                }

                return s_instance;
            }
        }

        public IFriendshipClient Client
        {
            get
            {
                lock (s_syncRoot)
                {
                    if (_client == null)
                    {
                        EnsureLoggingConfigured();
                        _client = new FriendshipClient(_loggerFactory.CreateLogger<FriendshipClient>());
                    }

                    return _client;
                }
            }
        }

        public IFriendsRequestClient RequestClient
        {
            get
            {
                lock (s_syncRoot)
                {
                    if (_requestClient == null)
                    {
                        EnsureLoggingConfigured();
                        _requestClient = new FriendsRequestClient(
                            _loggerFactory.CreateLogger<FriendsRequestClient>());
                    }

                    return _requestClient;
                }
            }
        }

        public event Action FriendsListChanged;

        public void ConfigureLogging(ILoggerFactory loggerFactory)
        {
            if (loggerFactory == null)
            {
                throw new ArgumentNullException(nameof(loggerFactory));
            }

            lock (s_syncRoot)
            {
                _loggerFactory = loggerFactory;
                _sessionLogger = loggerFactory.CreateLogger<FriendshipSession>();
            }
        }

        public void NotifyFriendsListChanged()
        {
            FriendsListChanged?.Invoke();
        }

        public void ClearSession()
        {
            lock (s_syncRoot)
            {
                if (_client != null)
                {
                    _client.Dispose();
                    _client = null;
                }

                if (_requestClient != null)
                {
                    _requestClient.Dispose();
                    _requestClient = null;
                }

                _sessionLogger?.Information(SocialSessionClearedTemplate);
            }
        }

        private void EnsureLoggingConfigured()
        {
            if (_loggerFactory == null)
            {
                throw new InvalidOperationException(LoggingNotConfiguredMessage);
            }
        }
    }
}
