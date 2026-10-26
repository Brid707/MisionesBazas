using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the main game navigation menu.
    /// </summary>
    public partial class GameMenu : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="GameMenu"/> class.
        /// </summary>
        public GameMenu()
        {
            InitializeComponent();
        }

        private void BtnCreateRoom_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                GameSettings gameSettingsDialog = new GameSettings();
                bool? dialogResult = ShowModalDialog(gameSettingsDialog);
                if (dialogResult == true)
                {
                    // TODO: Handle room creation confirmation if necessary.
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[GameMenu] Error showing GameSettings dialog: {ex.Message}");
            }
        }

        private void BtnJoinLobby_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                EnterGameCode enterGameCodeDialog = new EnterGameCode();
                bool? dialogResult = ShowModalDialog(enterGameCodeDialog);
                if (dialogResult == true)
                {
                    // TODO: Manage code entered by the user in enterGameCodeDialog.GameCode
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[GameMenu] Error showing EnterGameCode dialog: {ex.Message}");
            }
        }

        private void BtnHowToPlay_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                HowToPlay howToPlayDialog = new HowToPlay();
                ShowModalDialog(howToPlayDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[GameMenu] Error showing HowToPlay dialog: {ex.Message}");
            }
        }

        private void BtnSignOut_Click(object sender, RoutedEventArgs e)
        {
            Model.Session.UserSession.Current.ClearSession();
            NavigateToPage(new HomeScreen());
        }

        private void BtnProfile_Click(object sender, RoutedEventArgs e)
        {
            NavigateToProfile();
        }

        private void BtnFriends_Click(object sender, RoutedEventArgs e)
        {
        }

        private void BtnMessages_Click(object sender, RoutedEventArgs e)
        {
            OpenManageFriendRequest();
        }

        private void BtnAddFriend_Click(object sender, RoutedEventArgs e)
        {
            NavigateToSendFriendRequest();
        }

        private void BtnViewProfile_Click(object sender, RoutedEventArgs e)
        {
            NavigateToProfile();
        }

        private void BtnTrophy_Click(object sender, RoutedEventArgs e)
        {
            ScoreBoard scoreBoardDialog = new ScoreBoard();
            ShowModalDialog(scoreBoardDialog);
        }

        private void BtnDeleteFriend_Click(object sender, RoutedEventArgs e)
        {
        }

        private void NavigateToProfile()
        {
            NavigateToPage(new Profile());
        }

        private void NavigateToSendFriendRequest()
        {
            NavigateToPage(new SendFriendRequest());
        }

        private void NavigateToPage(Page targetPage)
        {
            if (this.NavigationService != null)
            {
                this.NavigationService.Navigate(targetPage);
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

        private bool? ShowModalDialog(Window dialog)
        {
            Window owner = Window.GetWindow(this);
            if (owner != null)
            {
                dialog.Owner = owner;
                dialog.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            }

            return dialog.ShowDialog();
        }

        private void OpenManageFriendRequest()
        {
            try
            {
                ManageFriendRequest manageFriendRequestDialog = new ManageFriendRequest();
                ShowModalDialog(manageFriendRequestDialog);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[GameMenu] Error opening friend requests: {ex.Message}");
                MessageBox.Show(View.Properties.Langs.Resources.Common_Error_Unexpected);
            }
        }
    }
}
