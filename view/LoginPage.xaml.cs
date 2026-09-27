using MisionesBazas.Properties.Langs;
using MisionesBazas.view;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace MisionesBazas
{
    public partial class LoginPage : Page
    {
        private static readonly Dictionary<string, string> _registeredAccounts =
            new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "correo@ejemplo.com", "Password123!" },
                { "usuario@ejemplo.com", "Password123!" },
                { "test@test.com", "Password123!" }
            };

        public LoginPage()
        {
            InitializeComponent();
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            if (NavigationService != null && NavigationService.CanGoBack)
            {
                NavigationService.GoBack();
            }
            else
            {
                Window.GetWindow(this)?.Close();
            }
        }

        private void BtnRecuperarContraseña_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var dlg = new ForgotPassword();
                dlg.Owner = Window.GetWindow(this);
                dlg.ShowDialog();
                this.NavigationService?.Navigate(new HomeScreen());
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[HomeScreen] Error abriendo selector de idioma: {ex.Message}");
            }
        }

        private void BtnEntrar_Click(object sender, RoutedEventArgs e)
        {
            string email = txtCorreo.Text?.Trim() ?? string.Empty;
            string password = txtContraseña.Password ?? string.Empty;

            if (ValidateLoginInput(email, password))
            {
                AttemptLogin(email, password);
            }
        }

        private bool ValidateLoginInput(string email, string password)
        {
            bool isValid = false;

            if (string.IsNullOrWhiteSpace(email))
            {
                MessageBox.Show(Properties.Langs.Resources.Login_EmptyEmail);
                txtCorreo.Focus();
            }
            else if (string.IsNullOrEmpty(password))
            {
                MessageBox.Show(Properties.Langs.Resources.Login_EmptyPassword);
                txtContraseña.Focus();
            }
            else
            {
                isValid = true;
            }

            return isValid;
        }

        private bool AttemptLogin(string email, string password)
        {
            bool isSuccess = false;

            if (AreCredentialsValid(email, password))
            {
                isSuccess = true;

                if (NavigationService != null)
                {
                    NavigationService.Navigate(new GameMenu());
                }
                else
                {
                    var win = new Window()
                    {
                        Title = "Game Menu",
                        Content = new GameMenu(),
                        Width = 1000,
                        Height = 700,
                        Owner = Window.GetWindow(this)
                    };
                    win.ShowDialog();
                }
            }
            else
            {
                MessageBox.Show(Properties.Langs.Resources.Login_InvalidCredentials);
                txtContraseña.Focus();
            }

            return isSuccess;
        }

        private bool AreCredentialsValid(string email, string password)
        {
            bool isValid = false;

            if (_registeredAccounts.TryGetValue(email, out string storedPassword)
                && storedPassword.Equals(password, StringComparison.Ordinal))
            {
                isValid = true;
            }

            return isValid;
        }
    }
}
