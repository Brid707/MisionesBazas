using System.Windows;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the change password window following the MVVM pattern.
    /// </summary>
    public partial class ChangePassword : Window
    {
        private readonly ChangePasswordViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="ChangePassword"/> class with default UI services.
        /// </summary>
        public ChangePassword()
            : this(new ChangePasswordViewModel(new WpfDialogService()))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ChangePassword"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this dialog.</param>
        public ChangePassword(ChangePasswordViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;

            if (_viewModel != null)
            {
                _viewModel.RequestClose += () => this.Close();
            }
        }

        private void NewPasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (_viewModel != null)
            {
                _viewModel.NewPassword = NewPasswordBox.Password;
            }
        }

        private void ConfirmPasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            if (_viewModel != null)
            {
                _viewModel.ConfirmPassword = ConfirmPasswordBox.Password;
            }
        }
    }
}
