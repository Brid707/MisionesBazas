using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using Model.Services;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchDistressViewModel : ViewModelBase
    {
        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly Func<PlayerMatchSnapshot> _snapshotProvider;
        private readonly Func<long> _matchStateVersionProvider;
        private readonly Func<bool> _canSubmitMatchRequestProvider;
        private readonly Func<bool> _isDisposedProvider;
        private readonly Func<bool> _isMatchConnectedProvider;
        private readonly Func<bool> _isMissionPreparationCompleteProvider;
        private readonly Func<bool> _isMissionAttemptFinishedProvider;
        private readonly Func<int, string> _participantNameResolver;
        private readonly Func<Task> _synchronizeMatchAction;
        private readonly List<LobbyPlayerItemViewModel> _seatedPlayers;
        private readonly Action<string> _setFeedbackAction;

        private bool _isDistressSignalDialogOpen;
        private DistressPassDirection _selectedDistressDirection = DistressPassDirection.Left;
        private int _selectedDistressCardId;
        private bool _hasShownDistressRejectionNotice;

        public MatchDistressViewModel(
            string lobbyCode,
            int participantUserId,
            IMatchClient matchClient,
            Func<PlayerMatchSnapshot> snapshotProvider,
            Func<long> matchStateVersionProvider,
            Func<bool> canSubmitMatchRequestProvider,
            Func<bool> isDisposedProvider,
            Func<bool> isMatchConnectedProvider,
            Func<bool> isMissionPreparationCompleteProvider,
            Func<bool> isMissionAttemptFinishedProvider,
            Func<int, string> participantNameResolver,
            Func<Task> synchronizeMatchAction,
            List<LobbyPlayerItemViewModel> seatedPlayers,
            Action<string> setFeedbackAction)
        {
            _lobbyCode = lobbyCode;
            _participantUserId = participantUserId;
            _matchClient = matchClient ?? throw new ArgumentNullException(nameof(matchClient));
            _snapshotProvider = snapshotProvider ?? throw new ArgumentNullException(nameof(snapshotProvider));
            _matchStateVersionProvider = matchStateVersionProvider ?? throw new ArgumentNullException(nameof(matchStateVersionProvider));
            _canSubmitMatchRequestProvider = canSubmitMatchRequestProvider ?? throw new ArgumentNullException(nameof(canSubmitMatchRequestProvider));
            _isDisposedProvider = isDisposedProvider ?? throw new ArgumentNullException(nameof(isDisposedProvider));
            _isMatchConnectedProvider = isMatchConnectedProvider ?? throw new ArgumentNullException(nameof(isMatchConnectedProvider));
            _isMissionPreparationCompleteProvider = isMissionPreparationCompleteProvider ?? throw new ArgumentNullException(nameof(isMissionPreparationCompleteProvider));
            _isMissionAttemptFinishedProvider = isMissionAttemptFinishedProvider ?? throw new ArgumentNullException(nameof(isMissionAttemptFinishedProvider));
            _participantNameResolver = participantNameResolver ?? throw new ArgumentNullException(nameof(participantNameResolver));
            _synchronizeMatchAction = synchronizeMatchAction ?? throw new ArgumentNullException(nameof(synchronizeMatchAction));
            _seatedPlayers = seatedPlayers ?? throw new ArgumentNullException(nameof(seatedPlayers));
            _setFeedbackAction = setFeedbackAction ?? throw new ArgumentNullException(nameof(setFeedbackAction));

            EligibleDistressCardIds = new ObservableCollection<int>();
            InitializeDistressSignalCommands();
        }

        public ObservableCollection<int> EligibleDistressCardIds { get; }
        public ICommand OpenDistressSignalDialogCommand { get; private set; }
        public ICommand CloseDistressSignalDialogCommand { get; private set; }
        public ICommand SelectDistressCardCommand { get; private set; }
        public ICommand ProposeDistressSignalUsageCommand { get; private set; }
        public ICommand VoteDistressUsageYesCommand { get; private set; }
        public ICommand VoteDistressUsageNoCommand { get; private set; }
        public ICommand VoteDistressDirectionLeftCommand { get; private set; }
        public ICommand VoteDistressDirectionRightCommand { get; private set; }
        public ICommand ConfirmDistressCardSelectionCommand { get; private set; }
        public ICommand CancelDistressProposalCommand { get; private set; }

        public DistressSignalSnapshot DistressSignal => _snapshotProvider()?.DistressSignal;

        public bool HasUsedDistressSignal => DistressSignal?.HasUsedDistressSignal ?? false;

        public bool IsDistressSignalInProgress => DistressSignal?.IsInProgress ?? false;

        public DistressSignalPhase CurrentDistressStep =>
            DistressSignal?.CurrentStep ?? DistressSignalPhase.None;

        public bool IsLocalDistressUsageVoted
        {
            get
            {
                int[] voted = DistressSignal?.VotedYesUserIds;
                return voted != null && voted.Contains(_participantUserId);
            }
        }

        public bool IsLocalDistressDirectionVoted
        {
            get
            {
                int[] voted = DistressSignal?.DirectionVotedUserIds;
                return voted != null && voted.Contains(_participantUserId);
            }
        }

        public bool IsLocalDistressCardSubmitted
        {
            get
            {
                int[] submitted = DistressSignal?.SubmittedParticipantUserIds;
                return submitted != null && submitted.Contains(_participantUserId);
            }
        }

        public bool IsDistressInitiatorConfirmVisible =>
            IsDistressSignalDialogOpen &&
            (!IsDistressSignalInProgress || CurrentDistressStep == DistressSignalPhase.None);

        public bool IsDistressUsageVoteVisible =>
            IsDistressSignalDialogOpen &&
            CurrentDistressStep == DistressSignalPhase.VotingToUse &&
            !IsLocalDistressUsageVoted;

        public bool IsDistressDirectionVoteVisible =>
            IsDistressSignalDialogOpen &&
            CurrentDistressStep == DistressSignalPhase.VotingDirection &&
            !IsLocalDistressDirectionVoted;

        public bool IsDistressCardSelectionVisible =>
            IsDistressSignalDialogOpen &&
            CurrentDistressStep == DistressSignalPhase.SelectingCard &&
            !IsLocalDistressCardSubmitted;

        public bool IsDistressWaitingVisible =>
            IsDistressSignalDialogOpen && (
                (CurrentDistressStep == DistressSignalPhase.VotingToUse && IsLocalDistressUsageVoted) ||
                (CurrentDistressStep == DistressSignalPhase.VotingDirection && IsLocalDistressDirectionVoted) ||
                (CurrentDistressStep == DistressSignalPhase.SelectingCard && IsLocalDistressCardSubmitted));

        public string DistressInitiatorName
        {
            get
            {
                string initiatorName = string.Empty;
                int initiatorId = DistressSignal?.InitiatorUserId ?? 0;
                if (initiatorId != 0)
                {
                    LobbyPlayerItemViewModel matchedPlayer = _seatedPlayers?
                        .FirstOrDefault(player => player.IdUser == initiatorId);
                    initiatorName = matchedPlayer?.Username ?? _participantNameResolver(initiatorId);
                }
                return initiatorName;
            }
        }

        public int DistressUsageYesVotesCount => DistressSignal?.VotedYesUserIds?.Length ?? 0;

        public int DistressDirectionVotesCount => DistressSignal?.DirectionVotedUserIds?.Length ?? 0;

        public int DistressCardsSubmittedCount => DistressSignal?.SubmittedParticipantUserIds?.Length ?? 0;

        public int DistressTotalPlayersCount => _seatedPlayers?.Count ??
            (_snapshotProvider()?.ParticipantUserIds?.Length ?? 4);

        public string DistressWaitingProgressText
        {
            get
            {
                int currentCount = DistressCardsSubmittedCount;
                if (CurrentDistressStep == DistressSignalPhase.VotingToUse)
                {
                    currentCount = DistressUsageYesVotesCount;
                }
                else if (CurrentDistressStep == DistressSignalPhase.VotingDirection)
                {
                    currentCount = DistressDirectionVotesCount;
                }
                return $"{currentCount} / {DistressTotalPlayersCount}";
            }
        }

        public string DistressStepWaitingResourceKey
        {
            get
            {
                string resourceKey = "Match_Distress_WaitingVotes";
                if (CurrentDistressStep == DistressSignalPhase.VotingToUse)
                {
                    resourceKey = "Match_Distress_WaitingUsage";
                }
                else if (CurrentDistressStep == DistressSignalPhase.VotingDirection)
                {
                    resourceKey = "Match_Distress_WaitingDirection";
                }
                else if (CurrentDistressStep == DistressSignalPhase.SelectingCard)
                {
                    resourceKey = "Match_Distress_WaitingCards";
                }
                return resourceKey;
            }
        }

        public string DistressAgreedDirectionResourceKey =>
            DistressSignal?.AgreedDirection == DistressPassDirection.Right
                ? "Match_Distress_Direction_Right"
                : "Match_Distress_Direction_Left";

        public bool IsDistressSignalDialogOpen
        {
            get => _isDistressSignalDialogOpen;
            set
            {
                if (SetProperty(ref _isDistressSignalDialogOpen, value))
                {
                    NotifyDistressPhaseVisibilities();
                }
            }
        }

        public DistressPassDirection SelectedDistressDirection
        {
            get => _selectedDistressDirection;
            set => SetProperty(ref _selectedDistressDirection, value);
        }

        public int SelectedDistressCardId
        {
            get => _selectedDistressCardId;
            set
            {
                if (SetProperty(ref _selectedDistressCardId, value))
                {
                    OnPropertyChanged(nameof(CanConfirmDistressCard));
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        public bool CanConfirmDistressCard =>
            SelectedDistressCardId > 0 &&
            CurrentDistressStep == DistressSignalPhase.SelectingCard &&
            !IsLocalDistressCardSubmitted;

        public bool HasLocalPlayerCommunicated =>
            _snapshotProvider()?.RadioCommunications != null &&
            _snapshotProvider().RadioCommunications.Any(
                communication => communication.ParticipantUserId == _participantUserId);

        public bool HasAnyPlayerCommunicated =>
            _snapshotProvider()?.RadioCommunications != null &&
            _snapshotProvider().RadioCommunications.Length > 0;

        public bool CanUseDistressSignal
        {
            get
            {
                PlayerMatchSnapshot snapshot = _snapshotProvider();
                bool isContextReady = !_isDisposedProvider() && _isMatchConnectedProvider() &&
                    snapshot != null &&
                    !snapshot.IsDealCompleted &&
                    _isMissionPreparationCompleteProvider() &&
                    !_isMissionAttemptFinishedProvider();

                bool isTrickOne = snapshot != null &&
                    snapshot.CurrentTrickNumber <= 1 &&
                    (snapshot.CurrentTrickCardPlays == null ||
                     snapshot.CurrentTrickCardPlays.Length == 0);

                return isContextReady && isTrickOne && !HasUsedDistressSignal &&
                    !HasAnyPlayerCommunicated && !IsDistressSignalInProgress;
            }
        }

        private void InitializeDistressSignalCommands()
        {
            OpenDistressSignalDialogCommand = new RelayCommand(
                OpenDistressSignalDialog, CanOpenDistressSignalDialog);
            CloseDistressSignalDialogCommand = new AsyncRelayCommand(
                ExecuteCloseDistressSignalDialogAsync);
            SelectDistressCardCommand = new RelayCommand(SelectDistressCard);
            ProposeDistressSignalUsageCommand = new AsyncRelayCommand(
                ExecuteProposeDistressSignalUsageAsync, CanExecuteProposeDistressSignal);
            VoteDistressUsageYesCommand = new AsyncRelayCommand(
                ExecuteVoteDistressUsageYesAsync, CanExecuteVoteDistressUsage);
            VoteDistressUsageNoCommand = new AsyncRelayCommand(
                ExecuteVoteDistressUsageNoAsync, CanExecuteVoteDistressUsage);
            VoteDistressDirectionLeftCommand = new AsyncRelayCommand(
                ExecuteVoteDistressDirectionLeftAsync, CanExecuteVoteDistressDirection);
            VoteDistressDirectionRightCommand = new AsyncRelayCommand(
                ExecuteVoteDistressDirectionRightAsync, CanExecuteVoteDistressDirection);
            ConfirmDistressCardSelectionCommand = new AsyncRelayCommand(
                ExecuteConfirmDistressCardSelectionAsync, CanExecuteConfirmDistressCard);
            CancelDistressProposalCommand = new AsyncRelayCommand(
                ExecuteCancelDistressProposalAsync, CanExecuteCancelDistressProposal);
        }

        private bool CanOpenDistressSignalDialog(object parameter) => CanUseDistressSignal;

        private void OpenDistressSignalDialog(object parameter)
        {
            if (CanUseDistressSignal)
            {
                IsDistressSignalDialogOpen = true;
            }
        }

        private async Task ExecuteCloseDistressSignalDialogAsync(object parameter)
        {
            if (IsDistressSignalInProgress)
            {
                await ExecuteCancelDistressProposalAsync(null);
            }
            else
            {
                IsDistressSignalDialogOpen = false;
            }
        }

        private bool CanExecuteProposeDistressSignal(object parameter)
        {
            return _canSubmitMatchRequestProvider() && CanUseDistressSignal && !IsDistressSignalInProgress;
        }

        private async Task ExecuteProposeDistressSignalUsageAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.ProposeUsage, true);
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteVoteDistressUsage(object parameter)
        {
            return _canSubmitMatchRequestProvider() && IsDistressSignalInProgress &&
                CurrentDistressStep == DistressSignalPhase.VotingToUse && !IsLocalDistressUsageVoted;
        }

        private async Task ExecuteVoteDistressUsageYesAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.VoteUsage, true);
            await SendDistressSubmissionAsync(submission);
        }

        private async Task ExecuteVoteDistressUsageNoAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.VoteUsage, false);
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteVoteDistressDirection(object parameter)
        {
            return _canSubmitMatchRequestProvider() && IsDistressSignalInProgress &&
                CurrentDistressStep == DistressSignalPhase.VotingDirection && !IsLocalDistressDirectionVoted;
        }

        private async Task ExecuteVoteDistressDirectionLeftAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.VoteDirection, true);
            submission.SelectedDirection = DistressPassDirection.Left;
            await SendDistressSubmissionAsync(submission);
        }

        private async Task ExecuteVoteDistressDirectionRightAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.VoteDirection, true);
            submission.SelectedDirection = DistressPassDirection.Right;
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteConfirmDistressCard(object parameter)
        {
            return _canSubmitMatchRequestProvider() && CanConfirmDistressCard;
        }

        private async Task ExecuteConfirmDistressCardSelectionAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.SubmitPassCard, true);
            submission.CardIdToPass = SelectedDistressCardId;
            submission.SelectedDirection = DistressSignal?.AgreedDirection ?? DistressPassDirection.Left;
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteCancelDistressProposal(object parameter)
        {
            return _canSubmitMatchRequestProvider() && IsDistressSignalInProgress;
        }

        private async Task ExecuteCancelDistressProposalAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.CancelProposal, false);
            await SendDistressSubmissionAsync(submission);
        }

        private DistressSignalSubmission CreateDistressSubmission(
            DistressSignalActionType actionType, bool isVoteAccepted)
        {
            PlayerMatchSnapshot snapshot = _snapshotProvider();
            return new DistressSignalSubmission
            {
                MatchId = snapshot?.MatchId ?? Guid.Empty,
                LobbyCode = _lobbyCode,
                MissionAttemptId = snapshot?.MissionPreparation?.MissionAttemptId ?? 0,
                IsVoteAccepted = isVoteAccepted,
                ActionType = actionType
            };
        }

        private async Task<bool> SendDistressSubmissionAsync(DistressSignalSubmission submission)
        {
            bool isAccepted = false;
            if (_snapshotProvider() != null)
            {
                try
                {
                    DistressSignalConfirmation confirmation = await _matchClient.SubmitDistressSignalAsync(
                        submission, _participantUserId);
                    if (confirmation != null)
                    {
                        isAccepted = true;
                        await _synchronizeMatchAction();
                    }
                }
                catch (FaultException<DistressSignalFault> ex)
                {
                    _setFeedbackAction("Distress_Error_" + ex.Detail.FailureReason);
                    await _synchronizeMatchAction();
                }
            }
            return isAccepted;
        }

        private void SelectDistressCard(object parameter)
        {
            if (parameter is int cardId)
            {
                SelectedDistressCardId = cardId;
            }
        }

        private void PopulateEligibleDistressCards()
        {
            EligibleDistressCardIds.Clear();
            PlayerMatchSnapshot snapshot = _snapshotProvider();
            if (snapshot?.OwnHandCardIds != null)
            {
                foreach (int cardId in snapshot.OwnHandCardIds)
                {
                    Card card = DeckRules.GetCardById(cardId);
                    if (card.Suit != CardSuit.Special)
                    {
                        EligibleDistressCardIds.Add(cardId);
                    }
                }

                if (!EligibleDistressCardIds.Contains(SelectedDistressCardId))
                {
                    SelectedDistressCardId = EligibleDistressCardIds.FirstOrDefault();
                }
            }
        }

        public void ApplyDistressSignalState(PlayerMatchSnapshot playerSnapshot)
        {
            DistressSignalSnapshot distress = playerSnapshot.DistressSignal;
            if (distress != null && distress.IsInProgress)
            {
                SelectedDistressDirection = distress.AgreedDirection;
                if (distress.CurrentStep == DistressSignalPhase.SelectingCard)
                {
                    PopulateEligibleDistressCards();
                }
                IsDistressSignalDialogOpen = true;
            }
            else
            {
                if (IsDistressSignalDialogOpen && (!CanUseDistressSignal || HasUsedDistressSignal))
                {
                    IsDistressSignalDialogOpen = false;
                }
                if (distress != null && distress.HasBeenRejected && !_hasShownDistressRejectionNotice)
                {
                    _hasShownDistressRejectionNotice = true;
                    _setFeedbackAction("Match_Distress_RejectedNotice");
                }
            }
        }

        public void NotifyDistressPhaseVisibilities()
        {
            OnPropertyChanged(nameof(IsDistressInitiatorConfirmVisible));
            OnPropertyChanged(nameof(IsDistressUsageVoteVisible));
            OnPropertyChanged(nameof(IsDistressDirectionVoteVisible));
            OnPropertyChanged(nameof(IsDistressCardSelectionVisible));
            OnPropertyChanged(nameof(IsDistressWaitingVisible));
            OnPropertyChanged(nameof(DistressStepWaitingResourceKey));
            OnPropertyChanged(nameof(DistressAgreedDirectionResourceKey));
        }

        public void NotifyDistressProperties()
        {
            OnPropertyChanged(nameof(DistressSignal));
            OnPropertyChanged(nameof(HasUsedDistressSignal));
            OnPropertyChanged(nameof(IsDistressSignalInProgress));
            OnPropertyChanged(nameof(CurrentDistressStep));
            OnPropertyChanged(nameof(IsLocalDistressUsageVoted));
            OnPropertyChanged(nameof(IsLocalDistressDirectionVoted));
            OnPropertyChanged(nameof(IsLocalDistressCardSubmitted));
            OnPropertyChanged(nameof(DistressInitiatorName));
            OnPropertyChanged(nameof(DistressUsageYesVotesCount));
            OnPropertyChanged(nameof(DistressDirectionVotesCount));
            OnPropertyChanged(nameof(DistressCardsSubmittedCount));
            OnPropertyChanged(nameof(DistressTotalPlayersCount));
            OnPropertyChanged(nameof(DistressWaitingProgressText));
            OnPropertyChanged(nameof(DistressStepWaitingResourceKey));
            OnPropertyChanged(nameof(DistressAgreedDirectionResourceKey));
            NotifyDistressPhaseVisibilities();
            OnPropertyChanged(nameof(HasLocalPlayerCommunicated));
            OnPropertyChanged(nameof(HasAnyPlayerCommunicated));
            OnPropertyChanged(nameof(CanUseDistressSignal));
            OnPropertyChanged(nameof(CanConfirmDistressCard));
            CommandManager.InvalidateRequerySuggested();
        }
    }
}
