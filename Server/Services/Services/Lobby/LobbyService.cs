using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.ServiceModel;
using System.Text.RegularExpressions;
using System.Threading;
using Application.Models;
using Application.Ports;
using Domain;
using Services.Contracts;
using Services.DataContracts;
using Services.Security;

namespace Services.Services
{
    /// <summary>
    /// WCF service implementation for managing multiplayer lobby rooms and dispatching real-time callbacks.
    /// </summary>
    [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public sealed partial class LobbyService : ILobbyService
    {
        private const string PlayerLeftReason = "Player left the lobby.";
        private const string PlayerKickedReason = "Player was kicked by the host.";
        private const byte UnspecifiedSettingValue = 0;

        private static readonly ConcurrentDictionary<string,
            ConcurrentDictionary<int, ILobbyCallback>> s_roomCallbacks =
                new ConcurrentDictionary<string, ConcurrentDictionary<int, ILobbyCallback>>(
                    StringComparer.OrdinalIgnoreCase);

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly ILobbyChatMessageUseCase _lobbyChatMessageUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;

        public LobbyService(ILobbyUseCase lobbyUseCase, ILobbyChatMessageUseCase lobbyChatMessageUseCase,
            IAccountAccessPolicy accountAccessPolicy)
        {
            if (lobbyUseCase == null)
            {
                throw new ArgumentNullException(nameof(lobbyUseCase));
            }

            _lobbyUseCase = lobbyUseCase;
            _lobbyChatMessageUseCase = lobbyChatMessageUseCase;
            _accountAccessPolicy = accountAccessPolicy;
        }

        public LobbyResult UpdateLobbySettings(string lobbyCode, int requesterUserId, LobbySettings settings)
        {
            EnsureParticipantOperationAllowed(requesterUserId);
            EnsureRegisteredRoomChannel(lobbyCode, requesterUserId);
            LobbyActionOutcome configurationUpdate = _lobbyUseCase.UpdateLobbySettings(
                lobbyCode, requesterUserId, MapLobbyConfiguration(settings));
            if (configurationUpdate.IsSuccess)
            {
                PublishLobbyState(configurationUpdate);
            }

            return MapToLobbyResult(configurationUpdate);
        }

        private static LobbyConfiguration MapLobbyConfiguration(LobbySettings settings)
        {
            return new LobbyConfiguration
            {
                TargetMissionCount = settings?.TargetMissionCount ?? UnspecifiedSettingValue,
                PlayerLimit = settings?.PlayerLimit ?? UnspecifiedSettingValue,
                IsPrivate = settings?.IsPrivate ?? true
            };
        }

        private static void EnsureRegisteredRoomChannel(string lobbyCode, int requesterUserId)
        {
            ILobbyCallback requesterCallback = null;
            bool hasRegisteredChannel = s_roomCallbacks.TryGetValue(NormalizeRoomKey(lobbyCode),
                out ConcurrentDictionary<int, ILobbyCallback> participants) &&
                participants.TryGetValue(requesterUserId, out requesterCallback);
            IContextChannel callbackChannel = requesterCallback as IContextChannel;
            if (!hasRegisteredChannel || callbackChannel?.SessionId != OperationContext.Current?.SessionId)
            {
                throw new FaultException("LobbyHostRequired");
            }
        }

        private void PublishLobbyState(LobbyActionOutcome lobbyActionOutcome)
        {
            Lobby confirmedLobby = MapToLobbyResult(lobbyActionOutcome).Lobby;
            if (confirmedLobby != null)
            {
                BroadcastToRoom(confirmedLobby.LobbyCode, null,
                    callback => callback.OnLobbyStateChanged(confirmedLobby));
            }
        }

        private void ObserveParticipantChannel(ILobbyCallback callback)
        {
            ICommunicationObject participantChannel = callback as ICommunicationObject;
            if (participantChannel != null)
            {
                participantChannel.Closed += OnParticipantChannelDisconnected;
                participantChannel.Faulted += OnParticipantChannelDisconnected;
            }
        }

        private void OnParticipantChannelDisconnected(object sender, EventArgs e)
        {
            foreach (KeyValuePair<string, ConcurrentDictionary<int, ILobbyCallback>> room
                in s_roomCallbacks.ToArray())
            {
                RemoveMatchingDisconnectedChannel(room, sender);
            }
        }

        private void RemoveMatchingDisconnectedChannel(
            KeyValuePair<string, ConcurrentDictionary<int, ILobbyCallback>> room, object disconnectedChannel)
        {
            foreach (KeyValuePair<int, ILobbyCallback> participant in room.Value.ToArray())
            {
                if (ReferenceEquals(participant.Value, disconnectedChannel))
                {
                    HandleParticipantChannelLoss(room.Key, participant.Key, participant.Value);
                }
            }
        }

        private void HandleParticipantChannelLoss(string lobbyCode, int participantUserId, ILobbyCallback callback)
        {
            if (s_roomCallbacks.TryGetValue(NormalizeRoomKey(lobbyCode),
                out ConcurrentDictionary<int, ILobbyCallback> participants))
            {
                RemoveCurrentDisconnectedChannel(participants, participantUserId, callback);
            }
        }

        private void RemoveCurrentDisconnectedChannel(ConcurrentDictionary<int, ILobbyCallback> participants,
            int participantUserId, ILobbyCallback callback)
        {
            bool hasRemovedCurrentChannel = ((ICollection<KeyValuePair<int, ILobbyCallback>>)participants)
                .Remove(new KeyValuePair<int, ILobbyCallback>(participantUserId, callback));
            if (hasRemovedCurrentChannel)
            {
                string lobbyCode = FindCallbackRoomCode(participants);
                LobbyActionOutcome participantDeparture = _lobbyUseCase.DisconnectLobbyParticipant(
                    lobbyCode, participantUserId);
                NotifyPlayerDeparture(participantDeparture, participantUserId, "ConnectionLost");
            }
        }

        private static string FindCallbackRoomCode(ConcurrentDictionary<int, ILobbyCallback> participants)
        {
            return s_roomCallbacks.FirstOrDefault(room => ReferenceEquals(room.Value, participants)).Key ??
                string.Empty;
        }

        public LobbyResult CreateLobby(int hostUserId, LobbySettings settings)
        {
            EnsureParticipantOperationAllowed(hostUserId);
            LobbyActionOutcome lobbyActionOutcome = _lobbyUseCase.CreateLobby(hostUserId,
                MapLobbyConfiguration(settings));
            if (lobbyActionOutcome.IsSuccess && lobbyActionOutcome.Lobby != null)
            {
                RegisterCurrentCallback(lobbyActionOutcome.Lobby.LobbyCode, hostUserId);
            }

            LobbyResult entryDecision = MapToLobbyResult(lobbyActionOutcome);
            if (hostUserId < 0)
            {
                entryDecision.GuestSessionToken = GuestParticipantCredentials.GetCredential(hostUserId);
            }
            return entryDecision;
        }

        public LobbyResult JoinLobbyByCode(string lobbyCode, int userId)
        {
            EnsureParticipantOperationAllowed(userId);
            LobbyActionOutcome lobbyActionOutcome = _lobbyUseCase.JoinLobby(lobbyCode, userId);
            if (lobbyActionOutcome.IsSuccess && lobbyActionOutcome.Lobby != null &&
                lobbyActionOutcome.AffectedPlayer != null)
            {
                string canonicalCode = lobbyActionOutcome.Lobby.LobbyCode;
                RegisterCurrentCallback(canonicalCode, userId);

                LobbyPlayer joinedPlayer = MapToPlayerDto(lobbyActionOutcome.AffectedPlayer);
                BroadcastToRoom(
                    canonicalCode,
                    userId,
                    callback => callback.OnPlayerJoinedLobby(joinedPlayer));
                PublishLobbyState(lobbyActionOutcome);
            }

            LobbyResult entryDecision = MapToLobbyResult(lobbyActionOutcome);
            if (userId < 0)
            {
                entryDecision.GuestSessionToken = GuestParticipantCredentials.GetCredential(userId);
            }
            return entryDecision;
        }

        public void LeaveLobby(string lobbyCode, int userId)
        {
            EnsureParticipantOperationAllowed(userId);
            LobbyActionOutcome lobbyActionOutcome = _lobbyUseCase.LeaveLobby(lobbyCode, userId);
            if (lobbyActionOutcome.IsSuccess)
            {
                UnregisterCallback(lobbyCode, userId);
                NotifyPlayerDeparture(lobbyActionOutcome, userId, PlayerLeftReason);
            }
        }

        public void KickPlayerByUserId(string lobbyCode, int hostUserId, int targetUserId)
        {
            EnsureParticipantOperationAllowed(hostUserId);
            EnsureRegisteredRoomChannel(lobbyCode, hostUserId);
            LobbyActionOutcome lobbyActionOutcome = _lobbyUseCase.KickPlayer(lobbyCode, hostUserId, targetUserId);
            if (lobbyActionOutcome.IsSuccess)
            {
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnPlayerLeftLobby(targetUserId, PlayerKickedReason));
                UnregisterCallback(lobbyCode, targetUserId);
                PublishLobbyState(lobbyActionOutcome);
            }
        }

        /// <summary>Authenticates the current host before restoring a removed player's room access.</summary>
        public LobbyResult AuthorizeKickedPlayerReentry(string lobbyCode, int hostUserId, int targetUserId)
        {
            EnsureParticipantOperationAllowed(hostUserId);
            EnsureRegisteredRoomChannel(lobbyCode, hostUserId);
            LobbyActionOutcome reentryAuthorization = _lobbyUseCase.AuthorizeKickedPlayerReentry(
                lobbyCode, hostUserId, targetUserId);
            return MapToLobbyResult(reentryAuthorization);
        }

        public void SetPlayerReadyStatus(string lobbyCode, int userId, bool isReady)
        {
            EnsureParticipantOperationAllowed(userId);
            LobbyActionOutcome lobbyActionOutcome = _lobbyUseCase.UpdatePlayerReadiness(lobbyCode, userId, isReady);
            if (lobbyActionOutcome.IsSuccess)
            {
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnPlayerReadyStatusChanged(userId, isReady));
                PublishLobbyState(lobbyActionOutcome);
            }
        }

