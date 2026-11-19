using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows.Input;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private RadioCommunicationSubmission _pendingRadioSubmission;
        private HandCardViewModel _selectedRadioCard;
        private RadioMarkerOptionViewModel _selectedRadioMarker;

        public ObservableCollection<RadioMarkerOptionViewModel> AvailableRadioMarkers { get; } =
            new ObservableCollection<RadioMarkerOptionViewModel>();
        public ObservableCollection<PlayerRadioCommunicationViewModel> RadioCommunications { get; } =
            new ObservableCollection<PlayerRadioCommunicationViewModel>();
        public ICommand SubmitRadioCommunicationCommand { get; private set; }

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

        public bool CanChooseRadioCard => CanSubmitMatchRequest() && IsMissionPreparationComplete &&
            !IsMissionAttemptFinished && (_confirmedMatchSnapshot?.OwnRadioAvailability?.IsAvailable ?? true) &&
            _confirmedMatchSnapshot?.CurrentTrickCardPlays?.Length == 0 &&
            !(_confirmedMatchSnapshot.RadioCommunications ?? Array.Empty<PlayerRadioCommunicationSnapshot>())
                .Any(communication => communication.ParticipantUserId == _participantUserId);

        private void InitializeRadioCommand()
        {
            SubmitRadioCommunicationCommand = new AsyncRelayCommand(SubmitRadioCommunicationAsync, CanSubmitRadio);
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
                var hand = OwnHandCards.Select(card => DeckRules.GetCardById(card.CardId)).ToArray();
                CommunicationRuleType mode = _confirmedMatchSnapshot.RadioMode == RadioCommunicationMode.Interference
                    ? CommunicationRuleType.Interference : CommunicationRuleType.Standard;
                foreach (RadioTokenPosition position in RadioCommunicationRules.GetValidPositionsForCard(hand,
                    DeckRules.GetCardById(SelectedRadioCard.CardId), mode))
                {
                    AvailableRadioMarkers.Add(new RadioMarkerOptionViewModel(s_radioMarkers[position]));
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
            OnPropertyChanged(nameof(CanChooseRadioCard));
        }

        private static readonly IReadOnlyDictionary<RadioTokenPosition, RadioCommunicationMarker> s_radioMarkers =
            new Dictionary<RadioTokenPosition, RadioCommunicationMarker>
            {
                { RadioTokenPosition.Highest, RadioCommunicationMarker.Highest },
                { RadioTokenPosition.Only, RadioCommunicationMarker.Only },
                { RadioTokenPosition.Lowest, RadioCommunicationMarker.Lowest },
                { RadioTokenPosition.Interference, RadioCommunicationMarker.Hidden }
            };
    }
}
