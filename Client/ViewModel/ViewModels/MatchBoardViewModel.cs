using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using Model.Services;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;
using ViewModel.Constants;

namespace ViewModel.ViewModels
{
    /// <summary>Reconciles the local hand and preserves submission identity when retrying an uncertain play.</summary>
    public sealed class MatchBoardViewModel : ViewModelBase, IDisposable
    {
        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly SynchronizationContext _uiContext;
        private readonly Timer _matchRefreshTimer;
        private readonly Dictionary<int, string> _participantNamesByUserId = new Dictionary<int, string>();
        private readonly List<LobbyPlayerItemViewModel> _seatedPlayers = new List<LobbyPlayerItemViewModel>();
        private PlayerMatchSnapshot _confirmedMatchSnapshot;
        private CardPlaySubmission _pendingCardPlaySubmission;
        private string _matchFeedbackResourceKey = "Match_Connecting";
        private bool _isMatchConnected;
        private bool _isDisposed;
        private int _isRequestInProgress;

        public MatchBoardViewModel(string lobbyCode, int participantUserId, IMatchClient matchClient)
        {
            _lobbyCode = lobbyCode;
            _participantUserId = participantUserId;
            _matchClient = matchClient;
            _uiContext = SynchronizationContext.Current;
            OwnHandCards = new ObservableCollection<HandCardViewModel>();
            CurrentTrickCardPlays = new ObservableCollection<PlayedCardViewModel>();
            LastCompletedTrickCardPlays = new ObservableCollection<PlayedCardViewModel>();
            PlayCardCommand = new AsyncRelayCommand(SubmitSelectedCardAsync, CanPlaySelectedCard);
            RetryPendingCardPlayCommand = new AsyncRelayCommand(SynchronizeMatchAsync, CanRetryPendingPlay);
            _matchClient.MatchStateChanged += OnMatchStateChanged;
            _matchRefreshTimer = new Timer(OnRefreshTimer, null, TimeSpan.FromSeconds(2), TimeSpan.FromSeconds(2));
        }

        public ObservableCollection<HandCardViewModel> OwnHandCards { get; }
        public ObservableCollection<PlayedCardViewModel> CurrentTrickCardPlays { get; }
        public ObservableCollection<PlayedCardViewModel> LastCompletedTrickCardPlays { get; }
        public ICommand PlayCardCommand { get; }
        public ICommand RetryPendingCardPlayCommand { get; }
        public long MatchStateVersion => _confirmedMatchSnapshot?.MatchStateVersion ?? 0;
        public int CurrentTrickNumber => _confirmedMatchSnapshot?.CurrentTrickNumber ?? 1;
        public int MaximumMissionTrickCount => _confirmedMatchSnapshot?.MaximumMissionTrickCount ?? 0;
        public int CurrentTurnPlayerUserId => _confirmedMatchSnapshot?.CurrentTurnPlayerUserId ?? 0;
        public int LastTrickWinnerUserId => _confirmedMatchSnapshot?.LastTrickWinnerUserId ?? 0;

        public string CurrentTurnPlayerName => GetParticipantName(CurrentTurnPlayerUserId);
        public string LastTrickWinnerName => GetParticipantName(LastTrickWinnerUserId);

        public string MatchFeedbackResourceKey
        {
            get => _matchFeedbackResourceKey;
            private set => SetProperty(ref _matchFeedbackResourceKey, value);
        }

        public void ConfigureParticipantNames(IEnumerable<LobbyPlayerItemViewModel> participants)
        {
            _seatedPlayers.Clear();
            foreach (LobbyPlayerItemViewModel participant in participants)
            {
                _participantNamesByUserId[participant.IdUser] = participant.Username;
                _seatedPlayers.Add(participant);
            }
        }

