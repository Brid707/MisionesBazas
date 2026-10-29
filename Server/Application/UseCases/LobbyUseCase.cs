using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Application.Ports;
using Domain;

namespace Application
{
    /// <summary>
    /// Orchestrates in-memory authoritative lobby room operations, implementing the <see cref="ILobbyUseCase"/> port.
    /// </summary>
    public sealed class LobbyUseCase : ILobbyUseCase
    {
        private const int ErrorCodeSuccess = 0;
        private const int ErrorCodeValidationFailed = 101;
        private const int ErrorCodeUserNotFound = 102;
        private const int ErrorCodeLobbyNotFound = 103;
        private const int ErrorCodeLobbyFull = 104;
        private const int ErrorCodeLobbyInProgress = 105;
        private const int ErrorCodePersistenceFailure = 201;

        private const string MessageLobbyCreated = "Lobby created successfully.";
        private const string MessageJoinedLobby = "Joined lobby successfully.";
        private const string MessageRejoinedLobby = "Rejoined lobby successfully.";
        private const string MessagePlayerLeft = "Player left the lobby.";
        private const string MessagePlayerKicked = "Player was kicked from the lobby.";
        private const string MessageReadinessUpdated = "Readiness status updated.";

        private const string ErrorMessageDatabaseHostVerification = "Database error while verifying host user.";
        private const string ErrorMessageDatabasePlayerVerification = "Database error while verifying player.";
        private const string ErrorMessageHostNotFound = "Host user account does not exist.";
        private const string ErrorMessagePlayerNotFound = "Player account was not found.";
        private const string ErrorMessageInvalidLobbyCodeFormat = "Lobby code format is invalid.";
        private const string ErrorMessageLobbyNotFound = "Lobby room was not found.";
        private const string ErrorMessageUnableToKickPlayer = "Unable to kick player.";
        private const string ErrorMessageParticipantNotInLobby = "Participant not found in lobby.";
        private const string ErrorMessageLobbyMatchInProgress = "The match in this lobby has already started.";
        private const string ErrorMessageLobbyFull = "The lobby room is full.";

        private readonly IUserRepository _userRepository;
        private readonly ConcurrentDictionary<string, LobbyRoomData> _activeLobbies;

        public LobbyUseCase(IUserRepository userRepository)
        {
            if (userRepository == null)
            {
                throw new ArgumentNullException(nameof(userRepository));
            }

            _userRepository = userRepository;
            _activeLobbies = new ConcurrentDictionary<string, LobbyRoomData>(StringComparer.OrdinalIgnoreCase);
        }

        public LobbyActionOutcome CreateLobby(int hostUserId, byte targetMissionCount, byte playerLimit)
        {
            LobbyActionOutcome outcome;
            UserAccount hostAccount = TryFindUser(hostUserId, out bool hasDatabaseError);

            if (hasDatabaseError)
            {
                outcome = CreateErrorOutcome(ErrorCodePersistenceFailure, ErrorMessageDatabaseHostVerification);
            }
            else if (hostAccount == null)
            {
                outcome = CreateErrorOutcome(ErrorCodeUserNotFound, ErrorMessageHostNotFound);
            }
            else
            {
                outcome = InitializeNewLobby(hostAccount, targetMissionCount, playerLimit);
            }

            return outcome;
        }

        public LobbyActionOutcome JoinLobby(string lobbyCode, int userId)
        {
            LobbyActionOutcome outcome;
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);

            if (!LobbyCodeRules.IsCodeFormatValid(normalizedCode))
            {
                outcome = CreateErrorOutcome(ErrorCodeValidationFailed, ErrorMessageInvalidLobbyCodeFormat);
            }
            else if (!_activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                outcome = CreateErrorOutcome(ErrorCodeLobbyNotFound, ErrorMessageLobbyNotFound);
            }
            else
            {
                outcome = TryAddParticipantToLobby(lobby, userId);
            }

            return outcome;
        }

        public LobbyActionOutcome LeaveLobby(string lobbyCode, int userId)
        {
            LobbyActionOutcome outcome = CreateErrorOutcome(ErrorCodeLobbyNotFound, ErrorMessageLobbyNotFound);
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);

            if (_activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                outcome = RemoveParticipantFromRoom(lobby, userId);
                if (outcome.IsRoomDisbanded || (outcome.Lobby != null && outcome.Lobby.Players.Count == 0))
                {
                    _activeLobbies.TryRemove(normalizedCode, out LobbyRoomData _);
                }
            }

