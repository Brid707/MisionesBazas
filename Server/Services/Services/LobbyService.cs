using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DTO;

namespace Services.Services
{
    /// <summary>
    /// WCF service implementation for managing multiplayer lobby rooms and dispatching real-time callbacks.
    /// </summary>
    [ServiceBehavior(ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public sealed class LobbyService : ILobbyService
    {
        private const string HostLeftReason = "The host has left and disbanded the lobby.";
        private const string PlayerLeftReason = "Player left the lobby.";
        private const string PlayerKickedReason = "Player was kicked by the host.";
        private const byte UnspecifiedSettingValue = 0;

        private static readonly ConcurrentDictionary<string, ConcurrentDictionary<int, ILobbyCallback>> s_roomCallbacks =
            new ConcurrentDictionary<string, ConcurrentDictionary<int, ILobbyCallback>>(
                StringComparer.OrdinalIgnoreCase);

        private readonly ILobbyUseCase _lobbyUseCase;

        public LobbyService(ILobbyUseCase lobbyUseCase)
        {
            if (lobbyUseCase == null)
            {
                throw new ArgumentNullException(nameof(lobbyUseCase));
            }

            _lobbyUseCase = lobbyUseCase;
        }

        public LobbyResult CreateLobby(int hostUserId, LobbySettings settings)
        {
            byte targetMissions = settings != null ? settings.TargetMissionCount : UnspecifiedSettingValue;
            byte playerLimit = settings != null ? settings.PlayerLimit : UnspecifiedSettingValue;

            LobbyActionOutcome outcome = _lobbyUseCase.CreateLobby(hostUserId, targetMissions, playerLimit);
            if (outcome.IsSuccess && outcome.Lobby != null)
            {
                RegisterCurrentCallback(outcome.Lobby.LobbyCode, hostUserId);
            }

            return MapToLobbyResult(outcome);
        }

        public LobbyResult JoinLobbyByCode(string lobbyCode, int userId)
        {
            LobbyActionOutcome outcome = _lobbyUseCase.JoinLobby(lobbyCode, userId);
            if (outcome.IsSuccess && outcome.Lobby != null && outcome.AffectedPlayer != null)
            {
                string canonicalCode = outcome.Lobby.LobbyCode;
                RegisterCurrentCallback(canonicalCode, userId);

                LobbyPlayer joinedPlayer = MapToPlayerDto(outcome.AffectedPlayer);
                BroadcastToRoom(
                    canonicalCode,
                    userId,
                    callback => callback.OnPlayerJoinedLobby(joinedPlayer));
            }

            return MapToLobbyResult(outcome);
        }

        public void LeaveLobby(string lobbyCode, int userId)
        {
            LobbyActionOutcome outcome = _lobbyUseCase.LeaveLobby(lobbyCode, userId);
            if (outcome.IsSuccess)
            {
                UnregisterCallback(lobbyCode, userId);
                NotifyPlayerDeparture(lobbyCode, userId, outcome.IsRoomDisbanded);
            }
        }

        public void KickPlayerByUserId(string lobbyCode, int hostUserId, int targetUserId)
        {
            LobbyActionOutcome outcome = _lobbyUseCase.KickPlayer(lobbyCode, hostUserId, targetUserId);
            if (outcome.IsSuccess)
            {
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnPlayerLeftLobby(targetUserId, PlayerKickedReason));
                UnregisterCallback(lobbyCode, targetUserId);
            }
        }

        public void SetPlayerReadyStatus(string lobbyCode, int userId, bool isReady)
        {
            LobbyActionOutcome outcome = _lobbyUseCase.UpdatePlayerReadiness(lobbyCode, userId, isReady);
            if (outcome.IsSuccess)
            {
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnPlayerReadyStatusChanged(userId, isReady));
            }
        }

        public void SendLobbyChatMessage(string lobbyCode, int senderUserId, string message)
        {
            if (!string.IsNullOrWhiteSpace(message))
            {
                string senderUsername = _lobbyUseCase.GetParticipantUsername(lobbyCode, senderUserId);
                if (!string.IsNullOrEmpty(senderUsername))
                {
                    LobbyMessage chatMessage = new LobbyMessage
                    {
                        SenderUserId = senderUserId,
                        SenderUsername = senderUsername,
                        Message = message.Trim(),
                        SentAt = DateTime.UtcNow
                    };

                    BroadcastToRoom(
                        lobbyCode,
                        excludedUserId: null,
                        callback => callback.OnReceiveLobbyChatMessage(chatMessage));
                }
            }
        }

        public void StartGameFromLobby(string lobbyCode, int hostUserId)
        {
            bool canStart = _lobbyUseCase.CanTransitionLobbyToGame(lobbyCode, hostUserId);
            if (canStart)
            {
                int generatedGameId = Math.Abs(NormalizeRoomKey(lobbyCode).GetHashCode());
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnGameStarting(generatedGameId));
            }
        }

        private static void NotifyPlayerDeparture(string lobbyCode, int userId, bool isRoomDisbanded)
        {
            if (isRoomDisbanded)
            {
                BroadcastToRoom(
                    lobbyCode,
                    excludedUserId: null,
                    callback => callback.OnLobbyDisbanded(HostLeftReason));
                s_roomCallbacks.TryRemove(NormalizeRoomKey(lobbyCode), out ConcurrentDictionary<int, ILobbyCallback> _);
            }
            else
            {
                BroadcastToRoom(
                    lobbyCode,
                    userId,
                    callback => callback.OnPlayerLeftLobby(userId, PlayerLeftReason));
            }
        }

        private static void RegisterCurrentCallback(string lobbyCode, int userId)
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

        private static void BroadcastToRoom(
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

        private static void TryInvokeCallback(
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
                    participants.TryRemove(entry.Key, out ILobbyCallback _);
                }
            }
            catch (TimeoutException)
            {
                // TODO: Log callback timeout failure once official logging infrastructure is available.
                participants.TryRemove(entry.Key, out ILobbyCallback _);
            }
            catch (CommunicationException)
            {
                // TODO: Log callback communication failure once official logging infrastructure is available.
                participants.TryRemove(entry.Key, out ILobbyCallback _);
            }
        }

        private static string NormalizeRoomKey(string lobbyCode)
        {
            return string.IsNullOrWhiteSpace(lobbyCode)
                ? string.Empty
                : lobbyCode.Trim().ToUpperInvariant();
        }

        private static LobbyResult MapToLobbyResult(LobbyActionOutcome outcome)
        {
            Lobby mappedLobby = null;
            if (outcome.Lobby != null)
            {
                mappedLobby = new Lobby
                {
                    LobbyCode = outcome.Lobby.LobbyCode,
                    HostUserId = outcome.Lobby.HostUserId,
                    TargetMissionCount = outcome.Lobby.TargetMissionCount,
                    PlayerLimit = outcome.Lobby.PlayerLimit,
                    Status = outcome.Lobby.Status,
                    Players = outcome.Lobby.Players.Select(MapToPlayerDto).ToList()
                };
            }

            return new LobbyResult
            {
                IsSuccess = outcome.IsSuccess,
                ErrorCode = outcome.ErrorCode,
                Message = outcome.Message,
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
