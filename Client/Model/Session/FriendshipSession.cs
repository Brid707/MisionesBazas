using System;
using Model.Services;

namespace Model.Session
{
    /// <summary>
    /// Manages the active client-side social communication channels as a thread-safe singleton.
    /// </summary>
    public sealed class FriendshipSession : IFriendshipSession
    {
        private static readonly object s_syncRoot = new object();
        private static FriendshipSession s_instance;

        private IFriendshipClient _client;
        private IFriendsRequestClient _requestClient;

        private FriendshipSession()
        {
        }

        public event Action FriendsListChanged;

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
                        _client = new FriendshipClient();
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
                        _requestClient = new FriendsRequestClient();
                    }

                    return _requestClient;
                }
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
            }
        }
    }
}
