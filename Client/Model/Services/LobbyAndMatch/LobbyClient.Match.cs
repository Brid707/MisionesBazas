using System;
using System.ServiceModel;
using System.Threading;
using System.Threading.Tasks;
using Gameplay;
using Model.GameServices;
using Model.Session;

namespace Model.Services
{
    public sealed partial class LobbyClient
    {
        private const string MatchCommunicationFaultTemplate =
            "WCF communication fault during match operation for lobby {LobbyCode}.";
        private const string MatchTimeoutTemplate =
            "WCF match operation timed out for lobby {LobbyCode}; aborting channel.";

        private readonly SemaphoreSlim _matchRequestGate = new SemaphoreSlim(1, 1);
        private string _registeredMatchLobbyCode;
        private readonly object _matchPresenceGate = new object();
        private Guid _observedMatchId;
        private int _observedMissionAttemptId;

        public Task<MissionPreparationConfirmation> IdentifyHeartNineOwnerAsync(
            HeartNineIdentificationSubmission submission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.IdentifyHeartNineOwner(submission, participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public Task<MissionPreparationConfirmation> AssignMissionTrickDistributionAsync(
            MissionTrickDistributionSubmission submission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.AssignMissionTrickDistribution(submission,
                participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public Task<MissionPreparationConfirmation> AssignMissionRoleAsync(MissionRoleAssignmentSubmission submission,
            int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.AssignMissionRole(submission, participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public Task<MissionPreparationConfirmation> RespondToBlindObjectivesAsync(BlindObjectiveResponseSubmission
            submission,
            int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.RespondToBlindObjectives(submission,
                participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public event Action<long> MatchStateChanged;

        public async Task<PlayerMatchSnapshot> GetPlayerMatchAsync(string lobbyCode, int participantUserId)
        {
            PlayerMatchSnapshot snapshot = await ExecuteMatchOperationAsync(
                channel => channel.GetPlayerMatch(lobbyCode, participantUserId), lobbyCode, participantUserId);
            lock (_matchPresenceGate)
            {
                _observedMatchId = snapshot.MatchId;
                _observedMissionAttemptId = snapshot.MissionPreparation.MissionAttemptId;
            }
            return snapshot;
        }

        public bool IsMatchParticipantConnected(Guid matchId, int missionAttemptId)
        {
            bool isConnected;
            lock (_matchPresenceGate)
            {
                isConnected = !_isLobbyClientDisposed && _client?.State == CommunicationState.Opened &&
                    _observedMatchId == matchId && _observedMissionAttemptId == missionAttemptId;
            }
            return isConnected;
        }

        public Task<RadioCommunicationConfirmation> SubmitRadioCommunicationAsync(
            RadioCommunicationSubmission submission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.SubmitRadioCommunication(submission,
                participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public Task<CardPlayDecision> PlayCardAsync(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.PlayCard(cardPlaySubmission, participantUserId),
                cardPlaySubmission.LobbyCode, participantUserId);
        }

        public Task<MissionObjectiveDraftDecision> ProcessObjectiveDraftActionAsync(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.ProcessObjectiveDraftAction(submission,
                participantUserId), submission.LobbyCode, participantUserId);
        }

        public Task<MissionRetryDecision> ConfirmMissionRetryAsync(MissionRetrySubmission submission,
            int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.ConfirmMissionRetry(submission, participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public Task<DistressSignalConfirmation> SubmitDistressSignalAsync(
            DistressSignalSubmission submission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(
                channel => channel.SubmitDistressSignal(submission, participantUserId),
                submission.LobbyCode, participantUserId);
        }

        public void OnMatchStateChanged(long matchStateVersion)
        {
            MatchStateChanged?.Invoke(matchStateVersion);
        }

        private async Task<T> ExecuteMatchOperationAsync<T>(Func<LobbyServiceClient, T> matchOperation,
            string lobbyCode, int participantUserId)
        {
            T matchOperationResult;
            await _matchRequestGate.WaitAsync();
            try
            {
                matchOperationResult = await Task.Run(() => InvokeMatchOperation(
                    matchOperation, lobbyCode, participantUserId));
            }
            catch (FaultException)
            {
                throw;
            }
            catch (CommunicationException ex)
            {
                _logger.Error(ex, MatchCommunicationFaultTemplate, lobbyCode);
                _registeredMatchLobbyCode = null;
                throw;
            }
            catch (TimeoutException ex)
            {
                _logger.Error(ex, MatchTimeoutTemplate, lobbyCode);
                _registeredMatchLobbyCode = null;
                _client?.Abort();
                throw;
            }
            finally
            {
                _matchRequestGate.Release();
            }
            return matchOperationResult;
        }

        private T InvokeMatchOperation<T>(Func<LobbyServiceClient, T> matchOperation,
            string lobbyCode, int participantUserId)
        {
            EnsureMatchParticipantChannel(lobbyCode, participantUserId);
            return matchOperation(_client);
        }

        private void EnsureMatchParticipantChannel(string lobbyCode, int participantUserId)
        {
            bool isChannelReplaced = _client == null || _client.State == CommunicationState.Faulted ||
                _client.State == CommunicationState.Closed;
            EnsureClientIsOpen();
            if (isChannelReplaced || _registeredMatchLobbyCode != lobbyCode)
            {
                LobbyResult entryDecision = _client.JoinLobbyByCode(lobbyCode, participantUserId);
                PreserveGuestCredential(entryDecision);
                if (!entryDecision.IsSuccess)
                {
                    throw new FaultException("MatchUnavailable");
                }
                _registeredMatchLobbyCode = lobbyCode;
            }
        }

        private static void PreserveGuestCredential(LobbyResult entryDecision)
        {
            if (entryDecision != null && !string.IsNullOrEmpty(entryDecision.GuestSessionToken) &&
                UserSession.Current.CurrentUser != null)
            {
                UserSession.Current.CurrentUser.GuestSessionToken = entryDecision.GuestSessionToken;
            }
        }
    }
}
