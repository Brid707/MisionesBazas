using System;

namespace Model.Session
{
    /// <summary>
    /// Manages the authenticated client-side user session as a thread-safe singleton.
    /// </summary>
    public sealed class UserSession
    {
        private static readonly object _lockObject = new object();
        private static UserSession _instance;

        private UserSessionData _currentUser;

        private UserSession()
        {
        }

        /// <summary>
        /// Gets the singleton instance of the current user session.
        /// </summary>
        public static UserSession Current
        {
            get
            {
                if (_instance == null)
                {
                    lock (_lockObject)
                    {
                        if (_instance == null)
                        {
                            _instance = new UserSession();
                        }
                    }
                }

                return _instance;
            }
        }

        /// <summary>
        /// Gets the data associated with the currently authenticated user.
        /// </summary>
        public UserSessionData CurrentUser => _currentUser;

        /// <summary>
        /// Gets a value indicating whether a user is currently authenticated in this session.
        /// </summary>
        public bool IsAuthenticated => _currentUser != null;

        /// <summary>
        /// Sets the active user data for this session.
        /// </summary>
        /// <param name="user">The authenticated user data to store.</param>
        public void SetUser(UserSessionData user)
        {
            _currentUser = user;
        }

        /// <summary>
        /// Clears the active user data, effectively terminating the session.
        /// </summary>
        public void ClearSession()
        {
            _currentUser = null;
        }
    }
}
