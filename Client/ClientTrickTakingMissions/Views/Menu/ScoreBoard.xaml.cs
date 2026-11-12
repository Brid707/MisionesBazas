using System.Windows;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for displaying leaderboard and user experience rankings following the MVVM pattern.
    /// </summary>
    public partial class ScoreBoard : Window
    {
        private readonly ScoreBoardViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="ScoreBoard"/> class with default ViewModel.
        /// </summary>
        public ScoreBoard()
            : this(new ScoreBoardViewModel())
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ScoreBoard"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this dialog.</param>
        public ScoreBoard(ScoreBoardViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;

            if (_viewModel != null)
            {
                _viewModel.RequestClose += () => this.Close();
            }
        }
    }
}
