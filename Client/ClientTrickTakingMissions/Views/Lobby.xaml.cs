using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the game match lobby view.
    /// </summary>
    public partial class Lobby : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="Lobby"/> class.
        /// </summary>
        public Lobby()
        {
            InitializeComponent();
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            try
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
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[Lobby] Error navigating back or closing: {ex.Message}");
            }
        }

        private void ProfileButton_Click(object sender, RoutedEventArgs e)
        {
            if (this.NavigationService != null)
            {
                this.NavigationService.Navigate(new Profile());
            }
            else
            {
                Window window = Window.GetWindow(this);
                if (window is MainWindow mainWindow)
                {
                    mainWindow.MainFrame.Navigate(new Profile());
                }
            }
        }
    }
}
