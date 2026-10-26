using System;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the forgot password window.
    /// </summary>
    public partial class ForgotPassword : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ForgotPassword"/> class.
        /// </summary>
        public ForgotPassword()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Displays the initial email submission interface within the dialog frame.
        /// </summary>
        public void ShowInitialView()
        {
            ContentFrame.Content = null;
            ContentFrame.Visibility = Visibility.Collapsed;
            MainBorder.Visibility = Visibility.Visible;
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            string email = EmailTextBox.Text?.Trim() ?? string.Empty;
            MainBorder.Visibility = Visibility.Collapsed;
            ContentFrame.Visibility = Visibility.Visible;
            ContentFrame.Navigate(new RecoverPassword(email));
        }
    }
}