        public LobbyChatMessageSubmissionOutcome SendLobbyChatMessage(
            LobbyChatMessageSubmission chatMessageSubmission)
        {
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = new LobbyChatMessageSubmissionOutcome
            {
                ChatMessageRejectionReason = ChatMessageRejectionReason.InvalidChatMessage
            };
            try
            {
                chatMessageSubmissionOutcome = ProcessAuthenticatedChatMessage(chatMessageSubmission);
            }
            catch (SqlException)
            {
                chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                    ChatMessageRejectionReason.ChatStorageUnavailable;
            }
            catch (InvalidOperationException)
            {
                chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                    ChatMessageRejectionReason.ChatStorageUnavailable;
            }
            catch (RegexMatchTimeoutException)
            {
                chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                    ChatMessageRejectionReason.ChatModerationUnavailable;
            }
            catch (ArgumentException)
            {
                chatMessageSubmissionOutcome.ChatMessageRejectionReason = ChatMessageRejectionReason.InvalidChatMessage;
            }

            return chatMessageSubmissionOutcome;
        }

        private LobbyChatMessageSubmissionOutcome ProcessAuthenticatedChatMessage(
            LobbyChatMessageSubmission chatMessageSubmission)
        {
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = new LobbyChatMessageSubmissionOutcome
            {
                ChatMessageRejectionReason = ChatMessageRejectionReason.ChatAuthenticationRequired
            };
            int authenticatedAccountUserId = _accountAccessPolicy.ResolveAllowedAccountUserId(
                AccountSessionHeader.ReadCurrentAccountSessionToken());
            if (chatMessageSubmission != null && authenticatedAccountUserId > 0)
            {
                chatMessageSubmissionOutcome.ChatMessageSubmissionId = chatMessageSubmission.ChatMessageSubmissionId;
                string participantUsername = _lobbyUseCase.GetParticipantUsername(
                    chatMessageSubmission.LobbyCode, authenticatedAccountUserId);
                if (!string.IsNullOrEmpty(participantUsername))
                {
                    chatMessageSubmissionOutcome = ProcessParticipantChatMessage(chatMessageSubmission,
                        authenticatedAccountUserId, participantUsername);
                }
                else
                {
                    chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                        ChatMessageRejectionReason.ChatParticipantNotInLobby;
                }
            }

            return chatMessageSubmissionOutcome;
        }

