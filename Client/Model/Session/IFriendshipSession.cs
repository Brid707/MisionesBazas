using System;
using Model.Services;

namespace Model.Session
{
    /// <summary>
    /// Abstraction of the active client-side social session and its friendship communication channels.
    /// </summary>
    public interface IFriendshipSession
    {
        event Action FriendsListChanged;

        IFriendshipClient Client { get; }

        IFriendsRequestClient RequestClient { get; }

        void NotifyFriendsListChanged();

        void ClearSession();
    }
}
