using System.Windows.Input;
using TrickTakingMissions.Rules.Enums;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model for a single visible card in the local player's hand.
    /// </summary>
    public sealed class HandCardViewModel : ViewModelBase
    {
        private bool _isRaisedForCurrentTurn;
        private bool _isCommunicated;
        private bool _isEligibleForCommunication;
        private bool _isCommunicationModeActive;
        private RadioTokenPosition _tokenPosition;

        public HandCardViewModel(int cardId, ICommand playCardCommand, bool isPlayableByRules = true)
        {
            CardId = cardId;
            IsPlayableByRules = isPlayableByRules;
            PlayCardCommand = playCardCommand;
        }

        public int CardId { get; }

        public bool IsPlayableByRules { get; }

        public bool IsRaisedForCurrentTurn
        {
            get => _isRaisedForCurrentTurn;
            private set => SetProperty(ref _isRaisedForCurrentTurn, value);
        }

        public bool IsCommunicated
        {
            get => _isCommunicated;
            set => SetProperty(ref _isCommunicated, value);
        }

        public RadioTokenPosition TokenPosition
        {
            get => _tokenPosition;
            set => SetProperty(ref _tokenPosition, value);
        }

        public bool IsEligibleForCommunication
        {
            get => _isEligibleForCommunication;
            private set
            {
                if (SetProperty(ref _isEligibleForCommunication, value))
                {
                    OnPropertyChanged(nameof(IsHighlightedForCommunication));
                    OnPropertyChanged(nameof(IsDimmedForCommunication));
                }
            }
        }

        public bool IsCommunicationModeActive
        {
            get => _isCommunicationModeActive;
            private set
            {
                if (SetProperty(ref _isCommunicationModeActive, value))
                {
                    OnPropertyChanged(nameof(IsHighlightedForCommunication));
                    OnPropertyChanged(nameof(IsDimmedForCommunication));
                }
            }
        }

        public bool IsHighlightedForCommunication => _isCommunicationModeActive && _isEligibleForCommunication;

        public bool IsDimmedForCommunication => _isCommunicationModeActive && !_isEligibleForCommunication;

        public ICommand PlayCardCommand { get; }

        public void UpdateTurnAvailability(bool canRaiseForCurrentTurn)
        {
            IsRaisedForCurrentTurn = IsPlayableByRules && canRaiseForCurrentTurn;
        }

        public void UpdateCommunicationHighlight(bool isCommunicationModeActive, bool isEligible)
        {
            _isCommunicationModeActive = isCommunicationModeActive;
            _isEligibleForCommunication = isEligible;
            OnPropertyChanged(nameof(IsCommunicationModeActive));
            OnPropertyChanged(nameof(IsEligibleForCommunication));
            OnPropertyChanged(nameof(IsHighlightedForCommunication));
            OnPropertyChanged(nameof(IsDimmedForCommunication));
        }
    }
}
