using Model.ILobbyService;
using Model.Services;

namespace Model.Session
{
    /// <summary>
    /// Manages the active client-side lobby state and duplex communication channel as a thread-safe singleton.
    /// </summary>
    public sealed class LobbySession
    {
        private static readonly object SyncRoot = new object();
        private static LobbySession _instance;

        private LobbyClient _client;
        private Lobby _currentLobby;

        private LobbySession()
        {
        }

        public static LobbySession Current
        {
            get
            {
                if (_instance == null)
                {
                    lock (SyncRoot)
                    {
                        if (_instance == null)
                        {
                            _instance = new LobbySession();
                        }
                    }
                }

                return _instance;
            }
        }

        public Lobby CurrentLobby => _currentLobby;

        public bool HasActiveLobby => _currentLobby != null;

        public LobbyClient Client
        {
            get
            {
                lock (SyncRoot)
                {
                    if (_client == null)
                    {
                        _client = new LobbyClient();
                    }

                    return _client;
                }
            }
        }

        public void SetLobby(Lobby lobby)
        {
            lock (SyncRoot)
            {
                _currentLobby = lobby;
            }
        }

        public void ClearLobby()
        {
            lock (SyncRoot)
            {
                _currentLobby = null;
                if (_client != null)
                {
                    _client.Dispose();
                    _client = null;
                }
            }
        }
    }
}
