
using Model.GameServices;
using Model.Services;

namespace Model.Session
{
    /// <summary>
    /// Manages the active client-side lobby state and duplex communication channel as a thread-safe singleton.
    /// </summary>
    public sealed class LobbySession : ILobbySession
    {
        private static readonly object s_syncRoot = new object();
        private static LobbySession s_instance;

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
                        _client = new LobbyClient();
                    }

                    return _client;
                }
            }
        }

        public void SetLobby(Lobby lobby)
        {
            lock (s_syncRoot)
            {
                _currentLobby = lobby;
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
            }
        }
    }
}
