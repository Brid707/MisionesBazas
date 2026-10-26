using System;
using System.Windows;
using System.Windows.Controls;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for sending friend requests to other players.
    /// </summary>
    public partial class SendFriendRequest : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="SendFriendRequest"/> class.
        /// </summary>
        public SendFriendRequest()
        {
            InitializeComponent();
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            if (this.NavigationService != null && this.NavigationService.CanGoBack)
            {
                this.NavigationService.GoBack();
            }
            else if (this.NavigationService != null)
            {
                this.NavigationService.Navigate(new GameMenu());
            }
            else
            {
                Window window = Window.GetWindow(this);
                if (window is MainWindow mainWindow)
                {
                    mainWindow.MainFrame.Navigate(new GameMenu());
                }
                else
                {
                    window?.Close();
                }
            }
        }
    }
}
