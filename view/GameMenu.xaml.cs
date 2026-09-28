using System;
using System.Windows;
using System.Windows.Controls;
using MisionesBazas.view;

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

        private void BtnTrophy_Click(object sender, RoutedEventArgs e)
        {
            var owner = Window.GetWindow(this);
            var board = new ScoreBoard();
            if (owner != null)
            {
                board.Owner = owner;
                board.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            }
            board.ShowDialog();
        }

        private void BtnSalir_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var home = new HomeScreen();
                if (this.NavigationService != null)
                {
                    this.NavigationService.Navigate(home);
                }
                else
                {
                    var window = Window.GetWindow(this);
                    if (window is MainWindow mainWindow)
                    {
                        mainWindow.MainFrame.Navigate(home);
                    }
                    else
                    {
                        var win = new Window()
                        {
                            Title = "Home",
                            Content = home,
                            Width = 900,
                            Height = 700,
                            Owner = Window.GetWindow(this)
                        };
                        win.ShowDialog();
                    }
                }
            }
            catch (Exception)
            {
            }
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