        private LobbyChatMessageSubmissionOutcome ProcessParticipantChatMessage(
            LobbyChatMessageSubmission chatMessageSubmission, int authenticatedAccountUserId,
            string participantUsername)
        {
            LobbyChatMessageProcessing chatMessageProcessing = _lobbyChatMessageUseCase.ProcessChatMessage(
                new AuthenticatedChatMessageSubmission
                {
                    AccountUserId = authenticatedAccountUserId,
                    ChatMessageSubmissionId = chatMessageSubmission.ChatMessageSubmissionId,
                    LobbyCode = chatMessageSubmission.LobbyCode,
                    OriginalChatMessageText = chatMessageSubmission.OriginalChatMessageText
                });
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome =
                MapChatSubmissionOutcome(
                chatMessageSubmission, chatMessageProcessing);
            if (chatMessageSubmissionOutcome.ChatAccountBanNotice != null)
            {
                RemoveBannedAccountFromLobbies(
                    authenticatedAccountUserId, chatMessageSubmissionOutcome.ChatAccountBanNotice);
            }
            else if (chatMessageProcessing.CanPublishChatMessage)
            {
                LobbyMessage publishedChatMessage = new LobbyMessage
                {
                    SenderUserId = authenticatedAccountUserId,
                    SenderUsername = participantUsername,
                    Message = chatMessageProcessing.CensoredChatMessageText,
                    SentAt = DateTime.UtcNow
                };
                BroadcastToRoom(chatMessageSubmission.LobbyCode, null,
                    participantCallback => participantCallback.OnReceiveLobbyChatMessage(publishedChatMessage));
            }

            return chatMessageSubmissionOutcome;
        }

