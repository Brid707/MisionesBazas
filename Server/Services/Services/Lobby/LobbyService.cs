using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text.RegularExpressions;
using System.Threading;
using Application.Models;
using Application.Ports;
using Domain;
using Gameplay;
using Services.Contracts;
using Services.DataContracts;
using Services.Mapping;
using Services.Security;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Services.Services
{
    /// <summary>
    /// WCF service implementation for managing multiplayer lobby rooms and dispatching real-time callbacks.
    /// </summary>
    [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public sealed class LobbyService : ILobbyService, IMatchStateChangePublisher
    {
        private const string PlayerLeftReason = "Player left the lobby.";
        private const string PlayerKickedReason = "Player was kicked by the host.";
        private const string ReasonConnectionLost = "ConnectionLost";
        private const string ReasonParticipantRemoved = "ParticipantRemoved";

        private const string FaultLobbyHostRequired = "LobbyHostRequired";
        private const string FaultMatchUnavailable = "MatchUnavailable";
        private const string FaultMatchStartRejected = "MatchStartRejected";
        private const string FaultInvalidSubmission = "InvalidSubmission";
        private const string FaultParticipantNotAllowed = "ParticipantNotAllowed";

        private const string LobbyCallbackChannelClosedTemplate =
            "Lobby callback channel closed for participant {UserId} in room {LobbyCode}.";
        private const string LobbyCallbackTimeoutTemplate =
            "Lobby callback timed out for participant {UserId} in room {LobbyCode}.";
        private const string LobbyCallbackCommunicationFaultedTemplate =
            "Lobby callback communication faulted for participant {UserId} in room {LobbyCode}.";

        private const string ChatStorageFailureTemplate =
            "Storage error occurred during chat message submission for room {LobbyCode}.";
        private const string ChatModerationTimeoutTemplate =
            "Moderation regex matching timed out for room {LobbyCode}.";
        private const string ChatSubmissionInvalidTemplate =
            "Invalid chat submission arguments for room {LobbyCode}.";

        private const string BanCallbackCommunicationFaultedTemplate =
            "Account ban notification callback faulted.";
        private const string BanCallbackTimeoutTemplate =
            "Account ban notification callback timed out.";

        private const string MatchStartupPersistenceFailureTemplate =
            "Match startup rejected due to storage failure in room {LobbyCode}.";
        private const string MatchAccessRejectedTemplate =
            "Match access rejected for participant {UserId} in room {LobbyCode}.";

        private const byte UnspecifiedSettingValue = 0;
        private const int MaximumMatchActionMessagesPerSecond = 8;

        private static readonly ConcurrentDictionary<string,
            ConcurrentDictionary<int, ILobbyCallback>> s_roomCallbacks =
                new ConcurrentDictionary<string, ConcurrentDictionary<int, ILobbyCallback>>(
                    StringComparer.OrdinalIgnoreCase);

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly ILobbyChatMessageUseCase _lobbyChatMessageUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;
        private readonly ILoggerService _logger;

        private readonly LobbyDistressSignalService _distressSignalService;
        private readonly LobbyMatchGameplayService _matchGameplayService;
        private readonly LobbyMissionRetryService _missionRetryService;
        private readonly LobbyObjectiveDraftService _objectiveDraftService;
        private readonly LobbyRadioCommunicationService _radioCommunicationService;
        private readonly LobbySpecialPreparationService _specialPreparationService;

        private readonly object _matchActionRequestGate = new object();
        private MatchActionRequestBudget _matchActionSessionBudget;

        public LobbyService(ILobbyUseCase lobbyUseCase, ILobbyChatMessageUseCase lobbyChatMessageUseCase,
            IAccountAccessPolicy accountAccessPolicy, ILoggerService logger)
        {
            if (lobbyUseCase == null)
            {
                throw new ArgumentNullException(nameof(lobbyUseCase));
            }

            _lobbyUseCase = lobbyUseCase;
            _lobbyChatMessageUseCase = lobbyChatMessageUseCase;
            _accountAccessPolicy = accountAccessPolicy;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));

            _distressSignalService = new LobbyDistressSignalService(
                _lobbyUseCase, PublishMatchStateChange, EnsureMatchActionSessionBudget, EnsureMatchParticipantAllowed);
            _matchGameplayService = new LobbyMatchGameplayService(
                _lobbyUseCase, PublishMatchStateChange, EnsureMatchParticipantAllowed);
            _missionRetryService = new LobbyMissionRetryService(
                _lobbyUseCase, PublishMatchStateChange, EnsureMatchActionSessionBudget, EnsureMatchParticipantAllowed);
            _objectiveDraftService = new LobbyObjectiveDraftService(
                _lobbyUseCase, PublishMatchStateChange, EnsureMatchActionSessionBudget, EnsureMatchParticipantAllowed);
            _radioCommunicationService = new LobbyRadioCommunicationService(
                _lobbyUseCase, PublishMatchStateChange, EnsureMatchActionSessionBudget, EnsureMatchParticipantAllowed);
            _specialPreparationService = new LobbySpecialPreparationService(
                _lobbyUseCase, PublishMatchStateChange, EnsureMatchActionSessionBudget, EnsureMatchParticipantAllowed);
        }

        public LobbyResult UpdateLobbySettings(string lobbyCode, int requesterUserId, LobbySettings settings)
        {
            EnsureParticipantOperationAllowed(requesterUserId);
            EnsureRegisteredRoomChannel(lobbyCode, requesterUserId);
            LobbyActionOutcome configurationUpdate = _lobbyUseCase.UpdateLobbySettings(lobbyCode, requesterUserId,
                MapLobbyConfiguration(settings));
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
                throw new FaultException(FaultLobbyHostRequired);
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
            bool hasRemovedCurrentChannel;
            lock (LobbyMatchPresence.RegistryGate)
            {
                hasRemovedCurrentChannel = ((ICollection<KeyValuePair<int, ILobbyCallback>>)participants)
                    .Remove(new KeyValuePair<int, ILobbyCallback>(participantUserId, callback));
                if (hasRemovedCurrentChannel)
                {
                    LobbyMatchPresence.MarkConnectionsChanged(FindCallbackRoomCode(participants));
                }
            }
            if (hasRemovedCurrentChannel)
            {
                string lobbyCode = FindCallbackRoomCode(participants);
                LobbyActionOutcome participantDeparture = _lobbyUseCase.DisconnectLobbyParticipant(
                    lobbyCode, participantUserId);
                NotifyPlayerDeparture(participantDeparture, participantUserId, ReasonConnectionLost);
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
                ChatMessageRejectionReason = LobbyChatMessageRejectionReason.InvalidChatMessage
            };
            try
            {
                chatMessageSubmissionOutcome = ProcessAuthenticatedChatMessage(chatMessageSubmission);
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, ChatStorageFailureTemplate, chatMessageSubmission?.LobbyCode);
                chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                    LobbyChatMessageRejectionReason.ChatStorageUnavailable;
            }
            catch (RegexMatchTimeoutException)
            {
                _logger.Warning(ChatModerationTimeoutTemplate, chatMessageSubmission?.LobbyCode);
                chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                    LobbyChatMessageRejectionReason.ChatModerationUnavailable;
            }
            catch (ArgumentException)
            {
                _logger.Warning(ChatSubmissionInvalidTemplate, chatMessageSubmission?.LobbyCode);
                chatMessageSubmissionOutcome.ChatMessageRejectionReason =
                    LobbyChatMessageRejectionReason.InvalidChatMessage;
            }

            return chatMessageSubmissionOutcome;
        }

        private LobbyChatMessageSubmissionOutcome ProcessAuthenticatedChatMessage(
            LobbyChatMessageSubmission chatMessageSubmission)
        {
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = new LobbyChatMessageSubmissionOutcome
            {
                ChatMessageRejectionReason = LobbyChatMessageRejectionReason.ChatAuthenticationRequired
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
                        LobbyChatMessageRejectionReason.ChatParticipantNotInLobby;
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
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome = MapChatSubmissionOutcome(
                chatMessageSubmission, chatMessageProcessing);
            if (chatMessageSubmissionOutcome.ChatAccountBanNotice != null)
            {
                RemoveBannedAccountFromLobbies(authenticatedAccountUserId,
                    chatMessageSubmissionOutcome.ChatAccountBanNotice);
            }
            else if (chatMessageProcessing.CanPublishChatMessage && chatMessageSubmissionOutcome.IsChatMessageAccepted)
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
                ChatMessageRejectionReason = LobbyChatMessageRejectionMapper.MapRejectionReason(
                    chatMessageProcessing.ChatMessageRejectionReason),
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
                    NotifyPlayerDeparture(accountDepartureOutcome, accountUserId, ReasonParticipantRemoved);
                }
            }
        }

        private void NotifyAccountBanSafely(ILobbyCallback accountCallback, ChatAccountBanNotice chatAccountBanNotice)
        {
            try
            {
                accountCallback.OnChatAccountBanApplied(chatAccountBanNotice);
            }
            catch (CommunicationException)
            {
                // The account restriction is already committed and must not depend on callback delivery.
                _logger.Warning(BanCallbackCommunicationFaultedTemplate);
            }
            catch (TimeoutException)
            {
                // The remaining participants must still receive the account departure notification.
                _logger.Warning(BanCallbackTimeoutTemplate);
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
                _logger.Error(ex, MatchStartupPersistenceFailureTemplate, lobbyCode);
                throw new FaultException(FaultMatchUnavailable);
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
                throw new FaultException(FaultMatchStartRejected);
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
                lock (LobbyMatchPresence.RegistryGate)
                {
                    s_roomCallbacks.TryRemove(NormalizeRoomKey(lobbyCode),
                        out ConcurrentDictionary<int, ILobbyCallback> _);
                    LobbyMatchPresence.ForgetRoom(NormalizeRoomKey(lobbyCode));
                }
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
                ConcurrentDictionary<int, ILobbyCallback> participants = s_roomCallbacks.GetOrAdd(roomKey,
                    _ => new ConcurrentDictionary<int, ILobbyCallback>());
                lock (LobbyMatchPresence.RegistryGate)
                {
                    bool hasNewChannel = !participants.TryGetValue(userId, out ILobbyCallback previousCallback) ||
                        !ReferenceEquals(previousCallback, callback);
                    participants[userId] = callback;
                    if (hasNewChannel)
                    {
                        LobbyMatchPresence.MarkConnectionsChanged(roomKey);
                    }
                    LobbyMatchPresence.Touch(roomKey, userId, context.SessionId);
                }
                ObserveParticipantChannel(callback);
            }
        }

        private static void UnregisterCallback(string lobbyCode, int userId)
        {
            string roomKey = NormalizeRoomKey(lobbyCode);
            if (s_roomCallbacks.TryGetValue(roomKey, out ConcurrentDictionary<int, ILobbyCallback> participants))
            {
                lock (LobbyMatchPresence.RegistryGate)
                {
                    if (participants.TryRemove(userId, out ILobbyCallback _))
                    {
                        LobbyMatchPresence.MarkConnectionsChanged(roomKey);
                    }
                }
            }
        }

        internal static KeyValuePair<int, ILobbyCallback>[] GetMatchCallbacks(string lobbyCode)
        {
            KeyValuePair<int, ILobbyCallback>[] callbacks = Array.Empty<KeyValuePair<int, ILobbyCallback>>();
            if (s_roomCallbacks.TryGetValue(NormalizeRoomKey(lobbyCode),
                out ConcurrentDictionary<int, ILobbyCallback> participants))
            {
                callbacks = participants.ToArray();
            }
            return callbacks;
        }

        public void PublishMatchStateChange(string lobbyCode, long matchStateVersion)
        {
            BroadcastToRoom(lobbyCode, null, callback => callback.OnMatchStateChanged(matchStateVersion));
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
            string roomCode = FindCallbackRoomCode(participants);
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
                    _logger.Warning(LobbyCallbackChannelClosedTemplate, entry.Key, roomCode);
                    HandleParticipantChannelLoss(roomCode, entry.Key, entry.Value);
                }
            }
            catch (TimeoutException)
            {
                _logger.Warning(LobbyCallbackTimeoutTemplate, entry.Key, roomCode);
                HandleParticipantChannelLoss(roomCode, entry.Key, entry.Value);
            }
            catch (CommunicationException)
            {
                _logger.Warning(LobbyCallbackCommunicationFaultedTemplate, entry.Key, roomCode);
                HandleParticipantChannelLoss(roomCode, entry.Key, entry.Value);
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

        public MissionPreparationConfirmation IdentifyHeartNineOwner(
            HeartNineIdentificationSubmission submission, int participantUserId)
        {
            return _specialPreparationService.IdentifyHeartNineOwner(submission, participantUserId);
        }

        public MissionPreparationConfirmation AssignMissionTrickDistribution(
            MissionTrickDistributionSubmission submission, int participantUserId)
        {
            return _specialPreparationService.AssignMissionTrickDistribution(submission, participantUserId);
        }

        public MissionPreparationConfirmation AssignMissionRole(
            MissionRoleAssignmentSubmission submission, int participantUserId)
        {
            return _specialPreparationService.AssignMissionRole(submission, participantUserId);
        }

        public MissionPreparationConfirmation RespondToBlindObjectives(
            BlindObjectiveResponseSubmission submission, int participantUserId)
        {
            return _specialPreparationService.RespondToBlindObjectives(submission, participantUserId);
        }

        public MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            return _objectiveDraftService.ProcessObjectiveDraftAction(submission, participantUserId);
        }

        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            return _matchGameplayService.GetPlayerMatch(lobbyCode, participantUserId);
        }

        public MissionRetryDecision ConfirmMissionRetry(
            MissionRetrySubmission submission, int participantUserId)
        {
            return _missionRetryService.ConfirmMissionRetry(submission, participantUserId);
        }

        public RadioCommunicationConfirmation SubmitRadioCommunication(
            RadioCommunicationSubmission submission, int participantUserId)
        {
            return _radioCommunicationService.SubmitRadioCommunication(submission, participantUserId);
        }

        public CardPlayDecision PlayCard(
            CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            return _matchGameplayService.PlayCard(cardPlaySubmission, participantUserId);
        }

        public DistressSignalConfirmation SubmitDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            return _distressSignalService.SubmitDistressSignal(submission, participantUserId);
        }

        private void EnsureMatchActionSessionBudget()
        {
            lock (_matchActionRequestGate)
            {
                MatchActionRequestBudget requestBudget = MatchActionRequestLimits.ConsumeWindow(
                    _matchActionSessionBudget, MaximumMatchActionMessagesPerSecond);
                if (requestBudget == null)
                {
                    throw new FaultException<MatchAccessFault>(new MatchAccessFault
                    {
                        FailureCode = nameof(MissionObjectiveDraftRejectionReason.RequestLimitReached)
                    });
                }
                _matchActionSessionBudget = requestBudget;
            }
        }

        private void EnsureMatchParticipantAllowed(string lobbyCode, int participantUserId)
        {
            try
            {
                EnsureParticipantOperationAllowed(participantUserId);
                EnsureRegisteredRoomChannel(lobbyCode, participantUserId);
            }
            catch (FaultException)
            {
                _logger.Warning(MatchAccessRejectedTemplate, participantUserId, lobbyCode);
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = FaultParticipantNotAllowed
                });
            }
        }
    }
}
