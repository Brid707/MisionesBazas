using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Application.Models;
using Application.Models.Friendship;
using Application.Ports;
using TrickTakingMissions.Logging.Abstractions.Ports;

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

        private const string FriendshipValidationFailedTemplate =
            "Friendship operation rejected due to invalid user parameters for users {UserId1} and {UserId2}.";
        private const string SendFriendRequestInvalidParametersTemplate =
            "Friend request rejected due to invalid sender or target parameter from user {SenderUserId}.";
        private const string FriendRequestTargetUserNotFoundTemplate =
            "Cannot send friend request: target user {TargetUsername} was not found for sender {SenderUserId}.";
        private const string FriendRequestSelfTargetTemplate =
            "User {SenderUserId} cannot send a friend request to themselves.";
        private const string FriendRequestBlockedPlayerTemplate =
            "Cannot send friend request from user {SenderUserId} to user {ReceiverUserId} due to active block.";
        private const string FriendRequestAlreadyExistsTemplate =
            "Friend request rejected: friendship or pending request already exists between user {SenderUserId} " +
            "and user {ReceiverUserId}.";
        private const string FriendRequestNotFoundWarningTemplate =
            "Pending friend request was not found between receiver {ReceiverUserId} and sender {SenderUserId}.";

        private const string FriendRequestSentSuccessfullyTemplate =
            "Friend request sent successfully from user {SenderUserId} to user {ReceiverUserId}.";
        private const string FriendRequestAcceptedTemplate =
            "Friend request accepted by user {ReceiverUserId} from user {SenderUserId}.";
        private const string FriendRequestRejectedTemplate =
            "Friend request rejected by user {ReceiverUserId} from user {SenderUserId}.";
        private const string FriendRequestCancelledTemplate =
            "Friend request cancelled by sender {SenderUserId} for receiver {ReceiverUserId}.";
        private const string FriendRemovedSuccessfullyTemplate =
            "Friendship between user {UserId} and friend {FriendUserId} was removed.";
        private const string PlayerBlockedSuccessfullyTemplate =
            "Player {TargetUserId} was blocked by user {BlockerUserId}.";
        private const string PlayerUnblockedSuccessfullyTemplate =
            "Player {TargetUserId} was unblocked by user {BlockerUserId}.";
        private const string FriendshipActionPersistenceFailureTemplate =
            "Friendship action '{Action}' between users {SourceUserId} and {TargetUserId} aborted due to database failure.";
        private const string SendFriendRequestPersistenceFailureTemplate =
            "Send friend request from user {SenderUserId} to '{TargetUsername}' aborted due to database failure.";
        private const string FriendshipQueryPersistenceFailureTemplate =
            "Retrieving '{QueryType}' for user {UserId} failed due to database failure.";

        private const string ActionAccept = "Accept";
        private const string ActionBlock = "Block";
        private const string ActionCancel = "Cancel";
        private const string ActionReject = "Reject";
        private const string ActionRemove = "Remove";
        private const string ActionUnblock = "Unblock";

        private const string QueryFriendsList = "FriendsList";
        private const string QueryPendingRequests = "PendingRequests";
        private const string QuerySentRequests = "SentRequests";

        private readonly IFriendshipRepository _friendshipRepository;
        private readonly IUserRepository _userRepository;
        private readonly ILoggerService _logger;

        public FriendshipUseCase(IFriendshipRepository friendshipRepository, IUserRepository userRepository,
            ILoggerService logger)
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
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
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
                    _logger.Warning(FriendshipActionPersistenceFailureTemplate, ActionAccept, senderUserId, receiverUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(FriendshipValidationFailedTemplate, receiverUserId, senderUserId);
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
                    _logger.Information(PlayerBlockedSuccessfullyTemplate, targetUserId, blockerUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true,
                        ErrorCodeSuccess, MessagePlayerBlocked);
                }
                catch (InvalidOperationException)
                {
                    _logger.Warning(FriendshipActionPersistenceFailureTemplate, ActionBlock, blockerUserId, targetUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(FriendshipValidationFailedTemplate, blockerUserId, targetUserId);
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
                    if (friendshipActionOutcome.IsSuccess)
                    {
                        _logger.Information(FriendRequestCancelledTemplate, senderUserId, receiverUserId);
                    }
                }
                catch (InvalidOperationException)
                {
                    _logger.Warning(FriendshipActionPersistenceFailureTemplate, ActionCancel, senderUserId, receiverUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(FriendshipValidationFailedTemplate, senderUserId, receiverUserId);
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
                    _logger.Warning(FriendshipQueryPersistenceFailureTemplate, QueryFriendsList, userId);
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
                    _logger.Warning(FriendshipQueryPersistenceFailureTemplate, QueryPendingRequests, userId);
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
                    _logger.Warning(FriendshipQueryPersistenceFailureTemplate, QuerySentRequests, userId);
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
                    if (friendshipActionOutcome.IsSuccess)
                    {
                        _logger.Information(FriendRequestRejectedTemplate, receiverUserId, senderUserId);
                    }
                }
                catch (InvalidOperationException)
                {
                    _logger.Warning(FriendshipActionPersistenceFailureTemplate, ActionReject, senderUserId, receiverUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(FriendshipValidationFailedTemplate, receiverUserId, senderUserId);
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
                    _logger.Information(FriendRemovedSuccessfullyTemplate, userId, friendUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true,
                        ErrorCodeSuccess, MessageFriendRemoved);
                }
                catch (InvalidOperationException)
                {
                    _logger.Warning(FriendshipActionPersistenceFailureTemplate, ActionRemove, userId, friendUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(FriendshipValidationFailedTemplate, userId, friendUserId);
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
                    _logger.Warning(SendFriendRequestPersistenceFailureTemplate, senderUserId, targetUsername.Trim());
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodePersistenceFailure,
                        ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(SendFriendRequestInvalidParametersTemplate, senderUserId);
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
                    _logger.Information(PlayerUnblockedSuccessfullyTemplate, targetUserId, blockerUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(true,
                        ErrorCodeSuccess, MessagePlayerUnblocked);
                }
                catch (InvalidOperationException)
                {
                    _logger.Warning(FriendshipActionPersistenceFailureTemplate, ActionUnblock, blockerUserId, targetUserId);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false,
                        ErrorCodePersistenceFailure, ErrorMessagePersistenceFailure);
                }
            }
            else
            {
                _logger.Warning(FriendshipValidationFailedTemplate, blockerUserId, targetUserId);
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
                _logger.Information(FriendRequestAcceptedTemplate, receiverUserId, senderUserId);
                friendshipActionOutcome = CreateFriendshipActionOutcome(true, ErrorCodeSuccess,
                    MessageFriendRequestAccepted);
            }
            else
            {
                _logger.Warning(FriendRequestNotFoundWarningTemplate, receiverUserId, senderUserId);
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
                _logger.Warning(FriendRequestNotFoundWarningTemplate, receiverUserId, senderUserId);
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
                _logger.Warning(FriendRequestTargetUserNotFoundTemplate, targetUsername, senderUserId);
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeUserNotFound,
                    ErrorMessageTargetUserNotFound);
            }
            else if (targetUser.IdUser == senderUserId)
            {
                _logger.Warning(FriendRequestSelfTargetTemplate, senderUserId);
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeValidationFailed,
                    ErrorMessageInvalidParameters);
            }
            else if (_friendshipRepository.IsPlayerBlockedByPlayerA(senderUserId, targetUser.IdUser))
            {
                _logger.Warning(FriendRequestBlockedPlayerTemplate, senderUserId, targetUser.IdUser);
                friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodePlayerBlocked,
                    ErrorMessagePlayerBlocked);
            }
            else
            {
                FriendshipRecordData existingFriendship = await _friendshipRepository.GetFriendshipAsync(
                    senderUserId, targetUser.IdUser);

                if (existingFriendship != null)
                {
                    _logger.Warning(FriendRequestAlreadyExistsTemplate, senderUserId, targetUser.IdUser);
                    friendshipActionOutcome = CreateFriendshipActionOutcome(false, ErrorCodeDuplicateOrInvalidState,
                        ErrorMessageAlreadyFriendsOrPending);
                }
                else
                {
                    await _friendshipRepository.CreateFriendRequestAsync(senderUserId, targetUser.IdUser);
                    _logger.Information(FriendRequestSentSuccessfullyTemplate, senderUserId, targetUser.IdUser);
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
