using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using Model.Services;
using TrickTakingMissions.Logging.Abstractions.Ports;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>Reconciles the local hand and preserves submission identity when retrying an uncertain play.</summary>
    public sealed partial class MatchBoardViewModel : ViewModelBase, IDisposable
    {
        private const int CompletedTrickDisplayMilliseconds = 2500;
        private const string LogMatchSynchronizationFailed =
            "Match synchronization failed for LobbyCode={LobbyCode} (FeedbackKey={FeedbackKey}," +
            " ExceptionType={ExceptionType}).";

        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly ILoggerService _logger;
        private readonly SynchronizationContext _uiContext;
        private readonly Timer _matchRefreshTimer;
        private readonly Timer _completedTrickDisplayTimer;
        private readonly Dictionary<int, string> _participantNamesByUserId = new Dictionary<int, string>();
        private readonly List<LobbyPlayerItemViewModel> _seatedPlayers = new List<LobbyPlayerItemViewModel>();
        private PlayerMatchSnapshot _confirmedMatchSnapshot;
        private CardPlaySubmission _pendingCardPlaySubmission;
        private string _matchFeedbackResourceKey = "Match_Connecting";
        private bool _isMatchConnected;
        private bool _isDisposed;
        private bool _isCompletedTrickDisplayActive;
        private int _isRequestInProgress;
        private int _announcedCompletedTrickCount;

        public MatchBoardViewModel(MatchBoardContext context, ILoggerService logger)
        {
            if (context == null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            _lobbyCode = context.LobbyCode;
            _participantUserId = context.ParticipantUserId;
            _matchClient = context.MatchClient;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _uiContext = SynchronizationContext.Current;
            OwnHandCards = new ObservableCollection<HandCardViewModel>();
            CurrentTrickCardPlays = new ObservableCollection<PlayedCardViewModel>();
            LastCompletedTrickCardPlays = new ObservableCollection<PlayedCardViewModel>();
            InitializeObjectiveDraftCommands();
            InitializeRadioCommand();
            InitializeSpecialPreparationCommands();
            InitializeFinalPreparationCommands();
            InitializeDistressSignalCommands();
            _missionTransitionCountdownTimer = new Timer(OnMissionTransitionCountdownTick, null, TimeSpan.Zero,
                TimeSpan.FromMilliseconds(250));
            PlayCardCommand = new AsyncRelayCommand(SubmitSelectedCardAsync, CanPlaySelectedCard);
            RetryPendingMatchRequestCommand = new AsyncRelayCommand(SynchronizeMatchAsync, CanRetryPendingMatchRequest);
            _matchClient.MatchStateChanged += OnMatchStateChanged;
            _completedTrickDisplayTimer = new Timer(OnCompletedTrickDisplayElapsed, null,
                Timeout.Infinite, Timeout.Infinite);
            _matchRefreshTimer = new Timer(OnRefreshTimer, null, TimeSpan.FromSeconds(2), TimeSpan.FromSeconds(2));
        }

        public ObservableCollection<HandCardViewModel> OwnHandCards { get; }
        public ObservableCollection<PlayedCardViewModel> CurrentTrickCardPlays { get; }
        public ObservableCollection<PlayedCardViewModel> LastCompletedTrickCardPlays { get; }
        public ICommand PlayCardCommand { get; }
        public ICommand RetryPendingMatchRequestCommand { get; }
        public long MatchStateVersion => _confirmedMatchSnapshot?.MatchStateVersion ?? 0;
        public int CurrentTrickNumber => _confirmedMatchSnapshot?.CurrentTrickNumber ?? 1;
        public int MaximumMissionTrickCount => _confirmedMatchSnapshot?.MaximumMissionTrickCount ?? 0;
        public int CurrentTurnPlayerUserId => _confirmedMatchSnapshot?.CurrentTurnPlayerUserId ?? 0;
        public int LastTrickWinnerUserId => _confirmedMatchSnapshot?.LastTrickWinnerUserId ?? 0;

        public string CurrentTurnPlayerName => GetParticipantName(CurrentTurnPlayerUserId);
        public string LastTrickWinnerName => GetParticipantName(LastTrickWinnerUserId);

        public string TrickProgressDisplay => string.Format(CultureInfo.InvariantCulture, "{0}/{1}",
            CurrentTrickNumber, MaximumMissionTrickCount);

        public bool HasLastTrickWinner => LastTrickWinnerUserId != 0 && !string.IsNullOrEmpty(LastTrickWinnerName);

        public bool ShouldShowLastCompletedTrick =>
            (_isCompletedTrickDisplayActive || IsDealCompleted || IsMissionAttemptFinished) &&
            CurrentTrickCardPlays.Count == 0 && LastCompletedTrickCardPlays.Count > 0;

        public string MatchFeedbackResourceKey
        {
            get => _matchFeedbackResourceKey;
            private set => SetProperty(ref _matchFeedbackResourceKey, value);
        }

        private bool IsDealCompleted => _confirmedMatchSnapshot?.IsDealCompleted ?? false;

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
                    string feedbackKey = GetMatchFaultFeedback(ex.Detail);
                    SetConnectionFailure(feedbackKey, ex);
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
                    OnPropertyChanged(nameof(CanChooseRadioCard));
                    NotifySpecialPreparationProperties();
                    UpdateHandCardRaisedStates();
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        public void Dispose()
        {
            _isDisposed = true;
            _matchRefreshTimer.Dispose();
            _missionTransitionCountdownTimer.Dispose();
            _completedTrickDisplayTimer.Dispose();
            _matchClient.MatchStateChanged -= OnMatchStateChanged;
        }

        private string GetParticipantName(int participantUserId)
        {
            _participantNamesByUserId.TryGetValue(participantUserId, out string participantName);
            return participantName ?? string.Empty;
        }

        private async Task SynchronizeCoreAsync()
        {
            string preparationFeedback = await ConfirmPendingPreparationAsync();
            string rejectionResourceKey = await ConfirmPendingObjectiveDraftAsync() ?? preparationFeedback;
            string radioFeedback = await ConfirmPendingRadioAsync();
            if (radioFeedback != null)
            {
                rejectionResourceKey = radioFeedback;
            }
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
            if (IsDistressSignalInProgress)
            {
                return false;
            }

            if (selectedCard is int cardId)
            {
                if (IsCommunicationModeActive)
                {
                    return CanCommunicate && GetValidPositionsForCard(cardId).Count > 0;
                }

                return CanPlayCurrentTurn() && GetPlayableCardIds().Contains(cardId);
            }

            return false;
        }

        private bool CanPlayCurrentTurn()
        {
            return CanSubmitMatchRequest() && _confirmedMatchSnapshot != null &&
                !_confirmedMatchSnapshot.IsDealCompleted && IsMissionPreparationComplete && !IsMissionAttemptFinished &&
                !IsDistressSignalInProgress && CurrentTurnPlayerUserId == _participantUserId;
        }

        private void UpdateHandCardRaisedStates()
        {
            bool canRaiseForCurrentTurn = CanPlayCurrentTurn();
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
                    Card = DeckRules.GetCardById(play.CardId),
                    PlayOrder = (byte)playOrder
                }).ToArray();
            return TrickFollowSuitRules.GetPlayableCards(playerHand, publicTrick).ToArray();
        }

        private async Task SubmitSelectedCardAsync(object selectedCard)
        {
            if (selectedCard is int cardId)
            {
                if (IsCommunicationModeActive)
                {
                    await ExecuteCardCommunicationFromHandAsync(cardId);
                    return;
                }

                if (CanPlaySelectedCard(selectedCard))
                {
                    _pendingCardPlaySubmission = new CardPlaySubmission
                    {
                        LobbyCode = _lobbyCode,
                        MatchId = _confirmedMatchSnapshot.MatchId,
                        MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                        CardId = cardId,
                        CardPlaySubmissionId = Guid.NewGuid(),
                        ExpectedMatchStateVersion = MatchStateVersion
                    };
                    await SynchronizeMatchAsync();
                }
            }
        }

        private bool CanRetryPendingMatchRequest()
        {
            return !_isDisposed && (_pendingCardPlaySubmission != null || _pendingObjectiveDraftSubmission != null ||
                _pendingRadioSubmission != null || HasPendingPreparation) &&
                _isRequestInProgress == 0;
        }

        private void ApplyConfirmedSnapshot(PlayerMatchSnapshot playerSnapshot)
        {
            bool isSameMatch = _confirmedMatchSnapshot == null ||
                _confirmedMatchSnapshot.MatchId == playerSnapshot.MatchId;
            if (isSameMatch && playerSnapshot.MatchStateVersion >= MatchStateVersion)
            {
                ResetAttemptPresentationIfChanged(playerSnapshot);
                _confirmedMatchSnapshot = playerSnapshot;
                ApplyMissionTransitionSnapshot(playerSnapshot.MissionTransition);
                _isMatchConnected = true;
                HashSet<int> playableCardIds = new HashSet<int>(GetPlayableCardIds());
                UpdatePublicSeatStates(playerSnapshot);
                ApplyObjectiveDraftSnapshot(playerSnapshot.MissionPreparation);
                ApplySpecialPreparationSnapshot(playerSnapshot.MissionPreparation);
                ReplaceOwnHandIfChanged(playerSnapshot, playableCardIds);
                UpdateHandCardRaisedStates();
                ApplyRadioSnapshot(playerSnapshot);
                ApplyDistressSignalState(playerSnapshot);
                ReplacePublicPlays(playerSnapshot);
                RefreshCompletedTrickDisplay(playerSnapshot);
                NotifyMatchProperties();
                NotifyMissionEvaluationProperties();
                NotifyMissionInstructionProperties();
                NotifyMissionTransitionProperties();
                NotifyDistressProperties();
                MatchFeedbackResourceKey = GetCurrentMatchFeedback();
            }
            else if (!isSameMatch)
            {
                _isMatchConnected = false;
                MatchFeedbackResourceKey = "Match_AccessUnavailable";
            }
        }

        private void ReplaceOwnHandIfChanged(PlayerMatchSnapshot playerSnapshot, HashSet<int> playableCardIds)
        {
            bool hasSameHand = OwnHandCards.Select(card => card.CardId).SequenceEqual(playerSnapshot.OwnHandCardIds) &&
                OwnHandCards.All(card => card.IsPlayableByRules == playableCardIds.Contains(card.CardId));
            if (!hasSameHand)
            {
                OwnHandCards.Clear();
                foreach (int cardId in playerSnapshot.OwnHandCardIds)
                {
                    OwnHandCards.Add(new HandCardViewModel(cardId, PlayCardCommand,
                        playableCardIds.Contains(cardId)));
                }
            }
            RefreshCommunicationHighlights();
        }

        private void UpdatePublicSeatStates(PlayerMatchSnapshot playerSnapshot)
        {
            foreach (LobbyPlayerItemViewModel participant in _seatedPlayers)
            {
                int participantSeat = Array.IndexOf(playerSnapshot.ParticipantUserIds, participant.IdUser);
                if (participantSeat >= 0 && participantSeat < playerSnapshot.RemainingHandCardCounts.Length)
                {
                    participant.UpdateRemainingHandCardCount(playerSnapshot.RemainingHandCardCounts[participantSeat]);
                }
                participant.UpdateMissionCaptain(participant.IdUser == playerSnapshot.MissionCaptainUserId);
                UpdateParticipantCapturedCards(participant, playerSnapshot);
            }
        }

        private static void UpdateParticipantCapturedCards(LobbyPlayerItemViewModel participant,
            PlayerMatchSnapshot playerSnapshot)
        {
            PlayerCapturedCardsSnapshot capturedCards = GetCapturedCards(playerSnapshot)
                .FirstOrDefault(captured => captured.PlayerUserId == participant.IdUser);
            int wonTrickCount = capturedCards?.WonTrickCount ?? 0;
            int[] wonCardIds = capturedCards?.WonCardIds ?? new int[0];
            participant.UpdateCapturedCards(wonTrickCount, wonCardIds);
        }

        private static PlayerCapturedCardsSnapshot[] GetCapturedCards(PlayerMatchSnapshot playerSnapshot)
        {
            return playerSnapshot.CapturedCardsByPlayer ?? new PlayerCapturedCardsSnapshot[0];
        }

        private void RefreshCompletedTrickDisplay(PlayerMatchSnapshot playerSnapshot)
        {
            int completedTrickCount = GetCapturedCards(playerSnapshot).Sum(captured => captured.WonTrickCount);
            if (completedTrickCount > _announcedCompletedTrickCount)
            {
                _announcedCompletedTrickCount = completedTrickCount;
                _isCompletedTrickDisplayActive = true;
                _completedTrickDisplayTimer.Change(CompletedTrickDisplayMilliseconds, Timeout.Infinite);
            }
        }

        private string GetCurrentMatchFeedback()
        {
            return IsMissionAttemptFinished ? MissionEvaluationFeedbackResourceKey : GetActiveMatchFeedback();
        }

        private string GetActiveMatchFeedback()
        {
            string feedbackResourceKey = "Match_WaitingTurn";
            if (CurrentTurnPlayerUserId == _participantUserId)
            {
                feedbackResourceKey = "Match_YourTurn";
            }
            if (_confirmedMatchSnapshot.IsDealCompleted)
            {
                feedbackResourceKey = "Match_DealCompleted";
            }
            if (IsObjectiveDraftVisible)
            {
                feedbackResourceKey = "MissionDraft_Label_SelectOrPass";
            }
            if (IsSpecialPreparationVisible)
            {
                feedbackResourceKey = SpecialPreparationFeedbackKey;
            }
            if (IsCommunicationModeActive)
            {
                feedbackResourceKey = "Match_Notice_CommunicationActive";
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
            OnPropertyChanged(nameof(TrickProgressDisplay));
            OnPropertyChanged(nameof(CurrentTurnPlayerUserId));
            OnPropertyChanged(nameof(LastTrickWinnerUserId));
            OnPropertyChanged(nameof(CurrentTurnPlayerName));
            OnPropertyChanged(nameof(LastTrickWinnerName));
            OnPropertyChanged(nameof(HasLastTrickWinner));
            OnPropertyChanged(nameof(ShouldShowLastCompletedTrick));
        }

        private void SetConnectionFailure(string feedbackResourceKey, Exception ex)
        {
            _logger.Warning(LogMatchSynchronizationFailed, _lobbyCode, feedbackResourceKey, ex.GetType().Name);
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

        private void OnCompletedTrickDisplayElapsed(object timerState)
        {
            if (!_isDisposed && _uiContext != null)
            {
                _uiContext.Post(_ => EndCompletedTrickDisplay(), null);
            }
        }

        private void EndCompletedTrickDisplay()
        {
            _isCompletedTrickDisplayActive = false;
            OnPropertyChanged(nameof(ShouldShowLastCompletedTrick));
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
