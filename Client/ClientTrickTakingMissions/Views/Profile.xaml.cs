using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for displaying and managing user profile information.
    /// </summary>
    public partial class Profile : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="Profile"/> class.
        /// </summary>
        public Profile()
        {
            InitializeComponent();
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
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
                    else if (window != null)
                    {
                        window.Close();
                    }
                }
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[Profile] Navigation error: {ex.Message}");
            }
        }
    }
}
