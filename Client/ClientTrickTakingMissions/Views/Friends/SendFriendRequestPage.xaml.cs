using System.Windows.Controls;
using Model.Session;
using View.Services;
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

            SendFriendRequestViewModel viewModel = new SendFriendRequestViewModel(
                ClientLoggingRuntime.CreateUiServices<SendFriendRequestViewModel>(),
                FriendshipSession.Current);
            DataContext = viewModel;
        }
    }
}
