using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Model.IFriendShipService;

namespace Model.Services
{
    /// <summary>
    /// Abstraction of the client-side duplex friendship channel for social operations and real-time events.
    /// </summary>
    public interface IFriendshipClient : IDisposable
    {
        event Action<FriendRequest> FriendRequestReceived;

        event Action<int, bool> FriendStatusChanged;

        event Action<int> FriendRemoved;

        event Action<GameInvitation> GameInvitationReceived;

        event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        Task SubscribeSocialEventsAsync(int userId);

        Task UnsubscribeSocialEventsAsync(int userId);

        Task<IList<Friend>> GetFriendsListByUserIdAsync(int userId);

        Task<OperationResult> RemoveFriendAsync(int userId, int friendUserId);

        Task<OperationResult> BlockPlayerAsync(int blockerUserId, int targetUserId);

        Task<OperationResult> UnblockPlayerAsync(int blockerUserId, int targetUserId);

        Task SendGameInvitationAsync(GameInvitation gameInvitation);
    }
}
