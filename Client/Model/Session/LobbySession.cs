
using System;
using Model.GameServices;
using Model.Services;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Session
{
    /// <summary>
    /// Manages the active client-side lobby state and duplex communication channel as a thread-safe singleton.
    /// </summary>
    public sealed class LobbySession : ILobbySession
    {
        private const string LoggingNotConfiguredMessage =
            "LobbySession logging must be configured during App.OnStartup before creating a lobby client.";
        private const string StaleLobbyStateIgnoredTemplate =
            "Ignored stale lobby snapshot with StateVersion {IncomingVersion} (current {CurrentVersion}).";
        private const string LobbySessionClearedTemplate = "Lobby session state cleared.";

        private static readonly object s_syncRoot = new object();
        private static LobbySession s_instance;

        private ILoggerFactory _loggerFactory;
        private ILoggerService _sessionLogger;
        private ILobbyClient _client;
        private Lobby _currentLobby;

        private LobbySession()
        {
        }

        public static LobbySession Current
        {
            get
            {
                if (s_instance == null)
                {
                    lock (s_syncRoot)
                    {
                        if (s_instance == null)
                        {
                            s_instance = new LobbySession();
                        }
                    }
                }

                return s_instance;
            }
        }

        public Lobby CurrentLobby => _currentLobby;

        public bool HasActiveLobby => _currentLobby != null;

        public ILobbyClient Client
        {
            get
            {
                lock (s_syncRoot)
                {
                    if (_client == null)
                    {
                        EnsureLoggingConfigured();
                        _client = new LobbyClient(_loggerFactory.CreateLogger<LobbyClient>());
                    }

                    return _client;
                }
            }
        }

        public void ConfigureLogging(ILoggerFactory loggerFactory)
        {
            if (loggerFactory == null)
            {
                throw new ArgumentNullException(nameof(loggerFactory));
            }

            lock (s_syncRoot)
            {
                _loggerFactory = loggerFactory;
                _sessionLogger = loggerFactory.CreateLogger<LobbySession>();
            }
        }

        public void SetLobby(Lobby lobby)
        {
            lock (s_syncRoot)
            {
                bool isCurrentOrNewerRoom = _currentLobby == null || lobby == null ||
                    _currentLobby.LobbyCode != lobby.LobbyCode || lobby.StateVersion >= _currentLobby.StateVersion;
                if (isCurrentOrNewerRoom)
                {
                    _currentLobby = lobby;
                }
                else if (_currentLobby != null && lobby != null)
                {
                    _sessionLogger?.Debug(StaleLobbyStateIgnoredTemplate, lobby.StateVersion,
                        _currentLobby.StateVersion);
                }
            }
        }

        public void ClearLobby()
        {
            lock (s_syncRoot)
            {
                _currentLobby = null;
                if (_client != null)
                {
                    _client.Dispose();
                    _client = null;
                }

                _sessionLogger?.Information(LobbySessionClearedTemplate);
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
