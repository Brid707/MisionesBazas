using System.Windows.Controls;
using View.Services;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for sending friend requests to other players.
    /// </summary>
    public partial class SendFriendRequestPage : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="SendFriendRequestPage"/> class.
        /// </summary>
        public SendFriendRequestPage()
        {
            InitializeComponent();

            INavigationService navigationService = new WpfNavigationService();
            IDialogService dialogService = new WpfDialogService();
            SendFriendRequestViewModel viewModel = new SendFriendRequestViewModel(navigationService, dialogService);
            DataContext = viewModel;
        }
    }
}
