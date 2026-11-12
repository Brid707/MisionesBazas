using System.ServiceModel;
using Services.DataContracts.Friendship;

namespace Services.Contracts.Friendship
{
    public interface IFriendshipServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void OnReceiveFriendRequest(FriendRequest friendRequest);

        [OperationContract(IsOneWay = true)]
        void OnFriendStatusChanged(int friendUserId, bool isOnline);

        [OperationContract(IsOneWay = true)]
        void OnFriendRemoved(int friendUserId);

        [OperationContract(IsOneWay = true)]
        void OnReceiveGameInvitation(GameInvitation gameInvitation);
    }
}
