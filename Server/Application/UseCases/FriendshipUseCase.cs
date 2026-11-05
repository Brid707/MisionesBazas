using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Application.Models;
using Application.Models.Friendship;
using Application.Ports;

namespace Application.UseCases
{
    public sealed class FriendshipUseCase : IFriendshipUseCase
    {
        private const byte PendingFriendshipStatus = 1;
        private const byte AcceptedFriendshipStatus = 2;

        private const int ErrorCodeSuccess = 0;
        private const int ErrorCodeValidationFailed = 101;
        private const int ErrorCodeUserNotFound = 102;
        private const int ErrorCodeDuplicateOrInvalidState = 103;
        private const int ErrorCodePlayerBlocked = 104;
        private const int ErrorCodePersistenceFailure = 201;

        private const string MessageFriendRequestSent = "Friend request sent successfully.";
        private const string MessageFriendRequestAccepted = "Friend request accepted.";
        private const string MessageFriendRequestRejected = "Friend request rejected.";
        private const string MessageFriendRequestCancelled = "Friend request cancelled.";
        private const string MessageFriendRemoved = "Friend removed successfully.";
        private const string MessagePlayerBlocked = "Player blocked successfully.";
        private const string MessagePlayerUnblocked = "Player unblocked successfully.";
        private const string ErrorMessageInvalidParameters = "Invalid user parameters.";
        private const string ErrorMessageTargetUserNotFound = "Target player was not found.";
        private const string ErrorMessagePlayerBlocked = "Cannot send a friend request due to an active block.";
        private const string ErrorMessageAlreadyFriendsOrPending = "A friendship or pending request already exists.";
        private const string ErrorMessageRequestNotFound = "Pending friend request was not found.";
        private const string ErrorMessagePersistenceFailure = "Database error while processing friendship operation.";

        private readonly IFriendshipRepository _friendshipRepository;
        private readonly IUserRepository _userRepository;

        public FriendshipUseCase(IFriendshipRepository friendshipRepository, IUserRepository userRepository)
        {
            if (friendshipRepository == null)
            {
                throw new ArgumentNullException(nameof(friendshipRepository));
            }
            if (userRepository == null)
            {
                throw new ArgumentNullException(nameof(userRepository));
            }

            _friendshipRepository = friendshipRepository;
            _userRepository = userRepository;
        }