        public async Task SynchronizeMatchAsync()
        {
            if (!_isDisposed && Interlocked.CompareExchange(ref _isRequestInProgress, 1, 0) == 0)
            {
                UpdateHandCardRaisedStates();
                try
                {
                    await SynchronizeCoreAsync();
                }
                catch (FaultException<MatchAccessFault> ex)
                {
                    SetConnectionFailure("Match_AccessUnavailable", ex);
                }
                catch (FaultException ex)
                {
                    SetConnectionFailure("Match_AccessUnavailable", ex);
                }
                catch (CommunicationException ex)
                {
                    SetConnectionFailure("Match_ConnectionLost", ex);
                }
                catch (TimeoutException ex)
                {
                    SetConnectionFailure("Match_ConnectionLost", ex);
                }
                finally
                {
                    Interlocked.Exchange(ref _isRequestInProgress, 0);
                    UpdateHandCardRaisedStates();
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        public void Dispose()
        {
            _isDisposed = true;
            _matchRefreshTimer.Dispose();
            _matchClient.MatchStateChanged -= OnMatchStateChanged;
        }

        private string GetParticipantName(int participantUserId)
        {
            _participantNamesByUserId.TryGetValue(participantUserId, out string participantName);
            return participantName ?? string.Empty;
        }

        private async Task SynchronizeCoreAsync()
        {
            string rejectionResourceKey = null;
            if (_pendingCardPlaySubmission != null)
            {
                MatchFeedbackResourceKey = "Match_Confirming";
                CardPlayDecision playDecision = await _matchClient.PlayCardAsync(
                    _pendingCardPlaySubmission, _participantUserId);
                if (!_isDisposed && playDecision.CardPlaySubmissionId ==
                    _pendingCardPlaySubmission.CardPlaySubmissionId)
                {
                    rejectionResourceKey = playDecision.IsAccepted ? null : "Match_" + playDecision.RejectionReason;
                    _pendingCardPlaySubmission = null;
                }
            }
            PlayerMatchSnapshot playerSnapshot = await _matchClient.GetPlayerMatchAsync(_lobbyCode, _participantUserId);
            if (!_isDisposed)
            {
                ApplyConfirmedSnapshot(playerSnapshot);
                if (rejectionResourceKey != null)
                {
                    MatchFeedbackResourceKey = rejectionResourceKey;
                }
            }
        }

        private bool CanPlaySelectedCard(object selectedCard)
        {
            bool canPlay = !_isDisposed && _isMatchConnected && _isRequestInProgress == 0 &&
                _pendingCardPlaySubmission == null && _confirmedMatchSnapshot != null &&
                !_confirmedMatchSnapshot.IsDealCompleted && CurrentTurnPlayerUserId == _participantUserId;
            return canPlay && selectedCard is int cardId && GetPlayableCardIds().Contains(cardId);
        }

        private void UpdateHandCardRaisedStates()
        {
            bool canRaiseForCurrentTurn = !_isDisposed && _isMatchConnected &&
                _pendingCardPlaySubmission == null && _confirmedMatchSnapshot != null &&
                !_confirmedMatchSnapshot.IsDealCompleted && CurrentTurnPlayerUserId == _participantUserId;
            foreach (HandCardViewModel handCard in OwnHandCards)
            {
                handCard.UpdateTurnAvailability(canRaiseForCurrentTurn);
            }
        }

        private int[] GetPlayableCardIds()
        {
            Card[] playerHand = _confirmedMatchSnapshot.OwnHandCardIds.Select(DeckRules.GetCardById).ToArray();
            TrickCardPlay[] publicTrick = _confirmedMatchSnapshot.CurrentTrickCardPlays
                .Select((play, playOrder) => new TrickCardPlay
                {
                    Card = DeckRules.GetCardById(play.CardId), PlayOrder = (byte)playOrder
                }).ToArray();
            return TrickFollowSuitRules.GetPlayableCards(playerHand, publicTrick).ToArray();
        }

        private async Task SubmitSelectedCardAsync(object selectedCard)
        {
            if (CanPlaySelectedCard(selectedCard))
            {
                _pendingCardPlaySubmission = new CardPlaySubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = _confirmedMatchSnapshot.MatchId,
                    CardId = (int)selectedCard,
                    CardPlaySubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = MatchStateVersion
                };
                await SynchronizeMatchAsync();
            }
        }

        private bool CanRetryPendingPlay()
        {
            return !_isDisposed && _pendingCardPlaySubmission != null && _isRequestInProgress == 0;
        }

        private void ApplyConfirmedSnapshot(PlayerMatchSnapshot playerSnapshot)
        {
            bool isSameMatch = _confirmedMatchSnapshot == null ||
                _confirmedMatchSnapshot.MatchId == playerSnapshot.MatchId;
            if (isSameMatch && playerSnapshot.MatchStateVersion >= MatchStateVersion)
            {
                _confirmedMatchSnapshot = playerSnapshot;
                _isMatchConnected = true;
                var playableCardIds = new HashSet<int>(GetPlayableCardIds());
                UpdatePublicHandCounts(playerSnapshot);
                OwnHandCards.Clear();
                foreach (int cardId in playerSnapshot.OwnHandCardIds)
                {
                    OwnHandCards.Add(new HandCardViewModel(cardId, PlayCardCommand,
                        playableCardIds.Contains(cardId)));
                }
                ReplacePublicPlays(playerSnapshot);
                NotifyMatchProperties();
                MatchFeedbackResourceKey = GetCurrentMatchFeedback();
            }
            else if (!isSameMatch)
            {
                _isMatchConnected = false;
                MatchFeedbackResourceKey = "Match_AccessUnavailable";
            }
        }

        private void UpdatePublicHandCounts(PlayerMatchSnapshot playerSnapshot)
        {
            foreach (LobbyPlayerItemViewModel participant in _seatedPlayers)
            {
                int participantSeat = Array.IndexOf(playerSnapshot.ParticipantUserIds, participant.IdUser);
                if (participantSeat >= 0 && participantSeat < playerSnapshot.RemainingHandCardCounts.Length)
                {
                    participant.UpdateRemainingHandCardCount(playerSnapshot.RemainingHandCardCounts[participantSeat]);
                }
            }
        }

        private string GetCurrentMatchFeedback()
        {
            string feedbackResourceKey = "Match_WaitingTurn";
            if (_confirmedMatchSnapshot.IsDealCompleted)
            {
                feedbackResourceKey = "Match_DealCompleted";
            }
            else if (CurrentTurnPlayerUserId == _participantUserId)
            {
                feedbackResourceKey = "Match_YourTurn";
            }
            return feedbackResourceKey;
        }

        private void ReplacePublicPlays(PlayerMatchSnapshot playerSnapshot)
        {
            CurrentTrickCardPlays.Clear();
            foreach (MatchCardPlay confirmedPlay in playerSnapshot.CurrentTrickCardPlays)
            {
                CurrentTrickCardPlays.Add(new PlayedCardViewModel(confirmedPlay.CardId,
                    GetParticipantName(confirmedPlay.PlayerUserId), GetTablePosition(confirmedPlay.PlayerUserId)));
            }
            LastCompletedTrickCardPlays.Clear();
            foreach (MatchCardPlay completedPlay in playerSnapshot.LastCompletedTrickCardPlays)
            {
                LastCompletedTrickCardPlays.Add(new PlayedCardViewModel(completedPlay.CardId,
                    GetParticipantName(completedPlay.PlayerUserId), GetTablePosition(completedPlay.PlayerUserId)));
            }
        }

        private MatchTablePosition GetTablePosition(int participantUserId)
        {
            int relativePlayerIndex = _seatedPlayers.FindIndex(player => player.IdUser == participantUserId);
            MatchTablePosition tablePosition = MatchTablePosition.Local;
            if (relativePlayerIndex == 1)
            {
                tablePosition = MatchTablePosition.Left;
            }
            else if (relativePlayerIndex == 2)
            {
                tablePosition = _seatedPlayers.Count == 3 ? MatchTablePosition.Right : MatchTablePosition.Top;
            }
            else if (relativePlayerIndex == 3)
            {
                tablePosition = MatchTablePosition.Right;
            }
            return tablePosition;
        }

        private void NotifyMatchProperties()
        {
            OnPropertyChanged(nameof(MatchStateVersion));
            OnPropertyChanged(nameof(CurrentTrickNumber));
            OnPropertyChanged(nameof(MaximumMissionTrickCount));
            OnPropertyChanged(nameof(CurrentTurnPlayerUserId));
            OnPropertyChanged(nameof(LastTrickWinnerUserId));
            OnPropertyChanged(nameof(CurrentTurnPlayerName));
            OnPropertyChanged(nameof(LastTrickWinnerName));
        }

        private void SetConnectionFailure(string feedbackResourceKey, Exception ex)
        {
            System.Diagnostics.Trace.TraceWarning("Match synchronization failed: {0}", ex.GetType().Name);
            if (!_isDisposed)
            {
                _isMatchConnected = false;
                MatchFeedbackResourceKey = feedbackResourceKey;
            }
        }

        private void OnMatchStateChanged(long matchStateVersion)
        {
            DispatchSynchronization();
        }

        private void OnRefreshTimer(object timerState)
        {
            DispatchSynchronization();
        }

        private void DispatchSynchronization()
        {
            if (!_isDisposed && _uiContext != null)
            {
                _uiContext.Post(_ => BeginSynchronization(), null);
            }
        }

        private void BeginSynchronization()
        {
            _ = SynchronizeMatchAsync();
        }

    }
}
