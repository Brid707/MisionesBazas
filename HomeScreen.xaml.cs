using System;
using System.Diagnostics;
using System.Windows.Controls;
using System.Windows;

namespace MisionesBazas
{
    public partial class HomeScreen : Page
    {
        public HomeScreen()
        {
            InitializeComponent();
        }

        private void BtnLanguage_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var owner = Window.GetWindow(this);
                var dlg = new SelectLanguageWindow();
                if (owner != null)
                {
                    dlg.Owner = owner;
                }

                dlg.ShowDialog();
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[HomeScreen] Error abriendo selector de idioma: {ex.Message}");
            }
        }

        private void HomePage_BtnSignUp_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var register = new RegisterPage();

                if (this.NavigationService != null)
                {
                    this.NavigationService.Navigate(register);
                }
                else
                {
                    var win = new Window()
                    {
                        Title = "Register",
                        Content = register,
                        Width = 900,
                        Height = 700,
                        Owner = Window.GetWindow(this)
                    };
                    win.ShowDialog();
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[HomeScreen] Error abriendo RegisterPage: {ex.Message}");
            }
        }

        private void HomePage_BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var login = new LoginPage();
                if (this.NavigationService != null)
                {
                    this.NavigationService.Navigate(login);
                }
                else
                {
                    var win = new Window()
                    {
                        Title = "Login",
                        Content = login,
                        Width = 900,
                        Height = 700,
                        Owner = Window.GetWindow(this)
                    };
                    win.ShowDialog();
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[HomeScreen] Error opening LoginPage: {ex.Message}");
            }
        }

        private void HomePage_BtnGuest_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var gameMenu = new GameMenu();
                if (this.NavigationService != null)
                {
                    this.NavigationService.Navigate(gameMenu);
                }
                else
                {
                    var win = new Window()
                    {
                        Title = "Game Menu",
                        Content = gameMenu,
                        Width = 1000,
                        Height = 700,
                        Owner = Window.GetWindow(this)
                    };
                    win.ShowDialog();
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[HomeScreen] Error opening GameMenu: {ex.Message}");
            }
        }
    }
}
