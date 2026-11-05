using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Model.IFriendsRequestService;

namespace Model.Services
{
    /// <summary>
    /// Abstraction of the client-side channel for sending, accepting, rejecting, and querying friend requests.
    /// </summary>
    public interface IFriendsRequestClient : IDisposable
    {
        event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        Task<IList<FriendRequest>> GetPendingFriendRequestByUserIdAsync(int userId);

        Task<IList<FriendRequest>> GetSentFriendRequestByUserIdAsync(int userId);

        Task<OperationResult> SendFriendRequestAsync(int senderUserId, string targetUserName);

        Task<OperationResult> AcceptFriendRequestAsync(int receiverUserId, int senderUserId);

        Task<OperationResult> RejectFriendRequestAsync(int receiverUserId, int senderUserId);

        Task<OperationResult> CancelFriendRequestAsync(int senderUserId, int receiverUserId);
    }
}
