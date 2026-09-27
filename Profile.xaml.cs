using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace MisionesBazas
{
    public partial class Profile : Page
    {
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
            catch (Exception ex)
            {
                Debug.WriteLine($"[Profile] Navigation error: {ex.Message}");
            }
        }
    }
}
