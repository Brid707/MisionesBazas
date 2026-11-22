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
    public sealed class MatchBoardViewModel : ViewModelBase, IDisposable
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

            Instructions = new MatchInstructionsViewModel();
            Evaluation = new MatchEvaluationViewModel();
            Transition = new MatchTransitionViewModel(_uiContext);

            ObjectiveDraft = new MatchObjectiveDraftViewModel(
                _lobbyCode, _participantUserId, _matchClient,
                () => _confirmedMatchSnapshot, () => MatchStateVersion,
                CanSubmitMatchRequest, () => IsSpecialPreparationVisible,
                GetParticipantName, SynchronizeMatchAsync, _seatedPlayers,
                () => _isDisposed);

            FinalPreparation = new MatchFinalPreparationViewModel(
                _lobbyCode, _participantUserId, _matchClient,
                () => _confirmedMatchSnapshot, () => MatchStateVersion,
                CanSubmitMatchRequest,
                () => _confirmedMatchSnapshot?.MissionPreparation?.Stage ?? MissionPreparationStage.None,
                () => IsMissionPreparationComplete,
                new ObservableCollection<LobbyPlayerItemViewModel>(),
                GetParticipantName, SynchronizeMatchAsync);

            SpecialPreparation = new MatchSpecialPreparationViewModel(
                _lobbyCode, _participantUserId, _matchClient,
                () => _confirmedMatchSnapshot, () => MatchStateVersion,
                CanSubmitMatchRequest, GetParticipantName, SynchronizeMatchAsync,
                _seatedPlayers, FinalPreparation);

            Radio = new MatchRadioCommunicationViewModel(
                _lobbyCode, _participantUserId, _matchClient,
                () => _confirmedMatchSnapshot, () => MatchStateVersion,
                CanSubmitMatchRequest, () => IsMatchInPlayableState,
                () => IsDistressSignalInProgress, () => IsMissionAttemptFinished,
                () => IsMissionPreparationComplete, () => HasLocalPlayerCommunicated,
                OwnHandCards, _seatedPlayers, GetParticipantName, SynchronizeMatchAsync,
                () => MatchFeedbackResourceKey = GetCurrentMatchFeedback());

            Distress = new MatchDistressViewModel(
                _lobbyCode, _participantUserId, _matchClient,
                () => _confirmedMatchSnapshot, () => MatchStateVersion,
                CanSubmitMatchRequest, () => _isDisposed, () => _isMatchConnected,
                () => IsMissionPreparationComplete, () => IsMissionAttemptFinished,
                GetParticipantName, SynchronizeMatchAsync, _seatedPlayers,
                key => MatchFeedbackResourceKey = key);

            Instructions.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            Evaluation.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            Transition.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            ObjectiveDraft.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            FinalPreparation.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            SpecialPreparation.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            Radio.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);
            Distress.PropertyChanged += (s, e) => OnPropertyChanged(e.PropertyName);

            PlayCardCommand = new AsyncRelayCommand(SubmitSelectedCardAsync, CanPlaySelectedCard);
            RetryPendingMatchRequestCommand = new AsyncRelayCommand(SynchronizeMatchAsync, CanRetryPendingMatchRequest);

            _matchClient.MatchStateChanged += OnMatchStateChanged;
            _completedTrickDisplayTimer = new Timer(OnCompletedTrickDisplayElapsed, null,
                Timeout.Infinite, Timeout.Infinite);
            _matchRefreshTimer = new Timer(OnRefreshTimer, null, TimeSpan.FromSeconds(2), TimeSpan.FromSeconds(2));
        }

        // Sub-viewmodels
        public MatchInstructionsViewModel Instructions { get; }
        public MatchEvaluationViewModel Evaluation { get; }
        public MatchTransitionViewModel Transition { get; }
        public MatchObjectiveDraftViewModel ObjectiveDraft { get; }
        public MatchFinalPreparationViewModel FinalPreparation { get; }
        public MatchSpecialPreparationViewModel SpecialPreparation { get; }
        public MatchRadioCommunicationViewModel Radio { get; }
        public MatchDistressViewModel Distress { get; }

        // Local Board collections and commands
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

        // Passthroughs: Instructions
        public bool IsMissionInstructionVisible => Instructions.IsMissionInstructionVisible;
        public string MissionInstructionResourceKey => Instructions.MissionInstructionResourceKey;

        // Passthroughs: Evaluation
        public bool IsMissionAttemptFinished => Evaluation.IsMissionAttemptFinished;
        public bool IsMissionAttemptSucceeded => Evaluation.IsMissionAttemptSucceeded;
        public bool IsMissionAttemptFailed => Evaluation.IsMissionAttemptFailed;
        public bool IsTrickTurnVisible => Evaluation.IsTrickTurnVisible;
        public string MissionEvaluationFeedbackResourceKey => Evaluation.MissionEvaluationFeedbackResourceKey;

        // Passthroughs: Transition
        public int CurrentMissionAttemptNumber => Transition.CurrentMissionAttemptNumber;
        public string MissionProgressDisplay => Transition.MissionProgressDisplay;
        public bool IsCampaignCompleted => Transition.IsCampaignCompleted;
        public bool IsMissionTransitionVisible => Transition.IsMissionTransitionVisible;
        public int MissionTransitionRemainingSeconds => Transition.MissionTransitionRemainingSeconds;
        public bool HasMissionTransitionCountdown => Transition.HasMissionTransitionCountdown;
        public string MissionTransitionStatusResourceKey => Transition.MissionTransitionStatusResourceKey;

        // Passthroughs: ObjectiveDraft
        public ObservableCollection<MissionObjectiveViewModel> UnassignedMissionObjectives => ObjectiveDraft.UnassignedMissionObjectives;
        public ICommand SelectMissionObjectiveCommand => ObjectiveDraft.SelectMissionObjectiveCommand;
        public ICommand PassObjectiveDraftCommand => ObjectiveDraft.PassObjectiveDraftCommand;
        public bool IsMissionPreparationComplete => ObjectiveDraft.IsMissionPreparationComplete;
        public bool IsObjectiveDraftVisible => ObjectiveDraft.IsObjectiveDraftVisible;
        public string CurrentObjectiveDraftPlayerName => ObjectiveDraft.CurrentObjectiveDraftPlayerName;

        // Passthroughs: FinalPreparation
        public ObservableCollection<PublicMissionRoleViewModel> ConfirmedMissionRoles => FinalPreparation.ConfirmedMissionRoles;
        public ICommand IdentifyHeartNineOwnerCommand => FinalPreparation.IdentifyHeartNineOwnerCommand;
        public ICommand AssignTrickDistributionCommand => FinalPreparation.AssignTrickDistributionCommand;
        public bool IsTrickDistributionSelection => FinalPreparation.IsTrickDistributionSelection;
        public bool IsHeartNineIdentificationStage => FinalPreparation.IsHeartNineIdentificationStage;
        public bool IsHeartCaptureProgressVisible => FinalPreparation.IsHeartCaptureProgressVisible;
        public string HeartCaptureProgressDisplay => FinalPreparation.HeartCaptureProgressDisplay;
        public bool CanIdentifyHeartNineOwnership => FinalPreparation.CanIdentifyHeartNineOwnership;
        public LobbyPlayerItemViewModel SelectedFirstFourTrickWinner
        {
            get => FinalPreparation.SelectedFirstFourTrickWinner;
            set => FinalPreparation.SelectedFirstFourTrickWinner = value;
        }
        public LobbyPlayerItemViewModel SelectedLastTrickWinner
        {
            get => FinalPreparation.SelectedLastTrickWinner;
            set => FinalPreparation.SelectedLastTrickWinner = value;
        }

        // Passthroughs: SpecialPreparation
        public ObservableCollection<LobbyPlayerItemViewModel> EligibleRoleParticipants => SpecialPreparation.EligibleRoleParticipants;
        public ObservableCollection<BlindObjectiveResponseViewModel> BlindObjectiveResponseDescriptions => SpecialPreparation.BlindObjectiveResponseDescriptions;
        public ICommand AssignMissionRoleCommand => SpecialPreparation.AssignMissionRoleCommand;
        public ICommand RespondCapableCommand => SpecialPreparation.RespondCapableCommand;
        public ICommand RespondNotCapableCommand => SpecialPreparation.RespondNotCapableCommand;
        public bool IsSpecialPreparationVisible => SpecialPreparation.IsSpecialPreparationVisible;
        public bool IsRoleAssignmentVisible => SpecialPreparation.IsRoleAssignmentVisible;
        public bool IsBlindResponseChoiceVisible => SpecialPreparation.IsBlindResponseChoiceVisible;
        public bool AreBlindResponsesVisible => SpecialPreparation.AreBlindResponsesVisible;
        public bool CanRespondBlindObjectives => SpecialPreparation.CanRespondBlindObjectives;
        public bool CanSelectRoleParticipant => SpecialPreparation.CanSelectRoleParticipant;
        public string SpecialPreparationFeedbackKey => SpecialPreparation.SpecialPreparationFeedbackKey;
        public bool HasSingleTrickWinner => SpecialPreparation.HasSingleTrickWinner;
        public string SingleTrickWinnerParticipantName => SpecialPreparation.SingleTrickWinnerParticipantName;
        public bool IsSpecialPreparationPanelOpen
        {
            get => SpecialPreparation.IsSpecialPreparationPanelOpen;
            set => SpecialPreparation.IsSpecialPreparationPanelOpen = value;
        }
        public LobbyPlayerItemViewModel SelectedRoleParticipant
        {
            get => SpecialPreparation.SelectedRoleParticipant;
            set => SpecialPreparation.SelectedRoleParticipant = value;
        }

        // Passthroughs: Radio
        public ObservableCollection<RadioMarkerOptionViewModel> AvailableRadioMarkers => Radio.AvailableRadioMarkers;
        public ObservableCollection<PlayerRadioCommunicationViewModel> RadioCommunications => Radio.RadioCommunications;
        public ICommand SubmitRadioCommunicationCommand => Radio.SubmitRadioCommunicationCommand;
        public ICommand ToggleCommunicationModeCommand => Radio.ToggleCommunicationModeCommand;
        public bool IsCommunicationModeActive
        {
            get => Radio.IsCommunicationModeActive;
            set => Radio.IsCommunicationModeActive = value;
        }
        public HandCardViewModel SelectedRadioCard
        {
            get => Radio.SelectedRadioCard;
            set => Radio.SelectedRadioCard = value;
        }
        public RadioMarkerOptionViewModel SelectedRadioMarker
        {
            get => Radio.SelectedRadioMarker;
            set => Radio.SelectedRadioMarker = value;
        }
        public bool CanCommunicate => Radio.CanCommunicate;
        public bool CanChooseRadioCard => Radio.CanChooseRadioCard;

        // Passthroughs: Distress
        public ObservableCollection<int> EligibleDistressCardIds => Distress.EligibleDistressCardIds;
        public ICommand OpenDistressSignalDialogCommand => Distress.OpenDistressSignalDialogCommand;
        public ICommand CloseDistressSignalDialogCommand => Distress.CloseDistressSignalDialogCommand;
        public ICommand SelectDistressCardCommand => Distress.SelectDistressCardCommand;
        public ICommand ProposeDistressSignalUsageCommand => Distress.ProposeDistressSignalUsageCommand;
        public ICommand VoteDistressUsageYesCommand => Distress.VoteDistressUsageYesCommand;
        public ICommand VoteDistressUsageNoCommand => Distress.VoteDistressUsageNoCommand;
        public ICommand VoteDistressDirectionLeftCommand => Distress.VoteDistressDirectionLeftCommand;
        public ICommand VoteDistressDirectionRightCommand => Distress.VoteDistressDirectionRightCommand;
        public ICommand ConfirmDistressCardSelectionCommand => Distress.ConfirmDistressCardSelectionCommand;
        public ICommand CancelDistressProposalCommand => Distress.CancelDistressProposalCommand;
        public DistressSignalSnapshot DistressSignal => Distress.DistressSignal;
        public bool HasUsedDistressSignal => Distress.HasUsedDistressSignal;
        public bool IsDistressSignalInProgress => Distress.IsDistressSignalInProgress;
        public DistressSignalPhase CurrentDistressStep => Distress.CurrentDistressStep;
        public bool IsLocalDistressUsageVoted => Distress.IsLocalDistressUsageVoted;
        public bool IsLocalDistressDirectionVoted => Distress.IsLocalDistressDirectionVoted;
        public bool IsLocalDistressCardSubmitted => Distress.IsLocalDistressCardSubmitted;
        public bool IsDistressInitiatorConfirmVisible => Distress.IsDistressInitiatorConfirmVisible;
        public bool IsDistressUsageVoteVisible => Distress.IsDistressUsageVoteVisible;
        public bool IsDistressDirectionVoteVisible => Distress.IsDistressDirectionVoteVisible;
        public bool IsDistressCardSelectionVisible => Distress.IsDistressCardSelectionVisible;
        public bool IsDistressWaitingVisible => Distress.IsDistressWaitingVisible;
        public string DistressInitiatorName => Distress.DistressInitiatorName;
        public int DistressUsageYesVotesCount => Distress.DistressUsageYesVotesCount;
        public int DistressDirectionVotesCount => Distress.DistressDirectionVotesCount;
        public int DistressCardsSubmittedCount => Distress.DistressCardsSubmittedCount;
        public int DistressTotalPlayersCount => Distress.DistressTotalPlayersCount;
        public string DistressWaitingProgressText => Distress.DistressWaitingProgressText;
        public string DistressStepWaitingResourceKey => Distress.DistressStepWaitingResourceKey;
        public string DistressAgreedDirectionResourceKey => Distress.DistressAgreedDirectionResourceKey;
        public bool IsDistressSignalDialogOpen
        {
            get => Distress.IsDistressSignalDialogOpen;
            set => Distress.IsDistressSignalDialogOpen = value;
        }
        public DistressPassDirection SelectedDistressDirection
        {
            get => Distress.SelectedDistressDirection;
            set => Distress.SelectedDistressDirection = value;
        }
        public int SelectedDistressCardId
        {
            get => Distress.SelectedDistressCardId;
            set => Distress.SelectedDistressCardId = value;
        }
        public bool CanConfirmDistressCard => Distress.CanConfirmDistressCard;
        public bool HasLocalPlayerCommunicated => Distress.HasLocalPlayerCommunicated;
        public bool HasAnyPlayerCommunicated => Distress.HasAnyPlayerCommunicated;
        public bool CanUseDistressSignal => Distress.CanUseDistressSignal;

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
                try
                {
                    await SynchronizeCoreAsync();
                }
                catch (FaultException<MatchAccessFault> ex)
                {
                    string feedbackKey = Evaluation.GetMatchFaultFeedback(
                        ex.Detail, Radio.HasPendingRadio, SpecialPreparation.HasPendingPreparation);
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
                    OnPropertyChanged(nameof(CanCommunicate));
                    SpecialPreparation.NotifySpecialPreparationProperties();
                    UpdateHandCardRaisedStates();
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        public void Dispose()
        {
            _isDisposed = true;
            _matchRefreshTimer.Dispose();
            Transition.Dispose();
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
            string preparationFeedback = await SpecialPreparation.ConfirmPendingPreparationAsync();
            string rejectionResourceKey = await ObjectiveDraft.ConfirmPendingObjectiveDraftAsync() ?? preparationFeedback;
            string radioFeedback = await Radio.ConfirmPendingRadioAsync();
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
                    return CanCommunicate && Radio.GetValidPositionsForCard(cardId).Count > 0;
                }

                return CanPlayCurrentTurn() && GetPlayableCardIds().Contains(cardId);
            }

            return false;
        }

        private bool IsMatchInPlayableState
        {
            get
            {
                bool isSessionActive = !_isDisposed && _isMatchConnected;
                bool isMatchLive = _confirmedMatchSnapshot != null && !_confirmedMatchSnapshot.IsDealCompleted;
                return isSessionActive && isMatchLive;
            }
        }

        private bool CanPlayCurrentTurn()
        {
            if (!IsMatchInPlayableState)
            {
                return false;
            }

            bool isTurnActive = CurrentTurnPlayerUserId == _participantUserId;
            bool isPlayAllowed = !IsDistressSignalInProgress && !IsMissionAttemptFinished;
            bool isPendingFree = _pendingCardPlaySubmission == null && IsMissionPreparationComplete;

            return isTurnActive && isPlayAllowed && isPendingFree;
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
                    await Radio.ExecuteCardCommunicationFromHandAsync(cardId);
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
            return !_isDisposed && (_pendingCardPlaySubmission != null || ObjectiveDraft.HasPendingSubmission ||
                Radio.HasPendingRadio || SpecialPreparation.HasPendingPreparation) &&
                _isRequestInProgress == 0;
        }

        private bool CanSubmitMatchRequest()
        {
            return !_isDisposed && _isMatchConnected && _isRequestInProgress == 0 &&
                !ObjectiveDraft.HasPendingSubmission && _pendingCardPlaySubmission == null &&
                !Radio.HasPendingRadio && !SpecialPreparation.HasPendingPreparation;
        }

        private void ApplyConfirmedSnapshot(PlayerMatchSnapshot playerSnapshot)
        {
            bool isSameMatch = _confirmedMatchSnapshot == null ||
                _confirmedMatchSnapshot.MatchId == playerSnapshot.MatchId;
            if (isSameMatch && playerSnapshot.MatchStateVersion >= MatchStateVersion)
            {
                ResetAttemptPresentationIfChanged(playerSnapshot);
                _confirmedMatchSnapshot = playerSnapshot;
                Transition.ApplyTransitionSnapshot(
                    playerSnapshot.MissionTransition,
                    playerSnapshot.MissionPreparation?.MissionNumber,
                    _isMatchConnected);
                _isMatchConnected = true;
                HashSet<int> playableCardIds = new HashSet<int>(GetPlayableCardIds());
                UpdatePublicSeatStates(playerSnapshot);
                ObjectiveDraft.ApplyObjectiveDraftSnapshot(playerSnapshot.MissionPreparation);
                SpecialPreparation.ApplySpecialPreparationSnapshot(playerSnapshot.MissionPreparation);
                ReplaceOwnHandIfChanged(playerSnapshot, playableCardIds);
                UpdateHandCardRaisedStates();
                Radio.ApplyRadioSnapshot(playerSnapshot);
                Distress.ApplyDistressSignalState(playerSnapshot);
                ReplacePublicPlays(playerSnapshot);
                RefreshCompletedTrickDisplay(playerSnapshot);
                NotifyMatchProperties();
                Evaluation.ApplyEvaluation(playerSnapshot.MissionEvaluation, IsMissionPreparationComplete);
                Instructions.UpdateMissionNumber(playerSnapshot.MissionPreparation?.MissionNumber);
                Transition.NotifyMissionTransitionProperties();
                Distress.NotifyDistressProperties();
                MatchFeedbackResourceKey = GetCurrentMatchFeedback();
            }
            else if (!isSameMatch)
            {
                _isMatchConnected = false;
                MatchFeedbackResourceKey = "Match_AccessUnavailable";
            }
        }

        private void ResetAttemptPresentationIfChanged(PlayerMatchSnapshot playerSnapshot)
        {
            bool hasAttemptChanged = _confirmedMatchSnapshot?.MissionPreparation != null &&
                _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId !=
                    playerSnapshot.MissionPreparation?.MissionAttemptId;
            if (hasAttemptChanged)
            {
                _announcedCompletedTrickCount = 0;
                _isCompletedTrickDisplayActive = false;
                _completedTrickDisplayTimer.Change(Timeout.Infinite, Timeout.Infinite);
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
            Radio.RefreshCommunicationHighlights();
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
