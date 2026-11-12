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
            var viewModel = new GameMatchViewModel(
                navigationService,
                LobbySession.Current,
                ClientLoggingRuntime.CreateLogger<GameMatchViewModel>());
            DataContext = viewModel;
            Loaded += OnGameMatchLoaded;
            Unloaded += OnGameMatchUnloaded;
        }
        private void OnGameMatchLoaded(object sender, System.Windows.RoutedEventArgs e)
        {
            var viewModel = (GameMatchViewModel)DataContext;
            viewModel.ConfigureProfileImages(((App)System.Windows.Application.Current).ProfileImages);
            viewModel.ConfigureMatch(LobbySession.Current.Client);
        }

        private void OnGameMatchUnloaded(object sender, System.Windows.RoutedEventArgs e)
        {
            ((GameMatchViewModel)DataContext).Dispose();
        }
    }
}
