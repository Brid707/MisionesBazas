using System.Windows;
using Model.Session;
using View.Services;
using ViewModel.Services;
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

            IDialogService dialogService = new WpfDialogService();
            ManageFriendRequestViewModel viewModel = new ManageFriendRequestViewModel(
                FriendshipSession.Current,
                dialogService);
            viewModel.RequestClose += OnRequestClose;
            DataContext = viewModel;
        }

        private void OnRequestClose()
        {
            Close();
        }
    }
}
