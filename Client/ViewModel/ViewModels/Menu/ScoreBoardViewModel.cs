using System;
using System.Collections.ObjectModel;
using System.Windows.Input;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Represents a single player entry in the leaderboard ranking.
    /// </summary>
    public sealed class UserRankingItem
    {
        /// <summary>
        /// Gets or sets the ranking position.
        /// </summary>
        public int Position { get; set; }

        /// <summary>
        /// Gets or sets the display username of the player.
        /// </summary>
        public string Username { get; set; }

        /// <summary>
        /// Gets or sets the total accumulated experience points.
        /// </summary>
        public int TotalXP { get; set; }
    }

    /// <summary>
    /// ViewModel for managing leaderboard ranking display and statistics.
    /// </summary>
    public sealed class ScoreBoardViewModel : ViewModelBase
    {
        /// <summary>
        /// Occurs when the scoreboard requests to close.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="ScoreBoardViewModel"/> class.
        /// </summary>
        public ScoreBoardViewModel()
        {
            Rankings = new ObservableCollection<UserRankingItem>();

            CloseCommand = new RelayCommand(ExecuteClose);

            LoadSampleRankings();
        }

        /// <summary>
        /// Gets the collection of ranked players to display in the leaderboard.
        /// </summary>
        public ObservableCollection<UserRankingItem> Rankings { get; }

        /// <summary>
        /// Gets the command that dismisses the scoreboard dialog.
        /// </summary>
        public ICommand CloseCommand { get; }

        private void LoadSampleRankings()
        {
            // TODO: Retrieve global user rankings from backend service.
            Rankings.Add(new UserRankingItem { Position = 1, Username = "ChampionPlayer", TotalXP = 5200 });
            Rankings.Add(new UserRankingItem { Position = 2, Username = "AceCardMaster", TotalXP = 4350 });
            Rankings.Add(new UserRankingItem { Position = 3, Username = "TrickWinner", TotalXP = 3100 });
        }

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }
    }
}
