using System.Windows.Input;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>Identifies one visible hand card without containing another participant hand.</summary>
    public sealed class HandCardViewModel : ViewModelBase
    {
        private bool _isRaisedForCurrentTurn;

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

        public ICommand PlayCardCommand { get; }

        public void UpdateTurnAvailability(bool canRaiseForCurrentTurn)
        {
            IsRaisedForCurrentTurn = IsPlayableByRules && canRaiseForCurrentTurn;
        }
    }
}
