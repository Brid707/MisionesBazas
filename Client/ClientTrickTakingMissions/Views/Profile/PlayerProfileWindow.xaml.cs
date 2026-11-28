using System;
using System.Windows;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>Hosts a read-only profile and releases its image observation when the window closes.</summary>
    public partial class PlayerProfileWindow : Window
    {
        private readonly PlayerProfileViewModel _viewModel;

        public PlayerProfileWindow(PlayerProfileViewModel viewModel)
        {
            InitializeComponent();
            _viewModel = viewModel;
            DataContext = viewModel;
            _viewModel.CloseRequested += OnCloseRequested;
            Loaded += OnProfileLoaded;
            Closed += OnProfileClosed;
        }

        private void OnProfileLoaded(object sender, RoutedEventArgs e)
        {
            _viewModel.ReloadProfileCommand.Execute(null);
        }

        private void OnCloseRequested(object sender, EventArgs e)
        {
            Close();
        }

        private void OnProfileClosed(object sender, EventArgs e)
        {
            _viewModel.CloseRequested -= OnCloseRequested;
            _viewModel.Dispose();
        }
    }
}
