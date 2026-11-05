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
            DataContext = new GameMatchViewModel(navigationService, LobbySession.Current);
        }
    }
}
