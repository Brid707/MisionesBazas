using System.Collections.Generic;
using System.ServiceModel;
using Services.DataContracts.Friendship;
using Services.DataContracts;

namespace Services.Contracts.Friendship
{
    [ServiceContract(CallbackContract = typeof(IFriendshipServiceCallback))]
    public interface IFriendshipService
    {
        [OperationContract(IsOneWay = true)]
        void SubscribeSocialEvents(int userId);

        [OperationContract(IsOneWay = true)]
        void UnsubscribeSocialEvents(int userId);

        [OperationContract]
        List<Friend> GetFriendsListByUserId(int userId);

        [OperationContract]
        OperationResult BlockPlayer(int blockerUserId, int targetUserId);

        [OperationContract]
        OperationResult UnblockPlayer(int blockerUserId, int targetUserId);

        [OperationContract]
        OperationResult RemoveFriend(int userId, int friendUserId);

        [OperationContract(IsOneWay = true)]
        void SendGameInvitation(GameInvitation gameInvitation);
    }
}
