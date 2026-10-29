using System.Windows;
using System.Windows.Controls;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for user account registration view following the MVVM pattern.
    /// </summary>
    public partial class RegisterPage : Page
    {
        private readonly RegisterViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="RegisterPage"/> class with default UI services.
        /// </summary>
        public RegisterPage()
            : this(new RegisterViewModel(new WpfNavigationService(), new WpfDialogService()))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RegisterPage"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public RegisterPage(RegisterViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (_viewModel != null)
            {
                _viewModel.Password = PasswordBox.Password;
            }
        }

        private void ConfirmPasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (_viewModel != null)
            {
                _viewModel.PasswordConfirm = ConfirmPasswordBox.Password;
            }
        }
    }
}
