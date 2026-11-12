using ViewModel.Constants;

namespace ViewModel.ViewModels
{
    /// <summary>Associates a public played card with the participant name shown at the table.</summary>
    public sealed class PlayedCardViewModel
    {
        public PlayedCardViewModel(int cardId, string playerUsername,
            MatchTablePosition tablePosition = MatchTablePosition.Local)
        {
            CardId = cardId;
            TablePosition = tablePosition;
            PlayerUsername = playerUsername;
        }

        public MatchTablePosition TablePosition { get; }
        public int CardId { get; }
        public string PlayerUsername { get; }
    }
}
