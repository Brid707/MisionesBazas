using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private bool _isCommunicationModeActive;
        private bool _isDistressSignalDialogOpen;
        private PassDirection _selectedDistressDirection = PassDirection.Left;
        private int _selectedDistressCardId;
        private bool _hasShownDistressRejectionNotice;

        public ObservableCollection<PlayerRadioCommunicationSnapshot> RadioCommunications { get; } =
            new ObservableCollection<PlayerRadioCommunicationSnapshot>();

        public ObservableCollection<int> EligibleDistressCardIds { get; } =
            new ObservableCollection<int>();

        public ICommand CommunicateCardCommand { get; private set; }
        public ICommand ToggleCommunicationModeCommand { get; private set; }
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

        public DistressSignalSnapshot DistressSignal => _confirmedMatchSnapshot?.DistressSignal;

        public bool HasUsedDistressSignal => DistressSignal?.HasUsedDistressSignal ?? false;

        public bool IsDistressSignalInProgress => DistressSignal?.IsInProgress ?? false;

        public DistressSignalStep CurrentDistressStep =>
            DistressSignal?.CurrentStep ?? DistressSignalStep.None;

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
            (!IsDistressSignalInProgress || CurrentDistressStep == DistressSignalStep.None);

        public bool IsDistressUsageVoteVisible =>
            IsDistressSignalDialogOpen &&
            CurrentDistressStep == DistressSignalStep.VotingToUse &&
            !IsLocalDistressUsageVoted;

        public bool IsDistressDirectionVoteVisible =>
            IsDistressSignalDialogOpen &&
            CurrentDistressStep == DistressSignalStep.VotingDirection &&
            !IsLocalDistressDirectionVoted;

        public bool IsDistressCardSelectionVisible =>
            IsDistressSignalDialogOpen &&
            CurrentDistressStep == DistressSignalStep.SelectingCard &&
            !IsLocalDistressCardSubmitted;

        public bool IsDistressWaitingVisible =>
            IsDistressSignalDialogOpen && (
                (CurrentDistressStep == DistressSignalStep.VotingToUse && IsLocalDistressUsageVoted) ||
                (CurrentDistressStep == DistressSignalStep.VotingDirection && IsLocalDistressDirectionVoted) ||
                (CurrentDistressStep == DistressSignalStep.SelectingCard && IsLocalDistressCardSubmitted));

        public string DistressInitiatorName
        {
            get
            {
                int initiatorId = DistressSignal?.InitiatorUserId ?? 0;
                if (initiatorId == 0)
                {
                    return string.Empty;
                }
                LobbyPlayerItemViewModel player = _seatedPlayers?
                    .FirstOrDefault(p => p.IdUser == initiatorId);
                return player?.Username ?? GetParticipantName(initiatorId);
            }
        }

        public int DistressUsageYesVotesCount => DistressSignal?.VotedYesUserIds?.Length ?? 0;

        public int DistressDirectionVotesCount => DistressSignal?.DirectionVotedUserIds?.Length ?? 0;

        public int DistressCardsSubmittedCount => DistressSignal?.SubmittedParticipantUserIds?.Length ?? 0;

        public int DistressTotalPlayersCount => _seatedPlayers?.Count ??
            (_confirmedMatchSnapshot?.ParticipantUserIds?.Length ?? 4);

        public string DistressWaitingProgressText
        {
            get
            {
                if (CurrentDistressStep == DistressSignalStep.VotingToUse)
                {
                    return $"{DistressUsageYesVotesCount} / {DistressTotalPlayersCount}";
                }
                if (CurrentDistressStep == DistressSignalStep.VotingDirection)
                {
                    return $"{DistressDirectionVotesCount} / {DistressTotalPlayersCount}";
                }
                if (CurrentDistressStep == DistressSignalStep.SelectingCard)
                {
                    return $"{DistressCardsSubmittedCount} / {DistressTotalPlayersCount}";
                }
                return $"{DistressCardsSubmittedCount} / {DistressTotalPlayersCount}";
            }
        }

        public string DistressStepWaitingResourceKey
        {
            get
            {
                if (CurrentDistressStep == DistressSignalStep.VotingToUse)
                {
                    return "Match_Distress_WaitingUsage";
                }
                if (CurrentDistressStep == DistressSignalStep.VotingDirection)
                {
                    return "Match_Distress_WaitingDirection";
                }
                if (CurrentDistressStep == DistressSignalStep.SelectingCard)
                {
                    return "Match_Distress_WaitingCards";
                }
                return "Match_Distress_WaitingVotes";
            }
        }

        public string DistressAgreedDirectionResourceKey =>
            DistressSignal?.AgreedDirection == PassDirection.Right
                ? "Match_Distress_Direction_Right"
                : "Match_Distress_Direction_Left";

        public bool IsCommunicationModeActive
        {
            get => _isCommunicationModeActive;
            set
            {
                if (SetProperty(ref _isCommunicationModeActive, value))
                {
                    RefreshCommunicationHighlights();
                }
            }
        }

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

        public PassDirection SelectedDistressDirection
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
                }
            }
        }

        public bool CanConfirmDistressCard =>
            SelectedDistressCardId > 0 &&
            CurrentDistressStep == DistressSignalStep.SelectingCard &&
            !IsLocalDistressCardSubmitted;

        public bool HasLocalPlayerCommunicated
        {
            get
            {
                PlayerRadioCommunicationSnapshot localComm = _confirmedMatchSnapshot?.RadioCommunications?
                    .FirstOrDefault(comm => comm.PlayerUserId == _participantUserId);
                return localComm?.HasUsedCommunicationToken ?? false;
            }
        }

        public bool HasAnyPlayerCommunicated
        {
            get
            {
                if (_confirmedMatchSnapshot?.RadioCommunications == null)
                {
                    return false;
                }
                return _confirmedMatchSnapshot.RadioCommunications.Any(
                    comm => comm.HasUsedCommunicationToken);
            }
        }

        public bool CanCommunicate
        {
            get
            {
                bool isContextReady = !_isDisposed && _isMatchConnected &&
                    _confirmedMatchSnapshot != null &&
                    !_confirmedMatchSnapshot.IsDealCompleted &&
                    IsMissionPreparationComplete &&
                    !IsMissionAttemptFinished;

                bool isNoTrickActive = _confirmedMatchSnapshot?.CurrentTrickCardPlays == null ||
                    _confirmedMatchSnapshot.CurrentTrickCardPlays.Length == 0;

                return isContextReady && isNoTrickActive &&
                    !HasLocalPlayerCommunicated && !IsDistressSignalInProgress;
            }
        }

        public bool CanUseDistressSignal
        {
            get
            {
                bool isContextReady = !_isDisposed && _isMatchConnected &&
                    _confirmedMatchSnapshot != null &&
                    !_confirmedMatchSnapshot.IsDealCompleted &&
                    IsMissionPreparationComplete &&
                    !IsMissionAttemptFinished;

                bool isTrickOne = _confirmedMatchSnapshot != null &&
                    _confirmedMatchSnapshot.CurrentTrickNumber <= 1 &&
                    (_confirmedMatchSnapshot.CurrentTrickCardPlays == null ||
                     _confirmedMatchSnapshot.CurrentTrickCardPlays.Length == 0);

                return isContextReady && isTrickOne && !HasUsedDistressSignal &&
                    !HasAnyPlayerCommunicated && !IsDistressSignalInProgress;
            }
        }

        private void InitializeCommunicationAndDistressCommands()
        {
            CommunicateCardCommand = new AsyncRelayCommand(
                ExecuteCommunicateCardAsync, CanExecuteCommunicateCard);
            ToggleCommunicationModeCommand = new RelayCommand(
                ExecuteToggleCommunicationMode, CanToggleCommunicationMode);
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

        private bool CanToggleCommunicationMode(object parameter)
        {
            return CanCommunicate;
        }

        private void ExecuteToggleCommunicationMode(object parameter)
        {
            if (CanCommunicate)
            {
                IsCommunicationModeActive = !IsCommunicationModeActive;
            }
            else
            {
                IsCommunicationModeActive = false;
            }
        }

        public void RefreshCommunicationHighlights()
        {
            foreach (HandCardViewModel handCard in OwnHandCards)
            {
                bool isEligible = _isCommunicationModeActive &&
                    GetValidPositionsForCard(handCard.CardId).Count > 0;
                handCard.UpdateCommunicationHighlight(_isCommunicationModeActive, isEligible);
            }
        }

        private bool CanExecuteCommunicateCard(object parameter)
        {
            return CanSubmitMatchRequest() && CanCommunicate;
        }

        private async Task ExecuteCommunicateCardAsync(object parameter)
        {
            if (parameter is Tuple<int, RadioTokenPosition> cardAndPosition)
            {
                await CommunicateCardAsync(cardAndPosition.Item1, cardAndPosition.Item2);
            }
        }

        public async Task<bool> CommunicateCardAsync(int cardId, RadioTokenPosition position)
        {
            if (!CanCommunicate || _confirmedMatchSnapshot == null)
            {
                return false;
            }

            RadioCommunicationSubmission submission = new RadioCommunicationSubmission
            {
                MatchId = _confirmedMatchSnapshot.MatchId,
                LobbyCode = _lobbyCode,
                MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                CardId = cardId,
                SelectedPosition = position
            };

            RadioCommunicationDecision decision = await _matchClient.CommunicateCardAsync(
                submission, _participantUserId);

            if (decision != null && decision.IsAccepted)
            {
                await SynchronizeMatchAsync();
                return true;
            }

            return false;
        }

        public IReadOnlyList<RadioTokenPosition> GetValidPositionsForCard(int cardId)
        {
            if (_confirmedMatchSnapshot?.OwnHandCardIds == null)
            {
                return Array.Empty<RadioTokenPosition>();
            }

            List<Card> handCards = _confirmedMatchSnapshot.OwnHandCardIds
                .Select(DeckRules.GetCardById)
                .ToList();

            Card candidateCard = DeckRules.GetCardById(cardId);
            MissionDefinition missionDef = MissionCatalog.GetMission(
                _confirmedMatchSnapshot.MissionPreparation.MissionNumber);

            return RadioCommunicationRules.GetValidPositionsForCard(
                handCards, candidateCard, missionDef.CommunicationRule);
        }

        private bool CanOpenDistressSignalDialog(object parameter)
        {
            return CanUseDistressSignal;
        }

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
            return CanSubmitMatchRequest() && CanUseDistressSignal && !IsDistressSignalInProgress;
        }

        private async Task ExecuteProposeDistressSignalUsageAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.ProposeUsage, true);
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteVoteDistressUsage(object parameter)
        {
            return CanSubmitMatchRequest() && IsDistressSignalInProgress &&
                CurrentDistressStep == DistressSignalStep.VotingToUse && !IsLocalDistressUsageVoted;
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
            return CanSubmitMatchRequest() && IsDistressSignalInProgress &&
                CurrentDistressStep == DistressSignalStep.VotingDirection && !IsLocalDistressDirectionVoted;
        }

        private async Task ExecuteVoteDistressDirectionLeftAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.VoteDirection, true);
            submission.SelectedDirection = PassDirection.Left;
            await SendDistressSubmissionAsync(submission);
        }

        private async Task ExecuteVoteDistressDirectionRightAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.VoteDirection, true);
            submission.SelectedDirection = PassDirection.Right;
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteConfirmDistressCard(object parameter)
        {
            return CanSubmitMatchRequest() && CanConfirmDistressCard;
        }

        private async Task ExecuteConfirmDistressCardSelectionAsync(object parameter)
        {
            DistressSignalSubmission submission = CreateDistressSubmission(
                DistressSignalActionType.SubmitPassCard, true);
            submission.CardIdToPass = SelectedDistressCardId;
            submission.SelectedDirection = DistressSignal?.AgreedDirection ?? PassDirection.Left;
            await SendDistressSubmissionAsync(submission);
        }

        private bool CanExecuteCancelDistressProposal(object parameter)
        {
            return CanSubmitMatchRequest() && IsDistressSignalInProgress;
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
            return new DistressSignalSubmission
            {
                MatchId = _confirmedMatchSnapshot?.MatchId ?? Guid.Empty,
                LobbyCode = _lobbyCode,
                MissionAttemptId = _confirmedMatchSnapshot?.MissionPreparation?.MissionAttemptId ?? 0,
                IsVoteAccepted = isVoteAccepted,
                ActionType = actionType
            };
        }

        private async Task<bool> SendDistressSubmissionAsync(DistressSignalSubmission submission)
        {
            if (_confirmedMatchSnapshot == null)
            {
                return false;
            }

            DistressSignalDecision decision = await _matchClient.SubmitDistressSignalAsync(
                submission, _participantUserId);

            if (decision != null && decision.IsAccepted)
            {
                await SynchronizeMatchAsync();
                return true;
            }

            return false;
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
            if (_confirmedMatchSnapshot?.OwnHandCardIds != null)
            {
                foreach (int cardId in _confirmedMatchSnapshot.OwnHandCardIds)
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

        private void ApplyRadioCommunicationsAndDistress(PlayerMatchSnapshot playerSnapshot)
        {
            RadioCommunications.Clear();
            if (playerSnapshot.RadioCommunications != null)
            {
                foreach (PlayerRadioCommunicationSnapshot comm in playerSnapshot.RadioCommunications)
                {
                    RadioCommunications.Add(comm);
                }
            }

            PlayerRadioCommunicationSnapshot localComm = playerSnapshot.RadioCommunications?
                .FirstOrDefault(comm => comm.PlayerUserId == _participantUserId);

            foreach (HandCardViewModel handCard in OwnHandCards)
            {
                bool isComm = localComm != null && localComm.CommunicatedCardId.HasValue &&
                    localComm.CommunicatedCardId.Value == handCard.CardId;
                handCard.IsCommunicated = isComm;
                handCard.TokenPosition = isComm ? localComm.TokenPosition : RadioTokenPosition.Highest;
            }

            UpdateSeatedPlayerCommunications(playerSnapshot);

            if (!CanCommunicate && IsCommunicationModeActive)
            {
                IsCommunicationModeActive = false;
            }

            ApplyDistressSignalState(playerSnapshot);
            RefreshCommunicationHighlights();
            NotifyCommunicationAndDistressProperties();
        }

        private void ApplyDistressSignalState(PlayerMatchSnapshot playerSnapshot)
        {
            DistressSignalSnapshot distress = playerSnapshot.DistressSignal;
            if (distress != null && distress.IsInProgress)
            {
                SelectedDistressDirection = distress.AgreedDirection;
                if (distress.CurrentStep == DistressSignalStep.SelectingCard)
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
                    MatchFeedbackResourceKey = "Match_Distress_RejectedNotice";
                }
            }
        }

        private void UpdateSeatedPlayerCommunications(PlayerMatchSnapshot playerSnapshot)
        {
            foreach (LobbyPlayerItemViewModel participant in _seatedPlayers)
            {
                PlayerRadioCommunicationSnapshot comm = playerSnapshot.RadioCommunications?
                    .FirstOrDefault(c => c.PlayerUserId == participant.IdUser);

                if (comm != null && comm.HasUsedCommunicationToken && comm.CommunicatedCardId.HasValue)
                {
                    participant.UpdateCommunicatedCard(comm.CommunicatedCardId, comm.TokenPosition);
                }
                else
                {
                    participant.UpdateCommunicatedCard(null, RadioTokenPosition.Highest);
                }
            }
        }

        private void NotifyDistressPhaseVisibilities()
        {
            OnPropertyChanged(nameof(IsDistressInitiatorConfirmVisible));
            OnPropertyChanged(nameof(IsDistressUsageVoteVisible));
            OnPropertyChanged(nameof(IsDistressDirectionVoteVisible));
            OnPropertyChanged(nameof(IsDistressCardSelectionVisible));
            OnPropertyChanged(nameof(IsDistressWaitingVisible));
            OnPropertyChanged(nameof(DistressStepWaitingResourceKey));
            OnPropertyChanged(nameof(DistressAgreedDirectionResourceKey));
        }

        private void NotifyCommunicationAndDistressProperties()
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
            OnPropertyChanged(nameof(CanCommunicate));
            OnPropertyChanged(nameof(CanUseDistressSignal));
            OnPropertyChanged(nameof(CanConfirmDistressCard));
        }
    }
}
