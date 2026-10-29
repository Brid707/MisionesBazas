using System.Windows.Controls;
using Model.Session;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the primary game menu view following the MVVM pattern.
    /// </summary>
    public partial class GameMenu : Page
    {
        private readonly GameMenuViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="GameMenu"/> class with default UI services.
        /// </summary>
        public GameMenu()
            : this(new GameMenuViewModel(new WpfNavigationService(), LobbySession.Current))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="GameMenu"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public GameMenu(GameMenuViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;
        }
    }
}
