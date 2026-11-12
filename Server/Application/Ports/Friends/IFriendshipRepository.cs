using System.Collections.Generic;
using System.Threading.Tasks;
using Application.Models.Friendship;

namespace Application.Ports
{
    public interface IFriendshipRepository
    {
        List<FriendSummaryData> GetFriendsListByUserId(int userId);

        bool IsPlayerBlockedByPlayerA(int playerAId, int playerBId);

        void BlockPlayer(int blockerId, int blockedId);

        void UnblockPlayer(int blockerId, int blockedId);

        void RemoveFriendship(int firstUserId, int secondUserId);

        Task<FriendshipRecordData> GetFriendshipAsync(int firstUserId, int secondUserId);

        Task CreateFriendRequestAsync(int senderUserId, int receiverUserId);

        Task UpdateFriendshipStatusAsync(int firstUserId, int secondUserId, byte status);

        Task DeleteFriendshipAsync(int firstUserId, int secondUserId);

        Task<List<FriendRequestData>> GetPendingFriendRequestsByUserIdAsync(int userId);

        Task<List<FriendRequestData>> GetSentFriendRequestsByUserIdAsync(int userId);
    }
}
