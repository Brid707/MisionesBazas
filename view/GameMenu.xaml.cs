using System;
using System.Windows;
using System.Windows.Controls;

namespace MisionesBazas
{
    public partial class GameMenu : Page
    {
        public GameMenu()
        {
            InitializeComponent();
        }

        private void BtnCrearSala_Click(object sender, RoutedEventArgs e)
        {
        }

        private void BtnUnirseSala_Click(object sender, RoutedEventArgs e)
        {
        }

        private void BtnComoJugar_Click(object sender, RoutedEventArgs e)
        {
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
        }

        private void BtnAddFriend_Click(object sender, RoutedEventArgs e)
        {
        }

        private void BtnVerPerfil_Click(object sender, RoutedEventArgs e)
        {
            NavigateToProfile();
        }

        private void BtnEliminarAmigo_Click(object sender, RoutedEventArgs e)
        {
        }

        private void NavigateToProfile()
        {
            var profilePage = new Profile();
            if (this.NavigationService != null)
            {
                this.NavigationService.Navigate(profilePage);
            }
            else
            {
                var window = Window.GetWindow(this);
                if (window is MainWindow mainWindow)
                {
                    mainWindow.MainFrame.Navigate(profilePage);
                }
            }
        }
    }
}
