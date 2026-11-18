using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;

using Application.Models;
using Application.Ports;
using Domain;
using TrickTakingMissions.Logging.Abstractions;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Application
{
    /// <summary>
    /// Orchestrates in-memory authoritative lobby room operations, implementing the <see cref="ILobbyUseCase"/> port.
    /// </summary>
    public sealed class LobbyUseCase : ILobbyUseCase
    {
        private const int ErrorCodeSuccess = 0;
        private const int ErrorCodeHostRequired = 106;
        private const int ErrorCodeKickedParticipantReentryDenied = 107;
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

        private const string MatchNotConfiguredMessage = "MatchNotConfigured";
        private const string MessageHostRequired = "LobbyHostRequired";
        private const string MessageConfigurationInvalid = "LobbyConfigurationInvalid";
        private const string MessageReentryTargetInvalid = "LobbyReentryTargetInvalid";
        private const string MessageReentryAuthorized = "LobbyKickedPlayerReentryAuthorized";
        private const string MessageKickedParticipantReentryDenied = "LobbyKickedParticipantReentryDenied";
        private const string MessageMatchInProgress = "LobbyMatchInProgress";

        private const string LobbyCreatedSuccessfullyTemplate =
            "Lobby {LobbyCode} created by host user {HostUserId}.";
        private const string LobbyTransitionedToGameTemplate =
            "Lobby {LobbyCode} transitioned to match with {PlayerCount} players.";
        private const string LobbyDisbandedTemplate =
            "Lobby {LobbyCode} closed and disbanded.";
        private const string CreateLobbyHostNotFoundTemplate =
            "Host user {HostUserId} not found when creating lobby.";
        private const string CreateLobbyPersistenceFailureTemplate =
            "Aborted lobby creation for host user {HostUserId} due to database failure.";
        private const string JoinLobbyPersistenceFailureTemplate =
            "Aborted join to lobby {LobbyCode} for user {UserId} due to database failure.";
        private const string ParticipantKickedFromLobbyTemplate =
            "Player {TargetUserId} was kicked from lobby {LobbyCode} by host {HostUserId}.";

        private readonly IUserRepository _userRepository;
        private readonly ILobbyHostSelection _lobbyHostSelection;
        private readonly ILoggerService _logger;
        private readonly ConcurrentDictionary<string, LobbyRoomData> _activeLobbies;

        public LobbyUseCase(IUserRepository userRepository, ILobbyHostSelection lobbyHostSelection,
            IMatchUseCase matchUseCase = null, ILoggerService logger = null)
        {
            if (userRepository == null)
            {
                throw new ArgumentNullException(nameof(userRepository));
            }

            Match = matchUseCase;
            _userRepository = userRepository;
            _lobbyHostSelection = lobbyHostSelection;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _activeLobbies = new ConcurrentDictionary<string, LobbyRoomData>(StringComparer.OrdinalIgnoreCase);
        }

        public IMatchUseCase Match { get; }

        public LobbyActionOutcome CreateLobby(int hostUserId, LobbyConfiguration lobbyConfiguration)
        {
            LobbyActionOutcome outcome;
            UserAccount hostAccount = TryFindUser(hostUserId, out bool hasDatabaseError);

            if (hasDatabaseError)
            {
                _logger.Warning(CreateLobbyPersistenceFailureTemplate, hostUserId);
                outcome = CreateErrorOutcome(ErrorCodePersistenceFailure, ErrorMessageDatabaseHostVerification);
            }
            else if (hostAccount == null)
            {
                _logger.Warning(CreateLobbyHostNotFoundTemplate, hostUserId);
                outcome = CreateErrorOutcome(ErrorCodeUserNotFound, ErrorMessageHostNotFound);
            }
            else
            {
                outcome = InitializeNewLobby(hostAccount, lobbyConfiguration);
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
                    _logger.Information(LobbyDisbandedTemplate, normalizedCode);
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

        /// <inheritdoc />
        public LobbyActionOutcome AuthorizeKickedPlayerReentry(string lobbyCode, int hostUserId, int targetUserId)
        {
            LobbyActionOutcome reentryAuthorization = CreateErrorOutcome(ErrorCodeLobbyNotFound,
                ErrorMessageLobbyNotFound);
            string normalizedCode = LobbyCodeRules.NormalizeCode(lobbyCode);
            if (_activeLobbies.TryGetValue(normalizedCode, out LobbyRoomData lobby))
            {
                reentryAuthorization = AuthorizeReentryUnderLock(lobby, hostUserId, targetUserId);
            }

            return reentryAuthorization;
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
                    if (isRequestedByHost && lobby.Status == LobbyRoomRules.StatusInGame)
                    {
                        canStart = true;
                    }
                    bool isEveryPlayerReady = lobby.Players.All(player => player.IsReady || player.IsHost);

                    if (isRequestedByHost &&
                        LobbyRoomRules.CanLaunchMatch(lobby.Players.Count, isEveryPlayerReady, lobby.Status))
                    {
                        if (Match == null)
                        {
                            throw new InvalidOperationException(MatchNotConfiguredMessage);
                        }
                        Match.StartMatch(new MatchStartContext
                        {
                            LobbyCode = lobby.LobbyCode,
                            LobbyInstanceId = lobby.LobbyInstanceId,
                            ParticipantUserIds = lobby.Players.Select(player => player.IdUser).ToArray(),
                            TargetMissionCount = lobby.TargetMissionCount
                        });
                        lobby.Status = LobbyRoomRules.StatusInGame;
                        lobby.StateVersion++;
                        _logger.Information(LobbyTransitionedToGameTemplate, lobby.LobbyCode, lobby.Players.Count);
                        canStart = true;
                    }
                }
            }

            return canStart;
        }

        public LobbyActionOutcome UpdateLobbySettings(string lobbyCode, int requesterUserId,
            LobbyConfiguration lobbyConfiguration)
        {
            LobbyActionOutcome configurationUpdate = CreateErrorOutcome(
                ErrorCodeLobbyNotFound, ErrorMessageLobbyNotFound);
            if (_activeLobbies.TryGetValue(LobbyCodeRules.NormalizeCode(lobbyCode), out LobbyRoomData lobby))
            {
                lock (lobby)
                {
                    configurationUpdate = ApplyLobbyConfiguration(lobby, requesterUserId, lobbyConfiguration);
                }
            }

            return configurationUpdate;
        }

        public LobbyActionOutcome DisconnectLobbyParticipant(string lobbyCode, int participantUserId)
        {
            LobbyActionOutcome participantDeparture = CreateErrorOutcome(
                ErrorCodeLobbyInProgress, ErrorMessageLobbyMatchInProgress);
            if (_activeLobbies.TryGetValue(LobbyCodeRules.NormalizeCode(lobbyCode), out LobbyRoomData lobby))
            {
                participantDeparture = RemoveDisconnectedWaitingParticipant(lobby, participantUserId);
            }

            return participantDeparture;
        }

        private LobbyActionOutcome RemoveDisconnectedWaitingParticipant(LobbyRoomData lobby, int participantUserId)
        {
            LobbyActionOutcome participantDeparture = CreateErrorOutcome(
                ErrorCodeLobbyInProgress, ErrorMessageLobbyMatchInProgress);
            lock (lobby)
            {
                if (LobbyRoomRules.IsRoomWaitingForPlayers(lobby.Status))
                {
                    participantDeparture = LeaveLobby(lobby.LobbyCode, participantUserId);
                }
            }

            return participantDeparture;
        }

        private static LobbyActionOutcome ApplyLobbyConfiguration(LobbyRoomData lobby, int requesterUserId,
            LobbyConfiguration lobbyConfiguration)
        {
            LobbyActionOutcome configurationUpdate = ValidateLobbyConfiguration(lobby, requesterUserId,
                lobbyConfiguration);
            if (configurationUpdate.IsSuccess)
            {
                ApplyChangedLobbyRules(lobby, lobbyConfiguration);
                configurationUpdate.Lobby = CreateRoomSnapshot(lobby);
            }

            return configurationUpdate;
        }

        private static LobbyActionOutcome ValidateLobbyConfiguration(LobbyRoomData lobby, int requesterUserId,
            LobbyConfiguration lobbyConfiguration)
        {
            LobbyActionOutcome configurationValidation = new LobbyActionOutcome { IsSuccess = true };
            if (lobby.HostUserId != requesterUserId)
            {
                configurationValidation = CreateErrorOutcome(ErrorCodeHostRequired, MessageHostRequired);
            }
            else if (!LobbyRoomRules.IsRoomWaitingForPlayers(lobby.Status))
            {
                configurationValidation = CreateErrorOutcome(ErrorCodeLobbyInProgress, MessageMatchInProgress);
            }
            else if (lobbyConfiguration == null || !LobbyRoomRules.IsConfigurationValid(
                lobbyConfiguration.TargetMissionCount, lobbyConfiguration.PlayerLimit, lobby.Players.Count))
            {
                configurationValidation = CreateErrorOutcome(ErrorCodeValidationFailed, MessageConfigurationInvalid);
            }

            return configurationValidation;
        }

        private static void ApplyChangedLobbyRules(LobbyRoomData lobby, LobbyConfiguration lobbyConfiguration)
        {
            bool hasConfigurationChanged = lobby.TargetMissionCount != lobbyConfiguration.TargetMissionCount ||
                lobby.PlayerLimit != lobbyConfiguration.PlayerLimit || lobby.IsPrivate != lobbyConfiguration.IsPrivate;
            if (hasConfigurationChanged)
            {
                lobby.TargetMissionCount = lobbyConfiguration.TargetMissionCount;
                lobby.PlayerLimit = lobbyConfiguration.PlayerLimit;
                lobby.IsPrivate = lobbyConfiguration.IsPrivate;
                lobby.Players.ForEach(ResetParticipantReadiness);
                lobby.StateVersion++;
            }
        }

        private static void ResetParticipantReadiness(LobbyParticipantData participant)
        {
            participant.IsReady = false;
        }

        private void TransferLobbyHost(LobbyRoomData lobby)
        {
            int selectedHostUserId = _lobbyHostSelection.SelectHostUserId(
                lobby.Players.Select(participant => participant.IdUser).ToList());
            lobby.HostUserId = selectedHostUserId;
            foreach (LobbyParticipantData participant in lobby.Players)
            {
                participant.IsHost = participant.IdUser == selectedHostUserId;
            }
        }

        private LobbyActionOutcome InitializeNewLobby(
            UserAccount hostAccount,
            LobbyConfiguration lobbyConfiguration)
        {
            byte sanitizedMissions = LobbyRoomRules.ResolveTargetMissionCount(lobbyConfiguration.TargetMissionCount);
            byte sanitizedLimit = LobbyRoomRules.ResolvePlayerLimit(lobbyConfiguration.PlayerLimit);
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
                IsPrivate = lobbyConfiguration.IsPrivate,
                StateVersion = 1,
                Players = new List<LobbyParticipantData> { hostParticipant }
            };

            _activeLobbies[generatedCode] = newLobby;
            _logger.Information(LobbyCreatedSuccessfullyTemplate, generatedCode, hostAccount.IdUser);

            return new LobbyActionOutcome
            {
                IsSuccess = true,
                ErrorCode = ErrorCodeSuccess,
                Message = MessageLobbyCreated,
                Lobby = CreateRoomSnapshot(newLobby),
                AffectedPlayer = CloneParticipant(hostParticipant)
            };
        }

        private static LobbyActionOutcome AuthorizeReentryUnderLock(
            LobbyRoomData lobby, int hostUserId, int targetUserId)
        {
            LobbyActionOutcome reentryAuthorization;
            lock (lobby)
            {
                reentryAuthorization = ValidateReentryAuthorization(lobby, hostUserId, targetUserId);
                if (reentryAuthorization.IsSuccess)
                {
                    lobby.KickedParticipantUserIds.Remove(targetUserId);
                    reentryAuthorization.Lobby = CreateRoomSnapshot(lobby);
                }
            }

            return reentryAuthorization;
        }

        private static LobbyActionOutcome ValidateReentryAuthorization(
            LobbyRoomData lobby, int hostUserId, int targetUserId)
        {
            LobbyActionOutcome reentryAuthorization;
            if (lobby.HostUserId != hostUserId)
            {
                reentryAuthorization = CreateErrorOutcome(ErrorCodeHostRequired, MessageHostRequired);
            }
            else if (!LobbyRoomRules.IsRoomWaitingForPlayers(lobby.Status))
            {
                reentryAuthorization = CreateErrorOutcome(ErrorCodeLobbyInProgress, MessageMatchInProgress);
            }
            else if (targetUserId == hostUserId || targetUserId == 0)
            {
                reentryAuthorization = CreateErrorOutcome(ErrorCodeValidationFailed, MessageReentryTargetInvalid);
            }
            else
            {
                reentryAuthorization = new LobbyActionOutcome
                {
                    IsSuccess = true,
                    ErrorCode = ErrorCodeSuccess,
                    Message = MessageReentryAuthorized
                };
            }

            return reentryAuthorization;
        }

        private LobbyActionOutcome TryAddParticipantToLobby(LobbyRoomData lobby, int userId)
        {
            LobbyActionOutcome outcome;
            UserAccount userAccount = TryFindUser(userId, out bool hasDatabaseError);

            if (hasDatabaseError)
            {
                _logger.Warning(JoinLobbyPersistenceFailureTemplate, lobby.LobbyCode, userId);
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
            LobbyRoomData lobby, UserAccount userAccount)
        {
            LobbyActionOutcome lobbyEntryDecision;
            if (lobby.KickedParticipantUserIds.Contains(userAccount.IdUser))
            {
                lobbyEntryDecision = CreateErrorOutcome(ErrorCodeKickedParticipantReentryDenied,
                    MessageKickedParticipantReentryDenied);
            }
            else
            {
                lobbyEntryDecision = AddUnrestrictedParticipantUnderLock(lobby, userAccount);
            }

            return lobbyEntryDecision;
        }

        private static LobbyActionOutcome AddUnrestrictedParticipantUnderLock(
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
                lobby.StateVersion++;

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

        private LobbyActionOutcome RemoveParticipantFromRoom(LobbyRoomData lobby, int userId)
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
                    bool isDisbanded = lobby.Players.Count == 0;
                    if (isDisbanded)
                    {
                        lobby.Status = LobbyRoomRules.StatusClosed;
                    }
                    if (existing.IsHost && !isDisbanded)
                    {
                        TransferLobbyHost(lobby);
                    }

                    lobby.StateVersion++;

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

        private LobbyActionOutcome TryKickParticipantUnderLock(
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
                if (lobby.HostUserId == hostUserId && target != null && lobby.Status == LobbyRoomRules.StatusWaiting)
                {
                    lobby.KickedParticipantUserIds.Add(targetUserId);
                    lobby.Players.Remove(target);
                    lobby.StateVersion++;
                    _logger.Warning(ParticipantKickedFromLobbyTemplate, targetUserId, lobby.LobbyCode, hostUserId);
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
            LobbyRoomData lobby, int userId, bool isReady)
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
                    lobby.StateVersion++;
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
                IsPrivate = source.IsPrivate,
                StateVersion = source.StateVersion,
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
