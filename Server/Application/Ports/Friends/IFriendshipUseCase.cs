using Application.Models.Friendship;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Ports
{
    public interface IFriendshipUseCase
    {
        List<FriendSummaryData> GetFriendsListByUserId(int userId);

        FriendshipActionOutcome BlockPlayer(int blockerUserId, int targetUserId);

        FriendshipActionOutcome UnblockPlayer(int blockerUserId, int targetUserId);

        FriendshipActionOutcome RemoveFriend(int userId, int friendUserId);

        Task<FriendshipActionOutcome> SendFriendRequestAsync(int senderUserId, string targetUsername);

        Task<FriendshipActionOutcome> AcceptFriendRequestAsync(int receiverUserId, int senderUserId);

        Task<FriendshipActionOutcome> RejectFriendRequestAsync(int receiverUserId, int senderUserId);

        Task<FriendshipActionOutcome> CancelFriendRequestAsync(int senderUserId, int receiverUserId);

        Task<List<FriendRequestData>> GetPendingFriendRequestsByUserIdAsync(int userId);

        Task<List<FriendRequestData>> GetSentFriendRequestsByUserIdAsync(int userId);
    }
}
