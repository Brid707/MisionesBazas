using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
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
        private static readonly IReadOnlyDictionary<RadioTokenPosition, RadioCommunicationMarker>
            RadioMarkersByPosition = new Dictionary<RadioTokenPosition, RadioCommunicationMarker>
            {
                { RadioTokenPosition.Highest, RadioCommunicationMarker.Highest },
                { RadioTokenPosition.Only, RadioCommunicationMarker.Only },
                { RadioTokenPosition.Lowest, RadioCommunicationMarker.Lowest },
                { RadioTokenPosition.Interference, RadioCommunicationMarker.Hidden }
            };

        private RadioCommunicationSubmission _pendingRadioSubmission;
        private HandCardViewModel _selectedRadioCard;
        private RadioMarkerOptionViewModel _selectedRadioMarker;
        private bool _isCommunicationModeActive;

        public ObservableCollection<RadioMarkerOptionViewModel> AvailableRadioMarkers { get; } =
            new ObservableCollection<RadioMarkerOptionViewModel>();
        public ObservableCollection<PlayerRadioCommunicationViewModel> RadioCommunications { get; } =
            new ObservableCollection<PlayerRadioCommunicationViewModel>();
        public ICommand SubmitRadioCommunicationCommand { get; private set; }
        public ICommand ToggleCommunicationModeCommand { get; private set; }

        public bool IsCommunicationModeActive
        {
            get => _isCommunicationModeActive;
            set
            {
                if (SetProperty(ref _isCommunicationModeActive, value))
                {
                    RefreshCommunicationHighlights();
                    MatchFeedbackResourceKey = GetCurrentMatchFeedback();
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
                MatchCardPlay[] plays = _confirmedMatchSnapshot?.CurrentTrickCardPlays;
                return plays == null || plays.Length == 0;
            }
        }

        private bool IsRadioAvailableByRules
        {
            get
            {
                bool isNotBlocked = !IsDistressSignalInProgress && !IsMissionAttemptFinished;
                bool isPreparationDone = IsMissionPreparationComplete;
                bool isRadioReady = _confirmedMatchSnapshot?.OwnRadioAvailability?.IsAvailable ?? true;
                return isNotBlocked && isPreparationDone && isRadioReady;
            }
        }

        public bool CanCommunicate =>
            IsMatchInPlayableState &&
            IsRadioAvailableByRules &&
            IsTrickReadyForCommunication &&
            !HasLocalPlayerCommunicated;

        public bool CanChooseRadioCard => CanCommunicate;

        private void InitializeRadioCommand()
        {
            SubmitRadioCommunicationCommand = new AsyncRelayCommand(SubmitRadioCommunicationAsync, CanSubmitRadio);
            ToggleCommunicationModeCommand = new RelayCommand(
                ExecuteToggleCommunicationMode, CanToggleCommunicationMode);
        }

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
            if (_confirmedMatchSnapshot?.OwnHandCardIds != null)
            {
                Card[] handCards = OwnHandCards.Select(card => DeckRules.GetCardById(card.CardId)).ToArray();
                Card candidateCard = DeckRules.GetCardById(cardId);
                CommunicationRuleType mode = _confirmedMatchSnapshot.RadioMode == RadioCommunicationMode.Interference
                    ? CommunicationRuleType.Interference
                    : CommunicationRuleType.Standard;
                validPositions = RadioCommunicationRules.GetValidPositionsForCard(handCards, candidateCard, mode);
            }
            return validPositions;
        }

        public void RefreshCommunicationHighlights()
        {
            if (OwnHandCards != null)
            {
                foreach (HandCardViewModel handCard in OwnHandCards)
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
                    _pendingRadioSubmission = new RadioCommunicationSubmission
                    {
                        LobbyCode = _lobbyCode,
                        MatchId = _confirmedMatchSnapshot.MatchId,
                        MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                        RadioCommunicationSubmissionId = Guid.NewGuid(),
                        ExpectedMatchStateVersion = MatchStateVersion,
                        CardId = cardId,
                        SelectedMarker = marker
                    };
                    await SynchronizeMatchAsync();
                }
            }
        }

        private bool CanSubmitRadio()
        {
            return CanChooseRadioCard && SelectedRadioCard != null && SelectedRadioMarker != null &&
                OwnHandCards.Contains(SelectedRadioCard) && AvailableRadioMarkers.Contains(SelectedRadioMarker);
        }

        private async Task SubmitRadioCommunicationAsync()
        {
            if (CanSubmitRadio())
            {
                _pendingRadioSubmission = new RadioCommunicationSubmission
                {
                    LobbyCode = _lobbyCode,
                    MatchId = _confirmedMatchSnapshot.MatchId,
                    MissionAttemptId = _confirmedMatchSnapshot.MissionPreparation.MissionAttemptId,
                    RadioCommunicationSubmissionId = Guid.NewGuid(),
                    ExpectedMatchStateVersion = MatchStateVersion,
                    CardId = SelectedRadioCard.CardId,
                    SelectedMarker = SelectedRadioMarker.Marker
                };
                await SynchronizeMatchAsync();
            }
        }

        private async Task<string> ConfirmPendingRadioAsync()
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

        private void RefreshRadioMarkerChoices()
        {
            AvailableRadioMarkers.Clear();
            if (SelectedRadioCard != null && _confirmedMatchSnapshot != null)
            {
                Card[] hand = OwnHandCards.Select(card => DeckRules.GetCardById(card.CardId)).ToArray();
                CommunicationRuleType mode = _confirmedMatchSnapshot.RadioMode == RadioCommunicationMode.Interference
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

        private void ApplyRadioSnapshot(PlayerMatchSnapshot snapshot)
        {
            RadioCommunications.Clear();
            foreach (PlayerRadioCommunicationSnapshot communication in snapshot.RadioCommunications ??
                Array.Empty<PlayerRadioCommunicationSnapshot>())
            {
                RadioCommunications.Add(new PlayerRadioCommunicationViewModel(communication,
                    GetParticipantName(communication.ParticipantUserId)));
            }
            if (SelectedRadioCard != null && !OwnHandCards.Contains(SelectedRadioCard))
            {
                SelectedRadioCard = null;
            }
            RefreshRadioMarkerChoices();

            PlayerRadioCommunicationSnapshot localCommunication = snapshot.RadioCommunications?
                .FirstOrDefault(communication => communication.ParticipantUserId == _participantUserId);

            foreach (HandCardViewModel handCard in OwnHandCards)
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
