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

        private void CreateRoomButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                GameSettings gameSettingsDialog = new GameSettings();
                bool? dialogResult = ShowModalDialog(gameSettingsDialog);
                if (dialogResult == true)
                {
                    NavigateToPage(new Lobby());
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[GameMenu] Error showing GameSettings dialog: {ex.Message}");
            }
        }

        private void JoinLobbyButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                EnterGameCode enterGameCodeDialog = new EnterGameCode();
                bool? dialogResult = ShowModalDialog(enterGameCodeDialog);
                if (dialogResult == true)
                {
                    // TODO: Pass enterGameCodeDialog.GameCode to Lobby once parameterized.
                    NavigateToPage(new Lobby());
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[GameMenu] Error showing EnterGameCode dialog: {ex.Message}");
            }
        }

        private void HowToPlayButton_Click(object sender, RoutedEventArgs e)
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

        private void SignOutButton_Click(object sender, RoutedEventArgs e)
        {
            Model.Session.UserSession.Current.ClearSession();
            NavigateToPage(new HomeScreen());
        }

        private void ProfileButton_Click(object sender, RoutedEventArgs e)
        {
            NavigateToProfile();
        }

        private void TrophyButton_Click(object sender, RoutedEventArgs e)
        {
            ScoreBoard scoreBoardDialog = new ScoreBoard();
            ShowModalDialog(scoreBoardDialog);
        }

        private void NavigateToProfile()
        {
            NavigateToPage(new Profile());
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
    }
}
