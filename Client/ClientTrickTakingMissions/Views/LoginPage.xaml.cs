using System;
using System.Diagnostics;
using System.ServiceModel;
using System.Windows;
using System.Windows.Controls;
using Model.Security;
using Model.UserLoginService;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the user login page.
    /// </summary>
    public partial class LoginPage : Page, IUserLoginCallback
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="LoginPage"/> class.
        /// </summary>
        public LoginPage()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Handles the authentication response dispatched by the login service.
        /// </summary>
        /// <param name="success">Indicates whether credentials were authenticated successfully.</param>
        /// <param name="message">The outcome message provided by the server.</param>
        /// <param name="user">The authenticated user profile, or null if login failed.</param>
        public void LoginResult(bool success, string message, UserDTO user)
        {
            if (success)
            {
                NavigationService?.Navigate(new GameMenu());
            }
            else
            {
                MessageBox.Show(View.Properties.Langs.Resources.Login_InvalidCredentials, 
                    View.Properties.Langs.Resources.MainWindow_Title, 
                    MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            if (NavigationService != null)
            {
                NavigationService.Navigate(new HomeScreen());
            }
            else
            {
                Window window = Window.GetWindow(this);
                if (window is MainWindow mainWindow)
                {
                    mainWindow.MainFrame.Navigate(new HomeScreen());
                }
                else
                {
                    window?.Close();
                }
            }
        }

        private void BtnForgotPassword_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                ForgotPassword forgotPasswordWindow = new ForgotPassword();
                forgotPasswordWindow.Owner = Window.GetWindow(this);
                forgotPasswordWindow.ShowDialog();
                this.NavigationService?.Navigate(new HomeScreen());
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[LoginPage] Error opening forgot password dialog: {ex.Message}");
            }
        }

        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            string email = txfEmail.Text?.Trim() ?? string.Empty;
            string password = txfPassword.Password ?? string.Empty;

            if (IsLoginInputValid(email, password))
            {
                try
                {
                    string passwordHash = PasswordHasher.ComputeSha256Hash(password);
                    InstanceContext context = new InstanceContext(this);
                    UserLoginClient client = new UserLoginClient(context);

                    client.Login(email, passwordHash);
                }
                catch (EndpointNotFoundException ex)
                {
                    // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                    Debug.WriteLine($"[LoginPage] Connection failed: {ex.Message}");
                    MessageBox.Show(View.Properties.Langs.Resources.Common_Error_ConnectionFailed);
                }
                catch (TimeoutException ex)
                {
                    // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                    Debug.WriteLine($"[LoginPage] Request timed out: {ex.Message}");
                    MessageBox.Show(View.Properties.Langs.Resources.Common_Error_Timeout);
                }
                catch (CommunicationException ex)
                {
                    // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                    Debug.WriteLine($"[LoginPage] Communication error: {ex.Message}");
                    MessageBox.Show(View.Properties.Langs.Resources.Common_Error_Communication);
                }
            }
        }

        private bool IsLoginInputValid(string emailOrUsername, string password)
        {
            bool isInputValid = false;

            if (string.IsNullOrWhiteSpace(emailOrUsername))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Login_EmptyEmail);
                txfEmail.Focus();
            }
            else if (string.IsNullOrEmpty(password))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Login_EmptyPassword);
                txfPassword.Focus();
            }
            else
            {
                isInputValid = true;
            }

            return isInputValid;
        }
    }
}
