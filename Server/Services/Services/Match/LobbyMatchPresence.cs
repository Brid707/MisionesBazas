using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Services.Services
{
    /// <summary>Adapts registered callbacks to bounded leases and automatic response probes.</summary>
    public sealed class LobbyMatchPresence : IMatchParticipantPresence
    {
        private const string PresenceProbeFailedTemplate =
            "Match presence probe failed. ExceptionType={ExceptionType}.";
        private static readonly ConditionalWeakTable<ILobbyCallback, LobbyCallbackPresenceLease> s_leases =
            new ConditionalWeakTable<ILobbyCallback, LobbyCallbackPresenceLease>();
        private static readonly Dictionary<string, long> s_roomVersions =
            new Dictionary<string, long>(StringComparer.OrdinalIgnoreCase);
        private static long s_connectionVersion;
        private readonly ILoggerService _logger;

        internal static object RegistryGate { get; } = new object();

        public LobbyMatchPresence(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        internal static void MarkConnectionsChanged(string lobbyCode)
        {
            lock (RegistryGate)
            {
                s_connectionVersion++;
                s_roomVersions[lobbyCode] = s_connectionVersion;
            }
        }

        internal static void ForgetRoom(string lobbyCode)
        {
            lock (RegistryGate)
            {
                s_roomVersions.Remove(lobbyCode);
            }
        }

        internal static void Touch(string lobbyCode, int participantUserId, string sessionId)
        {
            lock (RegistryGate)
            {
                ILobbyCallback callback = LobbyService.GetMatchCallbacks(lobbyCode)
                    .FirstOrDefault(entry => entry.Key == participantUserId).Value;
                if (callback is IContextChannel channel && channel.SessionId == sessionId)
                {
                    TouchCallback(lobbyCode, callback);
                }
            }
        }

        private static LobbyCallbackPresenceLease GetLease(ILobbyCallback callback)
        {
            return s_leases.GetValue(callback, _ => CreatePresenceLease());
        }

        private static LobbyCallbackPresenceLease CreatePresenceLease()
        {
            return new LobbyCallbackPresenceLease { LastSeenTimestamp = Stopwatch.GetTimestamp() };
        }

        private static void TouchCallback(string lobbyCode, ILobbyCallback callback)
        {
            LobbyCallbackPresenceLease lease = GetLease(callback);
            long timestamp = Stopwatch.GetTimestamp();
            if (lease.IsUnavailable || HasLeaseExpired(lease, timestamp))
            {
                MarkConnectionsChanged(lobbyCode);
            }
            lease.LastSeenTimestamp = timestamp;
            lease.IsUnavailable = false;
        }

        public MatchParticipantPresence ReadPresence(MatchPresenceQuery query)
        {
            MatchParticipantPresence presence;
            lock (RegistryGate)
            {
                Dictionary<int, ILobbyCallback> callbacks = LobbyService.GetMatchCallbacks(query.LobbyCode)
                    .ToDictionary(entry => entry.Key, entry => entry.Value);
                int[] missingParticipants = query.ParticipantUserIds.Where(participantUserId =>
                    !HasLiveCallback(query.LobbyCode, callbacks, participantUserId)).ToArray();
                s_roomVersions.TryGetValue(query.LobbyCode, out long connectionVersion);
                presence = new MatchParticipantPresence
                {
                    ConnectionVersion = connectionVersion,
                    MissingParticipantUserIds = missingParticipants
                };
            }
            return presence;
        }

        private static bool HasLiveCallback(string lobbyCode, IDictionary<int, ILobbyCallback> callbacks,
            int participantUserId)
        {
            bool isLive = false;
            if (callbacks.TryGetValue(participantUserId, out ILobbyCallback callback) &&
                callback is IContextChannel channel && channel.State == CommunicationState.Opened)
            {
                LobbyCallbackPresenceLease lease = GetLease(callback);
                if (HasLeaseExpired(lease, Stopwatch.GetTimestamp()) && !lease.IsUnavailable)
                {
                    lease.IsUnavailable = true;
                    MarkConnectionsChanged(lobbyCode);
                }
                isLive = !lease.IsUnavailable;
            }
            return isLive;
        }

        private static bool HasLeaseExpired(LobbyCallbackPresenceLease lease, long timestamp)
        {
            return timestamp - lease.LastSeenTimestamp >=
                Stopwatch.Frequency * MissionRetryPolicy.PresenceLeaseSeconds;
        }

        public bool ConfirmPresence(MatchPresenceQuery query)
        {
            KeyValuePair<int, ILobbyCallback>[] callbacks;
            lock (RegistryGate)
            {
                callbacks = LobbyService.GetMatchCallbacks(query.LobbyCode)
                    .Where(entry => query.ParticipantUserIds.Contains(entry.Key)).ToArray();
            }
            bool hasAllResponses = callbacks.Length == query.ParticipantUserIds.Length;
            foreach (KeyValuePair<int, ILobbyCallback> entry in callbacks)
            {
                bool hasResponse = ConfirmCallback(query, entry);
                hasAllResponses = hasAllResponses && hasResponse;
            }
            MatchParticipantPresence currentPresence = ReadPresence(query);
            return hasAllResponses && currentPresence.MissingParticipantUserIds.Length == 0 &&
                currentPresence.ConnectionVersion == query.ExpectedConnectionVersion;
        }

        private bool ConfirmCallback(MatchPresenceQuery query, KeyValuePair<int, ILobbyCallback> entry)
        {
            bool hasResponse = false;
            IContextChannel channel = entry.Value as IContextChannel;
            if (channel != null && channel.State == CommunicationState.Opened)
            {
                TimeSpan originalTimeout = channel.OperationTimeout;
                try
                {
                    channel.OperationTimeout = TimeSpan.FromMilliseconds(
                        MissionRetryPolicy.PresenceProbeTimeoutMilliseconds);
                    hasResponse = entry.Value.IsMatchParticipantConnected(query.MatchId, query.MissionAttemptId);
                }
                catch (TimeoutException ex)
                {
                    _logger.Warning(PresenceProbeFailedTemplate, ex.GetType().Name);
                }
                catch (CommunicationException ex)
                {
                    _logger.Warning(PresenceProbeFailedTemplate, ex.GetType().Name);
                }
                finally
                {
                    RestoreCallbackTimeout(channel, originalTimeout);
                }
            }
            UpdateProbeLease(query.LobbyCode, entry, hasResponse);
            return hasResponse;
        }

        private void RestoreCallbackTimeout(IContextChannel channel, TimeSpan originalTimeout)
        {
            try
            {
                if (channel.State == CommunicationState.Opened)
                {
                    channel.OperationTimeout = originalTimeout;
                }
            }
            catch (InvalidOperationException ex)
            {
                _logger.Warning(PresenceProbeFailedTemplate, ex.GetType().Name);
            }
            catch (CommunicationException ex)
            {
                _logger.Warning(PresenceProbeFailedTemplate, ex.GetType().Name);
            }
        }

        private static void UpdateProbeLease(string lobbyCode, KeyValuePair<int, ILobbyCallback> entry,
            bool hasResponse)
        {
            lock (RegistryGate)
            {
                ILobbyCallback currentCallback = LobbyService.GetMatchCallbacks(lobbyCode)
                    .FirstOrDefault(candidate => candidate.Key == entry.Key).Value;
                if (ReferenceEquals(currentCallback, entry.Value))
                {
                    if (hasResponse)
                    {
                        TouchCallback(lobbyCode, currentCallback);
                    }
                    else
                    {
                        GetLease(currentCallback).IsUnavailable = true;
                        MarkConnectionsChanged(lobbyCode);
                    }
                }
            }
        }
    }
}
