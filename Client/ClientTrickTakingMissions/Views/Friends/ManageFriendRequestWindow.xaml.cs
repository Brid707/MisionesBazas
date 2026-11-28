using System.Windows;
using Model.Session;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for managing pending and sent friend requests.
    /// </summary>
    public partial class ManageFriendRequestWindow : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequestWindow"/> class.
        /// </summary>
        public ManageFriendRequestWindow()
        {
            InitializeComponent();

            var viewModel = new ManageFriendRequestViewModel(FriendshipSession.Current,
                ClientLoggingRuntime.CreateUiServices<ManageFriendRequestViewModel>());
            viewModel.RequestClose += OnRequestClose;
            DataContext = viewModel;
        }

        private void OnRequestClose()
        {
            Close();
        }
    }
}