        private static LobbyChatMessageSubmissionOutcome MapChatSubmissionOutcome(
            LobbyChatMessageSubmission chatMessageSubmission, LobbyChatMessageProcessing chatMessageProcessing)
        {
            ChatInfractionRecord recordedInfraction = chatMessageProcessing.RecordedChatInfraction;
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = new LobbyChatMessageSubmissionOutcome
            {
                ChatMessageSubmissionId = chatMessageSubmission.ChatMessageSubmissionId,
                ChatMessageRejectionReason = chatMessageProcessing.ChatMessageRejectionReason,
                IsChatMessageAccepted = chatMessageProcessing.ChatMessageRejectionReason ==
                    ChatMessageRejectionReason.None
            };
            if (recordedInfraction != null)
            {
                chatMessageSubmissionOutcome.IsRepeatedChatMessageSubmission =
                    recordedInfraction.IsRepeatedChatMessageSubmission;
                chatMessageSubmissionOutcome.ChatInfractionNotice = CreateChatInfractionNotice(
                    chatMessageSubmission.ChatMessageSubmissionId, recordedInfraction);
                if (recordedInfraction.IsAccountBanned)
                {
                    chatMessageSubmissionOutcome.ChatAccountBanNotice = CreateChatAccountBanNotice(
                        chatMessageSubmission.ChatMessageSubmissionId, recordedInfraction.AccountInfractionState);
                }
            }

            return chatMessageSubmissionOutcome;
        }

        private static ChatInfractionNotice CreateChatInfractionNotice(Guid chatMessageSubmissionId,
            ChatInfractionRecord recordedInfraction)
        {
            ChatAccountInfractionState accountInfractionState = recordedInfraction.AccountInfractionState;
            return new ChatInfractionNotice
            {
                ChatMessageSubmissionId = chatMessageSubmissionId,
                CurrentMessageInfractionPoints = recordedInfraction.CurrentMessageInfractionPoints,
                AccumulatedChatInfractionPoints = accountInfractionState.AccumulatedChatInfractionPoints,
                ChatInfractionPointThreshold = ChatInfractionRules.ChatInfractionPointThreshold,
                RemainingChatInfractionPointsBeforeBan = Math.Max(0, ChatInfractionRules.ChatInfractionPointThreshold -
                    accountInfractionState.AccumulatedChatInfractionPoints),
                ThreateningChatMessageCount = accountInfractionState.ThreateningChatMessageCount
            };
        }

        private static ChatAccountBanNotice CreateChatAccountBanNotice(Guid chatMessageSubmissionId,
            ChatAccountInfractionState accountInfractionState)
        {
            ChatAccountBanType chatAccountBanType = ChatAccountBanType.Temporary;
            if (accountInfractionState.IsChatAccountPermanentlyBanned)
            {
                chatAccountBanType = ChatAccountBanType.Permanent;
            }

            return new ChatAccountBanNotice
            {
                ChatMessageSubmissionId = chatMessageSubmissionId,
                ChatAccountBanType = chatAccountBanType,
                EvaluatedAtUtc = DateTime.UtcNow,
                ChatAccountBanEndsAtUtc = accountInfractionState.ChatAccountBanEndsAtUtc
            };
        }

