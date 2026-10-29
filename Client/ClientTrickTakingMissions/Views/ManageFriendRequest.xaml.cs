using System.Windows;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for managing pending and sent friend requests.
    /// </summary>
    public partial class ManageFriendRequest : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequest"/> class.
        /// </summary>
        public ManageFriendRequest()
        {
            InitializeComponent();

            ManageFriendRequestViewModel viewModel = new ManageFriendRequestViewModel();
            viewModel.RequestClose += OnRequestClose;
            DataContext = viewModel;
        }

        private void OnRequestClose()
        {
            Close();
        }
    }
}
