using System.Windows;
using Model.Session;
using View.Services;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for entering an invitation game code to join a match.
    /// </summary>
    public partial class EnterGameCode : Window
    {
        private readonly EnterGameCodeViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="EnterGameCode"/> class.
        /// </summary>
        public EnterGameCode()
        {
            InitializeComponent();

            IDialogService dialogService = new WpfDialogService();
            _viewModel = new EnterGameCodeViewModel(
                dialogService,
                LobbySession.Current,
                ClientLoggingRuntime.CreateLogger<EnterGameCodeViewModel>());
            _viewModel.RequestClose += OnRequestClose;
            DataContext = _viewModel;
        }

        /// <summary>
        /// Gets the trimmed code string entered by the user.
        /// </summary>
        public string GameCode => _viewModel?.GameCode?.Trim() ?? string.Empty;

        private void OnRequestClose(bool confirmed)
        {
            DialogResult = confirmed;
            Close();
        }
    }
}