        private void RemoveBannedAccountFromLobbies(int accountUserId, ChatAccountBanNotice chatAccountBanNotice)
        {
            _accountAccessPolicy.RevokeAccountSessions(accountUserId);
            foreach (KeyValuePair<string, ConcurrentDictionary<int, ILobbyCallback>> lobbyCallbacks in s_roomCallbacks)
            {
                if (lobbyCallbacks.Value.TryGetValue(accountUserId, out ILobbyCallback accountCallback))
                {
                    LobbyActionOutcome accountDepartureOutcome = _lobbyUseCase.LeaveLobby(
                        lobbyCallbacks.Key, accountUserId);
                    UnregisterCallback(lobbyCallbacks.Key, accountUserId);
                    NotifyAccountBanSafely(accountCallback, chatAccountBanNotice);
                    NotifyPlayerDeparture(accountDepartureOutcome, accountUserId, "ParticipantRemoved");
                }
            }
        }

        private static void NotifyAccountBanSafely(ILobbyCallback accountCallback,
            ChatAccountBanNotice chatAccountBanNotice)
        {
            try
            {
                accountCallback.OnChatAccountBanApplied(chatAccountBanNotice);
            }
            catch (CommunicationException)
            {
                // The account restriction is already committed and must not depend on callback delivery.
            }
            catch (TimeoutException)
            {
                // The remaining participants must still receive the account departure notification.
            }
        }

        private void EnsureParticipantOperationAllowed(int participantUserId)
        {
            if (participantUserId < 0)
            {
                GuestParticipantCredentials.EnsureGuestAllowed(participantUserId);
            }
            bool isRegisteredAccountAllowed = _accountAccessPolicy.IsAccountOperationAllowed(
                participantUserId, AccountSessionHeader.ReadCurrentAccountSessionToken());
            if (participantUserId >= 0 && !isRegisteredAccountAllowed)
            {
                throw new FaultException(ChatMessageRejectionReason.ChatAuthenticationRequired.ToString());
            }
        }

