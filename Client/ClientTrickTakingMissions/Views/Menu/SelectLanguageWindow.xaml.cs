using System.Windows;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for selecting application language culture following the MVVM pattern.
    /// </summary>
    public partial class SelectLanguageWindow : Window
    {
        private readonly SelectLanguageViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="SelectLanguageWindow"/> class with default UI services.
        /// </summary>
        public SelectLanguageWindow()
            : this(new SelectLanguageViewModel(new WpfLanguageService()))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SelectLanguageWindow"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this dialog.</param>
        public SelectLanguageWindow(SelectLanguageViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;

            if (_viewModel != null)
            {
                _viewModel.RequestClose += () => this.Close();
            }
        }
    }
}
