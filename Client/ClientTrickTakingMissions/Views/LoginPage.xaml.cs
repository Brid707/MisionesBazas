using System.Windows;
using System.Windows.Controls;

using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the user login page following the MVVM pattern.
    /// </summary>
    public partial class LoginPage : Page
    {
        private readonly LoginViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="LoginPage"/> class with default UI services.
        /// </summary>
        public LoginPage()
            : this(new LoginViewModel(new WpfNavigationService(), new WpfDialogService(),
                new ChatModerationPresenter()))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="LoginPage"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public LoginPage(LoginViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;
            Unloaded += OnLoginPageUnloaded;
        }

        private void OnLoginPageUnloaded(object sender, RoutedEventArgs e)
        {
            _viewModel.Dispose();
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (_viewModel != null)
            {
                _viewModel.Password = PasswordBox.Password;
            }
        }
    }
}