        public void StartGameFromLobby(string lobbyCode, int hostUserId)
        {
            EnsureParticipantOperationAllowed(hostUserId);
            EnsureRegisteredRoomChannel(lobbyCode, hostUserId);
            bool canStart;
            try
            {
                canStart = _lobbyUseCase.CanTransitionLobbyToGame(lobbyCode, hostUserId);
            }
            catch (InvalidOperationException ex)
            {
                LogMatchFailure("Match startup rejected", ex);
                throw new FaultException("MatchUnavailable");
            }
            if (canStart)
            {
                int generatedGameId = NormalizeRoomKey(lobbyCode).GetHashCode() & int.MaxValue;
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnGameStarting(generatedGameId));
            }
            else
            {
                throw new FaultException("MatchStartRejected");
            }
        }

        private void NotifyPlayerDeparture(LobbyActionOutcome participantDeparture, int userId, string departureReason)
        {
            if (participantDeparture.Lobby != null && participantDeparture.IsSuccess)
            {
                PublishParticipantDeparture(participantDeparture, userId, departureReason);
            }
        }

        private void PublishParticipantDeparture(LobbyActionOutcome participantDeparture, int userId,
            string departureReason)
        {
            string lobbyCode = participantDeparture.Lobby.LobbyCode;
            if (participantDeparture.IsRoomDisbanded)
            {
                s_roomCallbacks.TryRemove(NormalizeRoomKey(lobbyCode),
                    out ConcurrentDictionary<int, ILobbyCallback> _);
            }
            else
            {
                BroadcastToRoom(lobbyCode, userId,
                    callback => callback.OnPlayerLeftLobby(userId, departureReason));
                PublishLobbyState(participantDeparture);
            }
        }
        private void RegisterCurrentCallback(string lobbyCode, int userId)
        {
            OperationContext context = OperationContext.Current;
            ILobbyCallback callback = context != null
                ? context.GetCallbackChannel<ILobbyCallback>()
                : null;

            if (callback != null)
            {
                string roomKey = NormalizeRoomKey(lobbyCode);
                ConcurrentDictionary<int, ILobbyCallback> participants = s_roomCallbacks.GetOrAdd(
                    roomKey,
                    _ => new ConcurrentDictionary<int, ILobbyCallback>());
                participants[userId] = callback;
                ObserveParticipantChannel(callback);
            }
        }

        private static void UnregisterCallback(string lobbyCode, int userId)
        {
            string roomKey = NormalizeRoomKey(lobbyCode);
            if (s_roomCallbacks.TryGetValue(roomKey, out ConcurrentDictionary<int, ILobbyCallback> participants))
            {
                participants.TryRemove(userId, out ILobbyCallback _);
            }
        }

        private void BroadcastToRoom(
            string lobbyCode,
            int? excludedUserId,
            Action<ILobbyCallback> notificationAction)
        {
            string roomKey = NormalizeRoomKey(lobbyCode);
            if (s_roomCallbacks.TryGetValue(roomKey, out ConcurrentDictionary<int, ILobbyCallback> participants))
            {
                foreach (KeyValuePair<int, ILobbyCallback> entry in participants.ToArray())
                {
                    bool shouldNotify = !excludedUserId.HasValue || entry.Key != excludedUserId.Value;
                    if (shouldNotify)
                    {
                        TryInvokeCallback(participants, entry, notificationAction);
                    }
                }
            }
        }

        private void TryInvokeCallback(
            ConcurrentDictionary<int, ILobbyCallback> participants,
            KeyValuePair<int, ILobbyCallback> entry,
            Action<ILobbyCallback> notificationAction)
        {
            try
            {
                ICommunicationObject communicationChannel = entry.Value as ICommunicationObject;
                bool isChannelOpen = communicationChannel == null ||
                                     communicationChannel.State == CommunicationState.Opened;

                if (isChannelOpen)
                {
                    notificationAction(entry.Value);
                }
                else
                {
                    HandleParticipantChannelLoss(FindCallbackRoomCode(participants), entry.Key, entry.Value);
                }
            }
            catch (TimeoutException)
            {
                // TODO: Log callback timeout failure once official logging infrastructure is available.
                HandleParticipantChannelLoss(FindCallbackRoomCode(participants), entry.Key, entry.Value);
            }
            catch (CommunicationException)
            {
                // TODO: Log callback communication failure once official logging infrastructure is available.
                HandleParticipantChannelLoss(FindCallbackRoomCode(participants), entry.Key, entry.Value);
            }
        }

        private static string NormalizeRoomKey(string lobbyCode)
        {
            return string.IsNullOrWhiteSpace(lobbyCode)
                ? string.Empty
                : lobbyCode.Trim().ToUpperInvariant();
        }

        private LobbyResult MapToLobbyResult(LobbyActionOutcome lobbyActionOutcome)
        {
            Lobby mappedLobby = null;
            if (lobbyActionOutcome.Lobby != null)
            {
                mappedLobby = new Lobby
                {
                    LobbyCode = lobbyActionOutcome.Lobby.LobbyCode,
                    HostUserId = lobbyActionOutcome.Lobby.HostUserId,
                    TargetMissionCount = lobbyActionOutcome.Lobby.TargetMissionCount,
                    PlayerLimit = lobbyActionOutcome.Lobby.PlayerLimit,
                    Status = lobbyActionOutcome.Lobby.Status,
                    IsPrivate = lobbyActionOutcome.Lobby.IsPrivate,
                    IsChatSendingAvailable = _lobbyChatMessageUseCase.IsChatSendingAvailable,
                    StateVersion = lobbyActionOutcome.Lobby.StateVersion,
                    Players = lobbyActionOutcome.Lobby.Players.Select(MapToPlayerDto).ToList()
                };
            }

            return new LobbyResult
            {
                IsSuccess = lobbyActionOutcome.IsSuccess,
                ErrorCode = lobbyActionOutcome.ErrorCode,
                Message = lobbyActionOutcome.Message,
                Lobby = mappedLobby
            };
        }

        private static LobbyPlayer MapToPlayerDto(LobbyParticipantData participant)
        {
            return new LobbyPlayer
            {
                IdUser = participant.IdUser,
                Username = participant.Username,
                IsHost = participant.IsHost,
                IsReady = participant.IsReady
            };
        }
    }
}
