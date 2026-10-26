using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the initial home screen view.
    /// </summary>
    public partial class HomeScreen : Page
    {
        private const double DefaultWindowWidth = 900;
        private const double DefaultWindowHeight = 700;
        private const double GameMenuWindowWidth = 1000;
        private const double GameMenuWindowHeight = 700;

        /// <summary>
        /// Initializes a new instance of the <see cref="HomeScreen"/> class.
        /// </summary>
        public HomeScreen()
        {
            InitializeComponent();
        }

        private void BtnLanguage_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SelectLanguageWindow selectLanguageWindow = new SelectLanguageWindow();
                selectLanguageWindow.Owner = Window.GetWindow(this);
                selectLanguageWindow.ShowDialog();
                this.NavigationService?.Navigate(new HomeScreen());
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[HomeScreen] Error opening language selector: {ex.Message}");
            }
        }

        private void HomePage_BtnSignUp_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                NavigateOrOpenModal(new RegisterPage(), View.Properties.Langs.Resources.Register_Title, DefaultWindowWidth, DefaultWindowHeight);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[HomeScreen] Error opening RegisterPage: {ex.Message}");
            }
        }

        private void HomePage_BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                NavigateOrOpenModal(new LoginPage(), View.Properties.Langs.Resources.Login_Title, DefaultWindowWidth, DefaultWindowHeight);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[HomeScreen] Error opening LoginPage: {ex.Message}");
            }
        }

        private void HomePage_BtnGuest_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                NavigateOrOpenModal(new GameMenu(), View.Properties.Langs.Resources.GameMenu_Title, GameMenuWindowWidth, GameMenuWindowHeight);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[HomeScreen] Error opening GameMenu: {ex.Message}");
            }
        }

        private void NavigateOrOpenModal(Page targetPage, string windowTitle, double width, double height)
        {
            if (this.NavigationService != null)
            {
                this.NavigationService.Navigate(targetPage);
            }
            else
            {
                Window modalWindow = new Window
                {
                    Title = windowTitle,
                    Content = targetPage,
                    Width = width,
                    Height = height,
                    Owner = Window.GetWindow(this)
                };
                modalWindow.ShowDialog();
            }
        }
    }
}
