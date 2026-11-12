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
        private readonly SemaphoreSlim _matchRequestGate = new SemaphoreSlim(1, 1);
        private string _registeredMatchLobbyCode;

        public event Action<long> MatchStateChanged;

        public Task<PlayerMatchSnapshot> GetPlayerMatchAsync(string lobbyCode, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.GetPlayerMatch(lobbyCode, participantUserId),
                lobbyCode, participantUserId);
        }

        public Task<CardPlayDecision> PlayCardAsync(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            return ExecuteMatchOperationAsync(channel => channel.PlayCard(cardPlaySubmission, participantUserId),
                cardPlaySubmission.LobbyCode, participantUserId);
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
            catch (CommunicationException)
            {
                _registeredMatchLobbyCode = null;
                throw;
            }
            catch (TimeoutException)
            {
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
