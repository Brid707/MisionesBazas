using System.Windows.Controls;
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
            LobbyViewModel viewModel = new LobbyViewModel(navigationService);
            DataContext = viewModel;
        }
    }
}
