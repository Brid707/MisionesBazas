using System.Windows.Controls;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the initial home screen view following the MVVM pattern.
    /// </summary>
    public partial class HomeScreen : Page
    {
        private readonly HomeScreenViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="HomeScreen"/> class with default UI services.
        /// </summary>
        public HomeScreen()
            : this(new HomeScreenViewModel(new WpfNavigationService()))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="HomeScreen"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public HomeScreen(HomeScreenViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;
        }
    }
}
