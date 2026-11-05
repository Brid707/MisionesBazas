using Application.Models.Friendship;
using Application.Ports;
using Services.Contracts.Friendship;
using Services.DataContracts.Friendship;
using Services.DTO;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Services.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public sealed class FriendsRequestService : IFriendsRequestService
    {
        private readonly IFriendshipUseCase _friendshipUseCase;

        public FriendsRequestService(IFriendshipUseCase friendshipUseCase)
        {
            if (friendshipUseCase == null)
            {
                throw new ArgumentNullException(nameof(friendshipUseCase));
            }

            _friendshipUseCase = friendshipUseCase;
        }

        public async Task<OperationResult> SendFriendRequestAsync(int senderUserId, string targetUsername)
        {
            FriendshipActionOutcome friendshipActionOutcome = await
                _friendshipUseCase.SendFriendRequestAsync(senderUserId, targetUsername);

            if (friendshipActionOutcome.IsSuccess)
            {
                await NotifyReceiverOfNewRequestAsync(senderUserId, targetUsername);
            }

            return MapToOperationResult(friendshipActionOutcome);
        }

        public async Task<OperationResult> AcceptFriendRequestAsync(int receiverUserId, int senderUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome = await
                _friendshipUseCase.AcceptFriendRequestAsync(receiverUserId, senderUserId);

            if (friendshipActionOutcome.IsSuccess)
            {
                bool isReceiverOnline = FriendshipService.IsUserOnline(receiverUserId);
                FriendshipService.NotifySingleFriendStatus(senderUserId, receiverUserId, isReceiverOnline);
            }

            return MapToOperationResult(friendshipActionOutcome);
        }

        public async Task<OperationResult> RejectFriendRequestAsync(int receiverUserId, int senderUserId)
        {
            FriendshipActionOutcome outcome = await 
                _friendshipUseCase.RejectFriendRequestAsync(receiverUserId, senderUserId);

            return MapToOperationResult(outcome);
        }

        public async Task<OperationResult> CancelFriendRequestAsync(int senderUserId, int receiverUserId)
        {
            FriendshipActionOutcome outcome = await 
                _friendshipUseCase.CancelFriendRequestAsync(senderUserId, receiverUserId);
            
            return MapToOperationResult(outcome);
        }

        public async Task<List<FriendRequest>> GetPendingFriendRequestByUserIdAsync(int userId)
        {
            List<FriendRequest> pendingRequests = new List<FriendRequest>();
            List<FriendRequestData> domainRequests = await 
                _friendshipUseCase.GetPendingFriendRequestsByUserIdAsync(userId);
            
            foreach (FriendRequestData friendRequestData in domainRequests)
            {
                pendingRequests.Add(MapToFriendRequest(friendRequestData));
            }

            return pendingRequests;
        }

        public async Task<List<FriendRequest>> GetSentFriendRequestByUserIdAsync(int userId)
        {
            List<FriendRequest> sentRequests = new List<FriendRequest>();
            List<FriendRequestData> domainRequests = await 
                _friendshipUseCase.GetSentFriendRequestsByUserIdAsync(userId);
            
            foreach (FriendRequestData friendRequestData in domainRequests)
            {
                sentRequests.Add(MapToFriendRequest(friendRequestData));
            }

            return sentRequests;
        }

        private async Task NotifyReceiverOfNewRequestAsync(int senderUserId, string targetUsername)
        {
            List<FriendRequestData> sentRequests = await
                _friendshipUseCase.GetSentFriendRequestsByUserIdAsync(senderUserId);

            foreach (FriendRequestData requestData in sentRequests)
            {
                if (string.Equals(requestData.ReceiverUsername, targetUsername?.Trim(), 
                    StringComparison.OrdinalIgnoreCase))
                {
                    FriendRequest friendRequest = MapToFriendRequest(requestData);
                    FriendshipService.NotifyFriendRequestReceived(friendRequest);
                }
            }
        }

        private static FriendRequest MapToFriendRequest(FriendRequestData requestData)
        {
            return new FriendRequest
            {
                SenderUserId = requestData.SenderIdUser,
                SenderUsername = requestData.SenderUsername,
                ReceiverUserId = requestData.ReceiverIdUser,
                ReceiverUsername = requestData.ReceiverUsername,
                Status = requestData.Status,
                RequestedAt = requestData.RequestDate
            };
        }

        private static OperationResult MapToOperationResult(FriendshipActionOutcome friendshipActionOutcome)
        {
            return new OperationResult
            {
                IsSuccess = friendshipActionOutcome.IsSuccess,
                ErrorCode = friendshipActionOutcome.ErrorCode,
                Message = friendshipActionOutcome.Message
            };
        }
    }
}
