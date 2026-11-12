using System.Windows;
using Model.Session;
using View.Services;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for configuring match rules and game settings.
    /// Acts as a modal dialog that returns confirmation to the parent view.
    /// </summary>
    public partial class GameSettings : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="GameSettings"/> class.
        /// </summary>
        public GameSettings()
        {
            InitializeComponent();

            IDialogService dialogService = new WpfDialogService();
            GameSettingsViewModel viewModel = new GameSettingsViewModel(
                dialogService,
                LobbySession.Current,
                ClientLoggingRuntime.CreateLogger<GameSettingsViewModel>());
            viewModel.RequestClose += OnRequestClose;
            DataContext = viewModel;
        }

        private void OnRequestClose(bool confirmed)
        {
            DialogResult = confirmed;
            Close();
        }
    }
}
