using System.Windows;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the forgot password window following the MVVM pattern.
    /// </summary>
    public partial class ForgotPassword : Window
    {
        private readonly ForgotPasswordViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="ForgotPassword"/> class with default UI services.
        /// </summary>
        public ForgotPassword()
            : this(new ForgotPasswordViewModel(new WpfDialogService()))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ForgotPassword"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public ForgotPassword(ForgotPasswordViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;

            if (_viewModel != null)
            {
                _viewModel.RequestClose += () => this.Close();
                _viewModel.EmailSubmitted += OnEmailSubmitted;
            }
        }

        /// <summary>
        /// Displays the initial email submission interface within the dialog frame.
        /// </summary>
        public void ShowInitialView()
        {
            ContentFrame.Content = null;
            ContentFrame.Visibility = Visibility.Collapsed;
            MainBorder.Visibility = Visibility.Visible;
        }

        private void OnEmailSubmitted(string email)
        {
            MainBorder.Visibility = Visibility.Collapsed;
            ContentFrame.Visibility = Visibility.Visible;
            ContentFrame.Navigate(new RecoverPassword(email));
        }
    }
}
