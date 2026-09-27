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
            string message = LocalizationManager.Instance["GameMenu.CreateRoom"];
            MessageBox.Show(message);
        }

        private void BtnUnirseSala_Click(object sender, RoutedEventArgs e)
        {
            string message = LocalizationManager.Instance["GameMenu.JoinRoom"];
            MessageBox.Show(message);
        }

        private void BtnComoJugar_Click(object sender, RoutedEventArgs e)
        {
            string message = LocalizationManager.Instance["GameMenu.HowToPlay"];
            MessageBox.Show(message);
        }

        private void BtnProfile_Click(object sender, RoutedEventArgs e)
        {
            NavigateToProfile();
        }

        private void BtnFriends_Click(object sender, RoutedEventArgs e)
        {
            string message = LocalizationManager.Instance["GameMenu.Friends"];
            MessageBox.Show(message);
        }

        private void BtnMessages_Click(object sender, RoutedEventArgs e)
        {
            string message = LocalizationManager.Instance["GameMenu.Messages"];
            MessageBox.Show(message);
        }

        private void BtnAddFriend_Click(object sender, RoutedEventArgs e)
        {
            string message = LocalizationManager.Instance["GameMenu.AddFriend"];
            MessageBox.Show(message);
        }

        private void BtnVerPerfil_Click(object sender, RoutedEventArgs e)
        {
            NavigateToProfile();
        }

        private void BtnEliminarAmigo_Click(object sender, RoutedEventArgs e)
        {
            string message = LocalizationManager.Instance["FriendsBar.DeleteFriend"];
            MessageBox.Show(message);
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
