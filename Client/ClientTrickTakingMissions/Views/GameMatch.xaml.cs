using System.Windows.Controls;
using Model.Session;
using View.Services;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the game match board view.
    /// </summary>
    public partial class GameMatch : Page
    {
        public GameMatch()
        {
            InitializeComponent();

            INavigationService navigationService = new WpfNavigationService();
            var viewModel = new GameMatchViewModel(navigationService, LobbySession.Current);
            Loaded += (_, __) =>
                viewModel.ConfigureProfileImages(((App)System.Windows.Application.Current).ProfileImages);
            DataContext = viewModel;
            Unloaded += (_, __) => viewModel.Dispose();
        }
    }
}
