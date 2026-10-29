using System;
using System.Windows.Input;
using Model.Session;
using ViewModel.Base;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for displaying and updating user profile statistics and details.
    /// </summary>
    public sealed class ProfileViewModel : ViewModelBase
    {
        private readonly INavigationService _navigationService;

        private string _username;
        private string _email;
        private string _accountCreationDate;
        private int _missionsCount;
        private string _biography;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProfileViewModel"/> class.
        /// </summary>
        /// <param name="navigationService">Service for managing view navigation.</param>
        public ProfileViewModel(INavigationService navigationService)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));

            LoadCurrentProfile();

            CloseCommand = new RelayCommand(ExecuteClose);
        }

        /// <summary>
        /// Gets or sets the display username of the profile.
        /// </summary>
        public string Username
        {
            get => _username;
            set => SetProperty(ref _username, value);
        }

        /// <summary>
        /// Gets or sets the user's registered email address.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets or sets the formatted account registration date.
        /// </summary>
        public string AccountCreationDate
        {
            get => _accountCreationDate;
            set => SetProperty(ref _accountCreationDate, value);
        }

        /// <summary>
        /// Gets or sets the number of missions completed by the user.
        /// </summary>
        public int MissionsCount
        {
            get => _missionsCount;
            set => SetProperty(ref _missionsCount, value);
        }

        /// <summary>
        /// Gets or sets the user's custom biography text.
        /// </summary>
        public string Biography
        {
            get => _biography;
            set => SetProperty(ref _biography, value);
        }

        /// <summary>
        /// Gets the command that navigates back from the profile view.
        /// </summary>
        public ICommand CloseCommand { get; }

        private void LoadCurrentProfile()
        {
            UserSessionData currentUser = UserSession.Current.CurrentUser;
            if (currentUser != null)
            {
                Username = currentUser.Username;
                Email = currentUser.Email;
            }
            else
            {
                Username = "Invitado";
                Email = string.Empty;
            }

            AccountCreationDate = DateTime.Now.ToString("dd/MM/yyyy");
            MissionsCount = 0;
            Biography = string.Empty;
        }

        private void ExecuteClose()
        {
            _navigationService.GoBack();
        }
    }
}
