using Application.Models.Friendship;
using Application.Ports;
using Services.Contracts.Friendship;
using Services.DataContracts.Friendship;
using Services.DataContracts;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ServiceModel;

namespace Services.Services
{
    [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public sealed class FriendshipService : IFriendshipService
    {
        private static readonly ConcurrentDictionary<int, IFriendshipServiceCallback> s_onlineSubscribers
            = new ConcurrentDictionary<int, IFriendshipServiceCallback>();
        private readonly IFriendshipUseCase _friendshipUseCase;

        public FriendshipService(IFriendshipUseCase friendshipUseCase)
        {
            if (friendshipUseCase == null)
            {
                throw new ArgumentNullException(nameof(friendshipUseCase));
            }

            _friendshipUseCase = friendshipUseCase;
        }

        public void SubscribeSocialEvents(int userId)
        {
            if (IsValidUserId(userId))
            {
                OperationContext operationContext = OperationContext.Current;
                IFriendshipServiceCallback callback = operationContext != null
                    ? operationContext.GetCallbackChannel<IFriendshipServiceCallback>()
                    : null;

                if (callback != null)
                {
                    s_onlineSubscribers[userId] = callback;
                    AttachChannelDisconnectHandlers(userId, callback, operationContext.Channel);
                    NotifyFriendsAboutStatusChange(userId, true);
                }
            }
        }

        public void UnsubscribeSocialEvents(int userId)
        {
            if (IsValidUserId(userId))
            {
                if (s_onlineSubscribers.TryRemove(userId, out IFriendshipServiceCallback _))
                {
                    NotifyFriendsAboutStatusChange(userId, false);
                }
            }
        }

        public List<Friend> GetFriendsListByUserId(int userId)
        {
            List<Friend> friends = new List<Friend>();
            List<FriendSummaryData> domainFriends = _friendshipUseCase.GetFriendsListByUserId(userId);

            foreach (FriendSummaryData friendSummaryData in domainFriends)
            {
                friends.Add(MapToFriend(friendSummaryData));
            }

            return friends;
        }

        public OperationResult BlockPlayer(int blockerUserId, int targetUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome = _friendshipUseCase.BlockPlayer(
                blockerUserId,
                targetUserId);

            if (friendshipActionOutcome.IsSuccess)
            {
                NotifyFriendRemoved(targetUserId, blockerUserId);
            }

            return MapToOperationResult(friendshipActionOutcome);
        }

        public OperationResult UnblockPlayer(int blockerUserId, int targetUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome = _friendshipUseCase.UnblockPlayer(
                blockerUserId,
                targetUserId);

            return MapToOperationResult(friendshipActionOutcome);
        }

        public OperationResult RemoveFriend(int userId, int friendUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome = _friendshipUseCase.RemoveFriend(userId, friendUserId);

            if (friendshipActionOutcome.IsSuccess)
            {
                NotifyFriendRemoved(friendUserId, userId);
            }

            return MapToOperationResult(friendshipActionOutcome);
        }

        public void SendGameInvitation(GameInvitation gameInvitation)
        {
            if (gameInvitation != null && IsValidUserId(gameInvitation.ReceiverUserId))
            {
                if (s_onlineSubscribers.TryGetValue(gameInvitation.ReceiverUserId, out IFriendshipServiceCallback receiverCallback))
                {
                    TrySendGameInvitationCallback(gameInvitation, receiverCallback);
                }
            }
        }

        internal static bool IsUserOnline(int userId)
        {
            return s_onlineSubscribers.ContainsKey(userId);
        }

        internal static void NotifyFriendRequestReceived(FriendRequest friendRequest)
        {
            if (friendRequest != null && s_onlineSubscribers.TryGetValue(
                friendRequest.ReceiverUserId,
                out IFriendshipServiceCallback receiverCallback))
            {
                TrySendFriendRequestCallback(friendRequest, receiverCallback);
            }
        }

        internal static void NotifySingleFriendStatus(int targetSubscriberUserId, int friendUserId, bool isOnline)
        {
            if (s_onlineSubscribers.TryGetValue(targetSubscriberUserId, out IFriendshipServiceCallback callback))
            {
                TrySendStatusChangedCallback(targetSubscriberUserId, callback, friendUserId, isOnline);
            }
        }

        internal static void NotifyFriendRemoved(int targetSubscriberUserId, int removedByUserId)
        {
            if (s_onlineSubscribers.TryGetValue(targetSubscriberUserId, out IFriendshipServiceCallback callback))
            {
                TrySendFriendRemovedCallback(targetSubscriberUserId, callback, removedByUserId);
            }
        }

        internal void HandleSubscriberChannelClosed(int userId, IFriendshipServiceCallback closedCallback)
        {
            if (s_onlineSubscribers.TryGetValue(userId, out IFriendshipServiceCallback activeCallback) &&
                ReferenceEquals(activeCallback, closedCallback))
            {
                if (s_onlineSubscribers.TryRemove(userId, out IFriendshipServiceCallback _))
                {
                    NotifyFriendsAboutStatusChange(userId, false);
                }
            }
        }

        private void AttachChannelDisconnectHandlers(
            int userId,
            IFriendshipServiceCallback callback,
            IContextChannel channel)
        {
            if (channel != null)
            {
                ChannelDisconnectObserver observer = new ChannelDisconnectObserver(this, userId, callback);
                channel.Closed += observer.OnChannelClosedOrFaulted;
                channel.Faulted += observer.OnChannelClosedOrFaulted;
            }
        }

        private void NotifyFriendsAboutStatusChange(int userId, bool isOnline)
        {
            List<FriendSummaryData> friends = _friendshipUseCase.GetFriendsListByUserId(userId);

            foreach (FriendSummaryData friend in friends)
            {
                NotifySingleFriendStatus(friend.IdUser, userId, isOnline);
            }
        }

        private static void TrySendFriendRequestCallback(
            FriendRequest friendRequest,
            IFriendshipServiceCallback receiverCallback)
        {
            int subscriberUserId = friendRequest.ReceiverUserId;

            try
            {
                if (IsCallbackChannelOpen(receiverCallback))
                {
                    receiverCallback.OnReceiveFriendRequest(friendRequest);
                }
                else
                {
                    s_onlineSubscribers.TryRemove(subscriberUserId, out IFriendshipServiceCallback _);
                }
            }
            catch (TimeoutException)
            {
                s_onlineSubscribers.TryRemove(subscriberUserId, out IFriendshipServiceCallback _);
            }
            catch (CommunicationException)
            {
                s_onlineSubscribers.TryRemove(subscriberUserId, out IFriendshipServiceCallback _);
            }
        }

        private static bool IsValidUserId(int userId)
        {
            return userId > 0;
        }

        private static void TrySendStatusChangedCallback(
            int targetSubscriberUserId,
            IFriendshipServiceCallback callback,
            int friendUserId,
            bool isOnline)
        {
            try
            {
                if (IsCallbackChannelOpen(callback))
                {
                    callback.OnFriendStatusChanged(friendUserId, isOnline);
                }
                else
                {
                    s_onlineSubscribers.TryRemove(targetSubscriberUserId, out IFriendshipServiceCallback _);
                }
            }
            catch (TimeoutException)
            {
                s_onlineSubscribers.TryRemove(targetSubscriberUserId, out IFriendshipServiceCallback _);
            }
            catch (CommunicationException)
            {
                s_onlineSubscribers.TryRemove(targetSubscriberUserId, out IFriendshipServiceCallback _);
            }
        }

        private static void TrySendFriendRemovedCallback(
            int targetSubscriberUserId,
            IFriendshipServiceCallback callback,
            int removedByUserId)
        {
            try
            {
                if (IsCallbackChannelOpen(callback))
                {
                    callback.OnFriendRemoved(removedByUserId);
                }
                else
                {
                    s_onlineSubscribers.TryRemove(targetSubscriberUserId, out IFriendshipServiceCallback _);
                }
            }
            catch (TimeoutException)
            {
                s_onlineSubscribers.TryRemove(targetSubscriberUserId, out IFriendshipServiceCallback _);
            }
            catch (CommunicationException)
            {
                s_onlineSubscribers.TryRemove(targetSubscriberUserId, out IFriendshipServiceCallback _);
            }
        }

        private static void TrySendGameInvitationCallback(GameInvitation gameInvitation, IFriendshipServiceCallback receiverCallback)
        {
            try
            {
                if (IsCallbackChannelOpen(receiverCallback))
                {
                    receiverCallback.OnReceiveGameInvitation(gameInvitation);
                }
                else
                {
                    s_onlineSubscribers.TryRemove(gameInvitation.ReceiverUserId, out IFriendshipServiceCallback _);
                }
            }
            catch (TimeoutException)
            {
                s_onlineSubscribers.TryRemove(gameInvitation.ReceiverUserId, out IFriendshipServiceCallback _);
            }
            catch (CommunicationException)
            {
                s_onlineSubscribers.TryRemove(gameInvitation.ReceiverUserId, out IFriendshipServiceCallback _);
            }
        }

        private static bool IsCallbackChannelOpen(IFriendshipServiceCallback callback)
        {
            ICommunicationObject communicationChannel = callback as ICommunicationObject;
            return communicationChannel == null || communicationChannel.State == CommunicationState.Opened;
        }

        private static Friend MapToFriend(FriendSummaryData friendSummaryData)
        {
            bool isCurrentlyConnected = IsUserOnline(friendSummaryData.IdUser);
            return new Friend
            {
                UserId = friendSummaryData.IdUser,
                Username = friendSummaryData.Username,
                IsOnline = isCurrentlyConnected
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
