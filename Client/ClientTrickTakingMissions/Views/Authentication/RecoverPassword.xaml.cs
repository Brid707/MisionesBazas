using System.Windows;
using System.Windows.Controls;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the password recovery confirmation view following the MVVM pattern.
    /// </summary>
    public partial class RecoverPassword : Page
    {
        private readonly RecoverPasswordViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="RecoverPassword"/> class.
        /// </summary>
        public RecoverPassword()
            : this(string.Empty)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RecoverPassword"/> class with an email address.
        /// </summary>
        /// <param name="email">The email address of the account being recovered.</param>
        public RecoverPassword(string email)
            : this(new RecoverPasswordViewModel(ClientLoggingRuntime.CreateUiServices<RecoverPasswordViewModel>(), email))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RecoverPassword"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public RecoverPassword(RecoverPasswordViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;

            if (_viewModel != null)
            {
                _viewModel.RequestBack += OnRequestBack;
                _viewModel.RequestClose += OnRequestClose;
            }
        }

        private void OnRequestBack()
        {
            ForgotPassword parent = Window.GetWindow(this) as ForgotPassword;
            if (parent != null)
            {
                parent.ShowInitialView();
            }
            else if (this.NavigationService != null && this.NavigationService.CanGoBack)
            {
                this.NavigationService.GoBack();
            }
        }

        private void OnRequestClose()
        {
            Window.GetWindow(this)?.Close();
        }
    }
}
