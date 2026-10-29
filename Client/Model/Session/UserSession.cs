using System;

namespace Model.Session
{
    /// <summary>
    /// Manages the authenticated client-side user session as a thread-safe singleton.
    /// </summary>
    public sealed class UserSession
    {
        private const int GuestIdMinimum = 1000;
        private const int GuestIdMaximum = 10000;

        private static readonly object _lockObject = new object();
        private static readonly Random s_random = new Random();
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

        /// <summary>
        /// Gets the identifier of the active user, creating a temporary guest identity when no user is signed in.
        /// </summary>
        /// <returns>The identifier of the active user or of the newly created guest.</returns>
        public int EnsureActiveUserId()
        {
            lock (_lockObject)
            {
                if (_currentUser == null)
                {
                    int guestSuffix = s_random.Next(GuestIdMinimum, GuestIdMaximum);
                    _currentUser = new UserSessionData
                    {
                        IdUser = -guestSuffix,
                        Username = string.Empty,
                        Email = string.Empty
                    };
                }

                return _currentUser.IdUser;
            }
        }    }
}
