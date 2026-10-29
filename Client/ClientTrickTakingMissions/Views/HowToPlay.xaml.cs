using System.Windows;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the game rules and guide window following the MVVM pattern.
    /// </summary>
    public partial class HowToPlay : Window
    {
        private readonly HowToPlayViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="HowToPlay"/> class with default ViewModel.
        /// </summary>
        public HowToPlay()
            : this(new HowToPlayViewModel())
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="HowToPlay"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this dialog.</param>
        public HowToPlay(HowToPlayViewModel viewModel)
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
