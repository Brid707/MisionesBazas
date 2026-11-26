using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.GameServices;
using Model.Services;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchRadioCommunicationViewModel : ViewModelBase
    {
        private static readonly IReadOnlyDictionary<RadioTokenPosition, RadioCommunicationMarker>
            RadioMarkersByPosition = new Dictionary<RadioTokenPosition, RadioCommunicationMarker>
            {
                { RadioTokenPosition.Highest, RadioCommunicationMarker.Highest },
                { RadioTokenPosition.Only, RadioCommunicationMarker.Only },
                { RadioTokenPosition.Lowest, RadioCommunicationMarker.Lowest },
                { RadioTokenPosition.Interference, RadioCommunicationMarker.Hidden }
            };

        private readonly string _lobbyCode;
        private readonly int _participantUserId;
        private readonly IMatchClient _matchClient;
        private readonly Func<PlayerMatchSnapshot> _snapshotProvider;
        private readonly Func<long> _matchStateVersionProvider;
        private readonly Func<bool> _canSubmitMatchRequestProvider;
        private readonly Func<bool> _isMatchInPlayableStateProvider;
        private readonly Func<bool> _isDistressSignalInProgressProvider;
        private readonly Func<bool> _isMissionAttemptFinishedProvider;
        private readonly Func<bool> _isMissionPreparationCompleteProvider;
        private readonly Func<bool> _hasLocalPlayerCommunicatedProvider;
        private readonly ObservableCollection<HandCardViewModel> _ownHandCards;
        private readonly List<LobbyPlayerItemViewModel> _seatedPlayers;
        private readonly Func<int, string> _participantNameResolver;
        private readonly Func<Task> _synchronizeMatchAction;
        private readonly Action _onFeedbackChanged;

        private RadioCommunicationSubmission _pendingRadioSubmission;
        private HandCardViewModel _selectedRadioCard;
        private RadioMarkerOptionViewModel _selectedRadioMarker;
        private bool _isCommunicationModeActive;

        public MatchRadioCommunicationViewModel(
            string lobbyCode,
            int participantUserId,
            IMatchClient matchClient,
            Func<PlayerMatchSnapshot> snapshotProvider,
            Func<long> matchStateVersionProvider,
            Func<bool> canSubmitMatchRequestProvider,
            Func<bool> isMatchInPlayableStateProvider,
            Func<bool> isDistressSignalInProgressProvider,
            Func<bool> isMissionAttemptFinishedProvider,
            Func<bool> isMissionPreparationCompleteProvider,
            Func<bool> hasLocalPlayerCommunicatedProvider,
            ObservableCollection<HandCardViewModel> ownHandCards,
            List<LobbyPlayerItemViewModel> seatedPlayers,
            Func<int, string> participantNameResolver,
            Func<Task> synchronizeMatchAction,
            Action onFeedbackChanged)
        {
            _lobbyCode = lobbyCode;
            _participantUserId = participantUserId;
            _matchClient = matchClient ?? throw new ArgumentNullException(nameof(matchClient));
            _snapshotProvider = snapshotProvider ?? throw new ArgumentNullException(nameof(snapshotProvider));
            _matchStateVersionProvider = matchStateVersionProvider ?? throw new ArgumentNullException(nameof(matchStateVersionProvider));
            _canSubmitMatchRequestProvider = canSubmitMatchRequestProvider ?? throw new ArgumentNullException(nameof(canSubmitMatchRequestProvider));
            _isMatchInPlayableStateProvider = isMatchInPlayableStateProvider ?? throw new ArgumentNullException(nameof(isMatchInPlayableStateProvider));
            _isDistressSignalInProgressProvider = isDistressSignalInProgressProvider ?? throw new ArgumentNullException(nameof(isDistressSignalInProgressProvider));
            _isMissionAttemptFinishedProvider = isMissionAttemptFinishedProvider ?? throw new ArgumentNullException(nameof(isMissionAttemptFinishedProvider));
            _isMissionPreparationCompleteProvider = isMissionPreparationCompleteProvider ?? throw new ArgumentNullException(nameof(isMissionPreparationCompleteProvider));
            _hasLocalPlayerCommunicatedProvider = hasLocalPlayerCommunicatedProvider ?? throw new ArgumentNullException(nameof(hasLocalPlayerCommunicatedProvider));
            _ownHandCards = ownHandCards ?? throw new ArgumentNullException(nameof(ownHandCards));
            _seatedPlayers = seatedPlayers ?? throw new ArgumentNullException(nameof(seatedPlayers));
            _participantNameResolver = participantNameResolver ?? throw new ArgumentNullException(nameof(participantNameResolver));
            _synchronizeMatchAction = synchronizeMatchAction ?? throw new ArgumentNullException(nameof(synchronizeMatchAction));
            _onFeedbackChanged = onFeedbackChanged ?? throw new ArgumentNullException(nameof(onFeedbackChanged));

            AvailableRadioMarkers = new ObservableCollection<RadioMarkerOptionViewModel>();
            RadioCommunications = new ObservableCollection<PlayerRadioCommunicationViewModel>();

            SubmitRadioCommunicationCommand = new AsyncRelayCommand(SubmitRadioCommunicationAsync, CanSubmitRadio);
            ToggleCommunicationModeCommand = new RelayCommand(ExecuteToggleCommunicationMode, CanToggleCommunicationMode);
        }

        public ObservableCollection<RadioMarkerOptionViewModel> AvailableRadioMarkers { get; }
        public ObservableCollection<PlayerRadioCommunicationViewModel> RadioCommunications { get; }
        public ICommand SubmitRadioCommunicationCommand { get; }
        public ICommand ToggleCommunicationModeCommand { get; }

        public bool HasPendingRadio => _pendingRadioSubmission != null;

        public bool IsCommunicationModeActive
        {
            get => _isCommunicationModeActive;
            set
            {
                if (SetProperty(ref _isCommunicationModeActive, value))
                {
                    RefreshCommunicationHighlights();
                    _onFeedbackChanged();
                }
            }
        }

        public HandCardViewModel SelectedRadioCard
        {
            get => _selectedRadioCard;
            set
            {
                if (SetProperty(ref _selectedRadioCard, value))
                {
                    RefreshRadioMarkerChoices();
                }
            }
        }

        public RadioMarkerOptionViewModel SelectedRadioMarker
        {
            get => _selectedRadioMarker;
            set => SetProperty(ref _selectedRadioMarker, value);
        }

        private bool IsTrickReadyForCommunication
        {
            get
            {
                MatchCardPlay[] plays = _snapshotProvider()?.CurrentTrickCardPlays;
                return plays == null || plays.Length == 0;
            }
        }

        private bool IsRadioAvailableByRules
        {
            get
            {
                bool isNotBlocked = !_isDistressSignalInProgressProvider() && !_isMissionAttemptFinishedProvider();
                bool isPreparationDone = _isMissionPreparationCompleteProvider();
                bool isRadioReady = _snapshotProvider()?.OwnRadioAvailability?.IsAvailable ?? true;
                return isNotBlocked && isPreparationDone && isRadioReady;
            }
        }

        public bool CanCommunicate =>
            _isMatchInPlayableStateProvider() &&
            IsRadioAvailableByRules &&
            IsTrickReadyForCommunication &&
            !_hasLocalPlayerCommunicatedProvider();

        public bool CanChooseRadioCard => CanCommunicate;

        private bool CanToggleCommunicationMode(object parameter) => CanCommunicate;

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

        public IReadOnlyList<RadioTokenPosition> GetValidPositionsForCard(int cardId)
        {
            IReadOnlyList<RadioTokenPosition> validPositions = Array.Empty<RadioTokenPosition>();
            PlayerMatchSnapshot snapshot = _snapshotProvider();
            if (snapshot?.OwnHandCardIds != null)
            {
                Card[] handCards = _ownHandCards.Select(card => DeckRules.GetCardById(card.CardId)).ToArray();
                Card candidateCard = DeckRules.GetCardById(cardId);
                CommunicationRuleType mode = snapshot.RadioMode == RadioCommunicationMode.Interference
                    ? CommunicationRuleType.Interference
                    : CommunicationRuleType.Standard;
                validPositions = RadioCommunicationRules.GetValidPositionsForCard(handCards, candidateCard, mode);
            }
            return validPositions;
        }

        public void RefreshCommunicationHighlights()
        {
            if (_ownHandCards != null)
            {
                foreach (HandCardViewModel handCard in _ownHandCards)
                {
                    bool isEligible = _isCommunicationModeActive &&
                        GetValidPositionsForCard(handCard.CardId).Count > 0;
                    handCard.UpdateCommunicationHighlight(_isCommunicationModeActive, isEligible);
                }
            }
        }

        public async Task ExecuteCardCommunicationFromHandAsync(int cardId)
        {
            if (_pendingRadioSubmission == null)
            {
                IReadOnlyList<RadioTokenPosition> positions = GetValidPositionsForCard(cardId);
                if (positions != null && positions.Count > 0)
                {
                    RadioTokenPosition resolvedPosition = positions[0];
                    IsCommunicationModeActive = false;
                    RadioCommunicationMarker marker = RadioMarkersByPosition[resolvedPosition];
                    PlayerMatchSnapshot snapshot = _snapshotProvider();
                    _pendingRadioSubmission = new RadioCommunicationSubmission
                    {
                        LobbyCode = _lobbyCode,
                        MatchId = snapshot.MatchId,
                        MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                        RadioCommunicationSubmissionId = Guid.NewGuid(),
                        ExpectedMatchStateVersion = _matchStateVersionProvider(),
                        CardId = cardId,
                        SelectedMarker = marker
                    };
                    await _synchronizeMatchAction();
                }
            }
        }

        private bool CanSubmitRadio()
        {
            return CanChooseRadioCard && SelectedRadioCard != null && SelectedRadioMarker != null &&
                _ownHandCards.Contains(SelectedRadioCard) && AvailableRadioMarkers.Contains(SelectedRadioMarker);
        }

        private async Task SubmitRadioCommunicationAsync()
        {
            if (CanSubmitRadio())
            {
                PlayerMatchSnapshot snapshot = _snapshotProvider();
                _pendingRadioSubmission = new RadioCommunicationSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = snapshot.MatchId,
                    MissionAttemptId = snapshot.MissionPreparation.MissionAttemptId,
                    RadioCommunicationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = _matchStateVersionProvider(),
                    CardId = SelectedRadioCard.CardId,
                    SelectedMarker = SelectedRadioMarker.Marker
                };
                await _synchronizeMatchAction();
            }
        }

        public async Task<string> ConfirmPendingRadioAsync()
        {
            string feedback = null;
            if (_pendingRadioSubmission != null)
            {
                try
                {
                    RadioCommunicationConfirmation confirmation = await _matchClient.SubmitRadioCommunicationAsync(
                        _pendingRadioSubmission, _participantUserId);
                    if (confirmation.RadioCommunicationSubmissionId !=
                        _pendingRadioSubmission.RadioCommunicationSubmissionId)
                    {
                        throw new FaultException<MatchAccessFault>(new MatchAccessFault
                        { FailureCode = nameof(RadioCommunicationFailureReason.OperationUnavailable) });
                    }
                    _pendingRadioSubmission = null;
                }
                catch (FaultException<RadioCommunicationFault> ex)
                {
                    feedback = "Radio_Error_" + ex.Detail.FailureReason;
                    if (ex.Detail.FailureReason != RadioCommunicationFailureReason.OperationUnavailable)
                    {
                        _pendingRadioSubmission = null;
                    }
                }
            }
            return feedback;
        }

        public void RefreshRadioMarkerChoices()
        {
            AvailableRadioMarkers.Clear();
            PlayerMatchSnapshot snapshot = _snapshotProvider();
            if (SelectedRadioCard != null && snapshot != null)
            {
                Card[] hand = _ownHandCards.Select(card => DeckRules.GetCardById(card.CardId)).ToArray();
                CommunicationRuleType mode = snapshot.RadioMode == RadioCommunicationMode.Interference
                    ? CommunicationRuleType.Interference
                    : CommunicationRuleType.Standard;
                foreach (RadioTokenPosition position in RadioCommunicationRules.GetValidPositionsForCard(hand,
                    DeckRules.GetCardById(SelectedRadioCard.CardId), mode))
                {
                    AvailableRadioMarkers.Add(new RadioMarkerOptionViewModel(RadioMarkersByPosition[position]));
                }
            }
            SelectedRadioMarker = AvailableRadioMarkers.FirstOrDefault();
        }

        public void ApplyRadioSnapshot(PlayerMatchSnapshot snapshot)
        {
            RadioCommunications.Clear();
            foreach (PlayerRadioCommunicationSnapshot communication in snapshot.RadioCommunications ??
                Array.Empty<PlayerRadioCommunicationSnapshot>())
            {
                RadioCommunications.Add(new PlayerRadioCommunicationViewModel(communication,
                    _participantNameResolver(communication.ParticipantUserId)));
            }
            if (SelectedRadioCard != null && !_ownHandCards.Contains(SelectedRadioCard))
            {
                SelectedRadioCard = null;
            }
            RefreshRadioMarkerChoices();

            PlayerRadioCommunicationSnapshot localCommunication = snapshot.RadioCommunications?
                .FirstOrDefault(communication => communication.ParticipantUserId == _participantUserId);

            foreach (HandCardViewModel handCard in _ownHandCards)
            {
                bool isCommunicated = localCommunication != null &&
                    !localCommunication.HasCommunicatedCardBeenPlayed &&
                    localCommunication.CommunicatedCardId == handCard.CardId;
                handCard.IsCommunicated = isCommunicated;
                handCard.TokenPosition = isCommunicated
                    ? MapMarkerToPosition(localCommunication.Marker)
                    : RadioTokenPosition.Highest;
            }

            UpdateSeatedPlayerCommunications(snapshot);

            if (!CanCommunicate && IsCommunicationModeActive)
            {
                IsCommunicationModeActive = false;
            }
            RefreshCommunicationHighlights();

            OnPropertyChanged(nameof(CanChooseRadioCard));
            OnPropertyChanged(nameof(CanCommunicate));
            OnPropertyChanged(nameof(IsCommunicationModeActive));
            (ToggleCommunicationModeCommand as RelayCommand)?.RaiseCanExecuteChanged();
        }

        private static RadioTokenPosition MapMarkerToPosition(RadioCommunicationMarker marker)
        {
            return marker switch
            {
                RadioCommunicationMarker.Highest => RadioTokenPosition.Highest,
                RadioCommunicationMarker.Only => RadioTokenPosition.Only,
                RadioCommunicationMarker.Lowest => RadioTokenPosition.Lowest,
                RadioCommunicationMarker.Hidden => RadioTokenPosition.Interference,
                _ => RadioTokenPosition.Highest
            };
        }

        private void UpdateSeatedPlayerCommunications(PlayerMatchSnapshot playerSnapshot)
        {
            if (_seatedPlayers != null)
            {
                foreach (LobbyPlayerItemViewModel participant in _seatedPlayers)
                {
                    PlayerRadioCommunicationSnapshot communication = playerSnapshot.RadioCommunications?
                        .FirstOrDefault(item => item.ParticipantUserId == participant.IdUser);

                    if (communication != null && !communication.HasCommunicatedCardBeenPlayed &&
                        communication.CommunicatedCardId > 0)
                    {
                        participant.UpdateCommunicatedCard(
                            communication.CommunicatedCardId, MapMarkerToPosition(communication.Marker));
                    }
                    else
                    {
                        participant.UpdateCommunicatedCard(null, RadioTokenPosition.Highest);
                    }
                }
            }
        }
    }
}
