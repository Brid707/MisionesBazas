using Services.DataContracts.Friendship;
using Services.DataContracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Services.Contracts.Friendship
{
    [ServiceContract]
    public interface IFriendsRequestService
    {
        [OperationContract]
        Task<OperationResult> SendFriendRequestAsync(int senderUserId, string targetUserName);

        [OperationContract]
        Task<OperationResult> AcceptFriendRequestAsync(int receiverUserId, int senderUserId);

        [OperationContract]
        Task<OperationResult> RejectFriendRequestAsync(int receiverUserId, int senderUserId);

        [OperationContract]
        Task<OperationResult> CancelFriendRequestAsync(int senderUserId, int receiverUserId);

        [OperationContract]
        Task<List<FriendRequest>> GetPendingFriendRequestByUserIdAsync(int userId);

        [OperationContract]
        Task<List<FriendRequest>> GetSentFriendRequestByUserIdAsync(int userId);
    }
}
