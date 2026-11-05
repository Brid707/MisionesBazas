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
            viewModel.CurrentPlayerKicked += OnCurrentPlayerKicked;
            Unloaded += OnLobbyUnloaded;
        }
        private void OnPlayerActionsButtonClick(object sender, System.Windows.RoutedEventArgs e)
        {
            if (sender is Button playerActionsButton && playerActionsButton.ContextMenu != null)
            {
                playerActionsButton.ContextMenu.PlacementTarget = playerActionsButton;
                playerActionsButton.ContextMenu.IsOpen = true;
            }
        }

        private void OnCurrentPlayerKicked(object sender, System.EventArgs e)
        {
            System.Windows.MessageBox.Show(Properties.Langs.Resources.Lobby_KickedNotice,
                Properties.Langs.Resources.Lobby_PlayerActions,
                System.Windows.MessageBoxButton.OK);
        }

        private void OnLobbyUnloaded(object sender, System.Windows.RoutedEventArgs e)
        {
            if (DataContext is LobbyViewModel lobbyViewModel)
            {
                lobbyViewModel.CurrentPlayerKicked -= OnCurrentPlayerKicked;
                lobbyViewModel.Dispose();
            }
        }
    }
}
