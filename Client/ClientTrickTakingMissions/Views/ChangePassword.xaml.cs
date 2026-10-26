using System;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the change password window.
    /// </summary>
    public partial class ChangePassword : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ChangePassword"/> class.
        /// </summary>
        public ChangePassword()
        {
            InitializeComponent();
        }

        private void BtnCloseTop_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ConfirmButton_Click(object sender, RoutedEventArgs e)
        {
            // TODO: Implement password change logic via backend service.
        }
    }
}
