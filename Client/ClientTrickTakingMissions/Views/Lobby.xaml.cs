using System.Windows.Controls;

using Model.Session;
using View.Services;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the game match lobby view.
    /// </summary>
    public partial class Lobby : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="Lobby"/> class.
        /// </summary>
        public Lobby()
        {
            InitializeComponent();

            INavigationService navigationService = new WpfNavigationService();
            LobbyViewModel viewModel = new LobbyViewModel(navigationService, LobbySession.Current,
                new ChatModerationPresenter());
            DataContext = viewModel;
            Unloaded += OnLobbyUnloaded;
        }
        private void OnLobbyUnloaded(object sender, System.Windows.RoutedEventArgs e)
        {
            (DataContext as System.IDisposable)?.Dispose();
        }
    }
}
