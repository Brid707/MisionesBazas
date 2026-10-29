using System.Windows.Controls;
using View.Services;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for sending friend requests to other players.
    /// </summary>
    public partial class SendFriendRequest : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="SendFriendRequest"/> class.
        /// </summary>
        public SendFriendRequest()
        {
            InitializeComponent();

            INavigationService navigationService = new WpfNavigationService();
            IDialogService dialogService = new WpfDialogService();
            SendFriendRequestViewModel viewModel = new SendFriendRequestViewModel(navigationService, dialogService);
            DataContext = viewModel;
        }
    }
}
