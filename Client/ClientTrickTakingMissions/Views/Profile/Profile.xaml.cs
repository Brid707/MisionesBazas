using System.Windows.Controls;
using Model.Services;
using ViewModel.Models;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for displaying and managing user profile information following the MVVM pattern.
    /// </summary>
    public partial class Profile : Page
    {
        private readonly ProfileViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="Profile"/> class with default UI services.
        /// </summary>
        public Profile()
            : this(new ProfileViewModel(
                ClientLoggingRuntime.CreateNavigationLogging<ProfileViewModel>(),
                new WpfProfileImagePicker(),
                new ProfileInteractionDependencies
                {
                    ProfileImages = ((App)System.Windows.Application.Current).ProfileImages,
                    PlayerProfileClient = new PlayerProfileClient(
                        ClientLoggingRuntime.CreateLogger<PlayerProfileClient>())
                }))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Profile"/> class with an injected ViewModel.
        /// </summary>
        /// <param name="viewModel">The ViewModel instance to bind to this view.</param>
        public Profile(ProfileViewModel viewModel)
        {
            InitializeComponent();

            _viewModel = viewModel;
            DataContext = _viewModel;
            Loaded += (_, __) => _viewModel.ActivateProfileImage();
            Loaded += (_, __) => _viewModel.BiographyEditor.ReloadProfileCommand.Execute(null);
            Unloaded += (_, __) => _viewModel.DeactivateProfileImage();
        }
    }
}