        public async Task<FriendshipActionOutcome> AcceptFriendRequestAsync(int receiverUserId, int senderUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(receiverUserId) && IsValidUserId(senderUserId)
                && AreDistinctUserIds(receiverUserId, senderUserId))
            {
                try
                {
                    friendshipActionOutcome = await
                        ProcessAcceptRequestAsync(receiverUserId, senderUserId);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                    ErrorCodeValidationFailed, ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        public FriendshipActionOutcome BlockPlayer(int blockerUserId, int targetUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(blockerUserId) && IsValidUserId(targetUserId)
                && AreDistinctUserIds(blockerUserId, targetUserId))
            {
                try
                {
                    _friendshipRepository.BlockPlayer(blockerUserId, targetUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true,
                        ErrorCodeSuccess, MessagePlayerBlocked);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                    ErrorCodeValidationFailed, ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        public async Task<FriendshipActionOutcome> CancelFriendRequestAsync(int senderUserId, int receiverUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(senderUserId) && IsValidUserId(receiverUserId)
                && AreDistinctUserIds(senderUserId, receiverUserId))
            {
                try
                {
                    friendshipActionOutcome = await ProcessRemovePendingRequestAsync(
                        receiverUserId,
                        senderUserId,
                        MessageFriendRequestCancelled);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                    ErrorCodeValidationFailed, ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        public List<FriendSummaryData> GetFriendsListByUserId(int userId)
        {
            List<FriendSummaryData> friends = new List<FriendSummaryData>();

            if (IsValidUserId(userId))
            {
                try
                {
                    friends = _friendshipRepository.GetFriendsListByUserId(userId);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                }
            }

            return friends;
        }

        public async Task<List<FriendRequestData>> GetPendingFriendRequestsByUserIdAsync(int userId)
        {
            List<FriendRequestData> pendingFriendRequests = new List<FriendRequestData>();

            if (IsValidUserId(userId))
            {
                try
                {
                    pendingFriendRequests = await
                        _friendshipRepository.GetPendingFriendRequestsByUserIdAsync(userId);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                }
            }

            return pendingFriendRequests;
        }

        public async Task<List<FriendRequestData>> GetSentFriendRequestsByUserIdAsync(int userId)
        {
            List<FriendRequestData> sentFriendRequests = new List<FriendRequestData>();

            if (IsValidUserId(userId))
            {
                try
                {
                    sentFriendRequests = await
                        _friendshipRepository.GetSentFriendRequestsByUserIdAsync(userId);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                }
            }

            return sentFriendRequests;
        }

        public async Task<FriendshipActionOutcome> RejectFriendRequestAsync(int receiverUserId, int senderUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(receiverUserId) && IsValidUserId(senderUserId)
                && AreDistinctUserIds(receiverUserId, senderUserId))
            {
                try
                {
                    friendshipActionOutcome = await ProcessRemovePendingRequestAsync(
                        receiverUserId,
                        senderUserId,
                        MessageFriendRequestRejected);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                    ErrorCodeValidationFailed, ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        public FriendshipActionOutcome RemoveFriend(int userId, int friendUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(userId) && IsValidUserId(friendUserId)
                && AreDistinctUserIds(userId, friendUserId))
            {
                try
                {
                    _friendshipRepository.RemoveFriendship(userId, friendUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true,
                        ErrorCodeSuccess, MessageFriendRemoved);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                    ErrorCodeValidationFailed, ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        public async Task<FriendshipActionOutcome> SendFriendRequestAsync(int senderUserId, string targetUsername)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(senderUserId) && !string.IsNullOrWhiteSpace(targetUsername))
            {
                try
                {
                    friendshipActionOutcome = await ProcessSendFriendRequestAsync(senderUserId,
                        targetUsername.Trim());
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodePersistenceFailure,
                        ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeValidationFailed,
                    ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        public FriendshipActionOutcome UnblockPlayer(int blockerUserId, int targetUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;

            if (IsValidUserId(blockerUserId) && IsValidUserId(targetUserId)
                && AreDistinctUserIds(blockerUserId, targetUserId))
            {
                try
                {
                    _friendshipRepository.UnblockPlayer(blockerUserId, targetUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true,
                        ErrorCodeSuccess, MessagePlayerUnblocked);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                    ErrorCodeValidationFailed, ErrorMessageInvalidParameters);
            }

            return friendshipActionOutcome;
        }

        private static bool IsPendingForReceiver(FriendshipRecordData friendshipRecordData, int receiverUserId)
        {
            bool isPendingForReceiver = false;

            if (friendshipRecordData != null && friendshipRecordData.Status == PendingFriendshipStatus)
            {
                int expectedReceiverUserId = friendshipRecordData.IsRequestedByLow
                    ? friendshipRecordData.IdUserHigh
                    : friendshipRecordData.IdUserLow;

                isPendingForReceiver = expectedReceiverUserId == receiverUserId;
            }

            return isPendingForReceiver;
        }

        private async Task<FriendshipActionOutcome> ProcessAcceptRequestAsync(int receiverUserId, int senderUserId)
        {
            FriendshipActionOutcome friendshipActionOutcome;
            FriendshipRecordData friendshipRecordData = await _friendshipRepository
                .GetFriendshipAsync(receiverUserId, senderUserId);

            if (IsPendingForReceiver(friendshipRecordData, receiverUserId))
            {
                await _friendshipRepository.UpdateFriendshipStatusAsync(receiverUserId, senderUserId,
                    AcceptedFriendshipStatus);
                friendshipActionOutcome = CreateFriendshipActionOutcome(true, ErrorCodeSuccess,
                    MessageFriendRequestAccepted);
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeDuplicateOrInvalidState,
                    ErrorMessageRequestNotFound);
            }

            return friendshipActionOutcome;
        }

        private async Task<FriendshipActionOutcome> ProcessRemovePendingRequestAsync(
            int receiverUserId,
            int senderUserId,
            string successMessage)
        {
            FriendshipActionOutcome friendshipActionOutcome;
            FriendshipRecordData friendshipRecordData = await
                _friendshipRepository.GetFriendshipAsync(receiverUserId, senderUserId);

            if (IsPendingForReceiver(friendshipRecordData, receiverUserId))
            {
                await _friendshipRepository.DeleteFriendshipAsync(receiverUserId, senderUserId);
                friendshipActionOutcome = CreateFriendshipActionOutcome(true, ErrorCodeSuccess,
                    successMessage);
            }
            else
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeDuplicateOrInvalidState,
                    ErrorMessageRequestNotFound);
            }

            return friendshipActionOutcome;
        }

        private async Task<FriendshipActionOutcome> ProcessSendFriendRequestAsync(int senderUserId,
            string targetUsername)
        {
            FriendshipActionOutcome friendshipActionOutcome;
            UserAccount targetUser = _userRepository.GetUserByUsername(targetUsername);

            if (targetUser == null)
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeUserNotFound,
                    ErrorMessageTargetUserNotFound);
            }
            else if (targetUser.IdUser == senderUserId)
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeValidationFailed,
                    ErrorMessageInvalidParameters);
            }
            else if (_friendshipRepository.IsPlayerBlockedByPlayerA(senderUserId, targetUser.IdUser))
            {
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodePlayerBlocked,
                    ErrorMessagePlayerBlocked);
            }
            else
            {
                FriendshipRecordData existingFriendship = await _friendshipRepository.GetFriendshipAsync(
                    senderUserId, targetUser.IdUser);

                if (existingFriendship != null)
                {
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeDuplicateOrInvalidState,
                        ErrorMessageAlreadyFriendsOrPending);
                }
                else
                {
                    await _friendshipRepository.CreateFriendRequestAsync(senderUserId, targetUser.IdUser);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true, ErrorCodeSuccess,
                        MessageFriendRequestSent);
                }
            }

            return friendshipActionOutcome;
        }

        private static bool IsValidUserId(int userId)
        {
            return userId > 0;
        }

        private static bool AreDistinctUserIds(int userId1, int userId2)
        {
            return userId1 != userId2;
        }

        private static FriendshipActionOutcome CreateFriendshipActionOutcome(bool isSuccess,
            int errorCode, string message)
        {
            return new FriendshipActionOutcome
            {
                IsSuccess = isSuccess,
                ErrorCode = errorCode,
                Message = message
            };
        }
    }
}
