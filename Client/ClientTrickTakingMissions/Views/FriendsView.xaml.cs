using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the friends sidebar control.
    /// Reusable view dynamically embedded in GameMenu and Lobby.
    /// </summary>
    public partial class FriendsView : UserControl
    {
        /// <summary>
        /// Identifies the <see cref="IsInLobby"/> dependency property.
        /// </summary>
        public static readonly DependencyProperty IsInLobbyProperty =
            DependencyProperty.Register(
                nameof(IsInLobby),
                typeof(bool),
                typeof(FriendsView),
                new PropertyMetadata(false, OnIsInLobbyChanged));

        /// <summary>
        /// Identifies the <see cref="InviteButtonVisibility"/> dependency property.
        /// </summary>
        public static readonly DependencyProperty InviteButtonVisibilityProperty =
            DependencyProperty.Register(
                nameof(InviteButtonVisibility),
                typeof(Visibility),
                typeof(FriendsView),
                new PropertyMetadata(Visibility.Collapsed));

        /// <summary>
        /// Initializes a new instance of the <see cref="FriendsView"/> class.
        /// </summary>
        public FriendsView()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Gets or sets a value indicating whether this view is embedded in the Lobby screen.
        /// </summary>
        public bool IsInLobby
        {
            get => (bool)GetValue(IsInLobbyProperty);
            set => SetValue(IsInLobbyProperty, value);
        }

        /// <summary>
        /// Gets or sets the visibility of the invite-to-match button on friend cards.
        /// </summary>
        public Visibility InviteButtonVisibility
        {
            get => (Visibility)GetValue(InviteButtonVisibilityProperty);
            set => SetValue(InviteButtonVisibilityProperty, value);
        }

        private static void OnIsInLobbyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is FriendsView friendsView)
            {
                friendsView.InviteButtonVisibility = (bool)e.NewValue ? Visibility.Visible : Visibility.Collapsed;
            }
        }

        private void FriendsButton_Click(object sender, RoutedEventArgs e)
        {
            // TODO: In future iterations, toggle or filter active friends list.
        }

        private void MessagesButton_Click(object sender, RoutedEventArgs e)
        {
            OpenManageFriendRequests();
        }

        private void AddFriendButton_Click(object sender, RoutedEventArgs e)
        {
            NavigateToPage(new SendFriendRequest());
        }

        private void ViewProfileButton_Click(object sender, RoutedEventArgs e)
        {
            NavigateToPage(new Profile());
        }

        private void DeleteFriendButton_Click(object sender, RoutedEventArgs e)
        {
            // TODO: Delete friend logic via backend service/ViewModel.
        }

        private void InviteFriendButton_Click(object sender, RoutedEventArgs e)
        {
            // TODO: Dispatch match invitation via backend service/ViewModel.
        }

        private void OpenManageFriendRequests()
        {
            try
            {
                ManageFriendRequest manageFriendRequestDialog = new ManageFriendRequest();
                Window owner = Window.GetWindow(this);
                if (owner != null)
                {
                    manageFriendRequestDialog.Owner = owner;
                    manageFriendRequestDialog.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                }

                manageFriendRequestDialog.ShowDialog();
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[FriendsView] Error opening friend requests dialog: {ex.Message}");
                MessageBox.Show(View.Properties.Langs.Resources.Common_Error_Unexpected);
            }
        }

        private void NavigateToPage(Page targetPage)
        {
            NavigationService navigationService = NavigationService.GetNavigationService(this);
            if (navigationService != null)
            {
                navigationService.Navigate(targetPage);
            }
            else
            {
                Window window = Window.GetWindow(this);
                if (window is MainWindow mainWindow)
                {
                    mainWindow.MainFrame.Navigate(targetPage);
                }
            }
        }
    }
}