            return outcome;
        }

        public LobbyActionOutcome KickPlayer(string lobbyCode, int hostUserId, int targetUserId)
        {
            LobbyActionOutcome outcome = CreateErrorOutcome(ErrorCodeValidationFailed, ErrorMessageUnableToKickPlayer);
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);

            if (hostUserId != targetUserId && _activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                outcome = TryKickParticipantUnderLock(lobby, hostUserId, targetUserId);
            }

            return outcome;
        }

        public LobbyActionOutcome UpdatePlayerReadiness(string lobbyCode, int userId, bool isReady)
        {
            LobbyActionOutcome outcome = CreateErrorOutcome(
                ErrorCodeLobbyNotFound,
                ErrorMessageParticipantNotInLobby);
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);

            if (_activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                outcome = TryUpdateReadinessUnderLock(lobby, userId, isReady);
            }

            return outcome;
        }

        public string GetParticipantUsername(string lobbyCode, int userId)
        {
            string username = null;
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);

            if (_activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                lock (lobby)
                {
                    LobbyParticipantData participant = FindParticipantById(lobby, userId);
                    if (participant != null)
                    {
                        username = participant.Username;
                    }
                }
            }

            return username;
        }

        public bool CanTransitionLobbyToGame(string lobbyCode, int hostUserId)
        {
            bool canStart = false;
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);

            if (_activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                lock (lobby)
                {
                    bool isRequestedByHost = lobby.HostUserId == hostUserId;
                    bool isEveryPlayerReady = lobby.Players.All(player => player.IsReady || player.IsHost);

                    if (isRequestedByHost &&
                        LobbyRoomRules.CanLaunchMatch(lobby.Players.Count, isEveryPlayerReady, lobby.Status))
                    {
                        lobby.Status = LobbyRoomRules.StatusInGame;
                        canStart = true;
                    }
                }
            }

            return canStart;
        }

        private LobbyActionOutcome InitializeNewLobby(
            UserAccount hostAccount,
            byte targetMissionCount,
            byte playerLimit)
        {
            byte sanitizedMissions = LobbyRoomRules.ResolveTargetMissionCount(targetMissionCount);
            byte sanitizedLimit = LobbyRoomRules.ResolvePlayerLimit(playerLimit);
            string generatedCode = GenerateUniqueLobbyCode();

            LobbyParticipantData hostParticipant = new LobbyParticipantData
            {
                IdUser = hostAccount.IdUser,
                Username = hostAccount.Username,
                IsHost = true,
                IsReady = true
            };

            LobbyRoomData newLobby = new LobbyRoomData
            {
                LobbyCode = generatedCode,
                HostUserId = hostAccount.IdUser,
                TargetMissionCount = sanitizedMissions,
                PlayerLimit = sanitizedLimit,
                Status = LobbyRoomRules.StatusWaiting,
                Players = new List<LobbyParticipantData> { hostParticipant }
            };

            _activeLobbies[generatedCode] = newLobby;

            return new LobbyActionOutcome
            {
                IsSuccess = true,
                ErrorCode = ErrorCodeSuccess,
                Message = MessageLobbyCreated,
                Lobby = CreateRoomSnapshot(newLobby),
                AffectedPlayer = CloneParticipant(hostParticipant)
            };
        }

        private LobbyActionOutcome TryAddParticipantToLobby(LobbyRoomData lobby, int userId)
        {
            LobbyActionOutcome outcome;
            UserAccount userAccount = TryFindUser(userId, out bool hasDatabaseError);

            if (hasDatabaseError)
            {
                outcome = CreateErrorOutcome(ErrorCodePersistenceFailure, ErrorMessageDatabasePlayerVerification);
            }
            else if (userAccount == null)
            {
                outcome = CreateErrorOutcome(ErrorCodeUserNotFound, ErrorMessagePlayerNotFound);
            }
            else
            {
                lock (lobby)
                {
                    outcome = AddOrRefreshParticipantUnderLock(lobby, userAccount);
                }
            }

            return outcome;
        }

        private static LobbyActionOutcome AddOrRefreshParticipantUnderLock(
            LobbyRoomData lobby,
            UserAccount userAccount)
        {
            LobbyActionOutcome outcome;
            LobbyParticipantData existing = FindParticipantById(lobby, userAccount.IdUser);

            if (existing != null)
            {
                outcome = new LobbyActionOutcome
                {
                    IsSuccess = true,
                    ErrorCode = ErrorCodeSuccess,
                    Message = MessageRejoinedLobby,
                    Lobby = CreateRoomSnapshot(lobby),
                    AffectedPlayer = CloneParticipant(existing)
                };
            }
            else if (!LobbyRoomRules.IsRoomWaitingForPlayers(lobby.Status))
            {
                outcome = CreateErrorOutcome(ErrorCodeLobbyInProgress, ErrorMessageLobbyMatchInProgress);
            }
            else if (!LobbyRoomRules.HasAvailableSlot(lobby.Players.Count, lobby.PlayerLimit))
            {
                outcome = CreateErrorOutcome(ErrorCodeLobbyFull, ErrorMessageLobbyFull);
            }
            else
            {
                LobbyParticipantData newParticipant = new LobbyParticipantData
                {
                    IdUser = userAccount.IdUser,
                    Username = userAccount.Username,
                    IsHost = false,
                    IsReady = false
                };

                lobby.Players.Add(newParticipant);

                outcome = new LobbyActionOutcome
                {
                    IsSuccess = true,
                    ErrorCode = ErrorCodeSuccess,
                    Message = MessageJoinedLobby,
                    Lobby = CreateRoomSnapshot(lobby),
                    AffectedPlayer = CloneParticipant(newParticipant)
                };
            }

            return outcome;
        }

        private static LobbyActionOutcome RemoveParticipantFromRoom(LobbyRoomData lobby, int userId)
        {
            LobbyActionOutcome outcome = CreateErrorOutcome(
                ErrorCodeUserNotFound,
                ErrorMessageParticipantNotInLobby);

            lock (lobby)
            {
                LobbyParticipantData existing = FindParticipantById(lobby, userId);
                if (existing != null)
                {
                    lobby.Players.Remove(existing);
                    bool isDisbanded = existing.IsHost;
                    if (isDisbanded)
                    {
                        lobby.Players.Clear();
                    }

                    outcome = new LobbyActionOutcome
                    {
                        IsSuccess = true,
                        ErrorCode = ErrorCodeSuccess,
                        Message = MessagePlayerLeft,
                        IsRoomDisbanded = isDisbanded,
                        Lobby = CreateRoomSnapshot(lobby),
                        AffectedPlayer = CloneParticipant(existing)
                    };
                }
            }

            return outcome;
        }

        private static LobbyActionOutcome TryKickParticipantUnderLock(
            LobbyRoomData lobby,
            int hostUserId,
            int targetUserId)
        {
            LobbyActionOutcome outcome = CreateErrorOutcome(
                ErrorCodeValidationFailed,
                ErrorMessageUnableToKickPlayer);

            lock (lobby)
            {
                LobbyParticipantData target = FindParticipantById(lobby, targetUserId);
                if (lobby.HostUserId == hostUserId && target != null)
                {
                    lobby.Players.Remove(target);
                    outcome = new LobbyActionOutcome
                    {
                        IsSuccess = true,
                        ErrorCode = ErrorCodeSuccess,
                        Message = MessagePlayerKicked,
                        Lobby = CreateRoomSnapshot(lobby),
                        AffectedPlayer = CloneParticipant(target)
                    };
                }
            }

            return outcome;
        }

        private static LobbyActionOutcome TryUpdateReadinessUnderLock(
            LobbyRoomData lobby,
            int userId,
            bool isReady)
        {
            LobbyActionOutcome outcome = CreateErrorOutcome(
                ErrorCodeUserNotFound,
                ErrorMessageParticipantNotInLobby);

            lock (lobby)
            {
                LobbyParticipantData participant = FindParticipantById(lobby, userId);
                if (participant != null)
                {
                    participant.IsReady = isReady;
                    outcome = new LobbyActionOutcome
                    {
                        IsSuccess = true,
                        ErrorCode = ErrorCodeSuccess,
                        Message = MessageReadinessUpdated,
                        Lobby = CreateRoomSnapshot(lobby),
                        AffectedPlayer = CloneParticipant(participant)
                    };
                }
            }

            return outcome;
        }

        private static LobbyParticipantData FindParticipantById(LobbyRoomData lobby, int userId)
        {
            return lobby.Players.FirstOrDefault(player => player.IdUser == userId);
        }

        private UserAccount TryFindUser(int userId, out bool hasDatabaseError)
        {
            UserAccount account = null;
            hasDatabaseError = false;

            if (userId > 0)
            {
                try
                {
                    account = _userRepository.GetUserById(userId);
                }
                catch (InvalidOperationException)
                {
                    // TODO: Log database failure once official logging infrastructure is available.
                    hasDatabaseError = true;
                }
            }
            else if (GuestIdentityRules.IsGuestUserId(userId))
            {
                account = new UserAccount
                {
                    IdUser = userId,
                    Username = GuestIdentityRules.BuildGuestUsername(userId),
                    Email = string.Empty
                };
            }

            return account;
        }

        private string GenerateUniqueLobbyCode()
        {
            string candidateCode;
            do
            {
                candidateCode = LobbyCodeRules.GenerateCode();
            }
            while (_activeLobbies.ContainsKey(candidateCode));

            return candidateCode;
        }

        private static LobbyRoomData CreateRoomSnapshot(LobbyRoomData source)
        {
            List<LobbyParticipantData> clonedPlayers = source.Players
                .Select(CloneParticipant)
                .ToList();

            return new LobbyRoomData
            {
                LobbyCode = source.LobbyCode,
                HostUserId = source.HostUserId,
                TargetMissionCount = source.TargetMissionCount,
                PlayerLimit = source.PlayerLimit,
                Status = source.Status,
                Players = clonedPlayers
            };
        }

        private static LobbyParticipantData CloneParticipant(LobbyParticipantData source)
        {
            return new LobbyParticipantData
            {
                IdUser = source.IdUser,
                Username = source.Username,
                IsHost = source.IsHost,
                IsReady = source.IsReady
            };
        }

        private static LobbyActionOutcome CreateErrorOutcome(int errorCode, string message)
        {
            return new LobbyActionOutcome
            {
                IsSuccess = false,
                ErrorCode = errorCode,
                Message = message,
                IsRoomDisbanded = false,
                Lobby = null,
                AffectedPlayer = null
            };
        }
    }
}
