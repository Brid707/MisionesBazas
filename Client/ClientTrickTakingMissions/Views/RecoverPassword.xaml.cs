using System;
using System.Windows;
using System.Windows.Controls;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the password recovery confirmation view.
    /// </summary>
    public partial class RecoverPassword : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="RecoverPassword"/> class.
        /// </summary>
        public RecoverPassword()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RecoverPassword"/> class with an email address.
        /// </summary>
        /// <param name="email">The email address of the account being recovered.</param>
        public RecoverPassword(string email) : this()
        {
            if (!string.IsNullOrEmpty(email))
            {
                EmailTextBox.Text = email;
            }
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            ForgotPassword parent = Window.GetWindow(this) as ForgotPassword;
            if (parent != null)
            {
                parent.ShowInitialView();
            }
            else if (this.NavigationService != null && this.NavigationService.CanGoBack)
            {
                this.NavigationService.GoBack();
            }
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            Window.GetWindow(this)?.Close();
        }

        private void ResendButton_Click(object sender, RoutedEventArgs e)
        {
            // TODO: Implement code resend via backend service.
        }

        private void ConfirmButton_Click(object sender, RoutedEventArgs e)
        {
            ChangePassword changePasswordDialog = new ChangePassword();
            ShowModalDialog(changePasswordDialog);
        }

        private bool? ShowModalDialog(Window dialog)
        {
            Window owner = Window.GetWindow(this);
            if (owner != null)
            {
                dialog.Owner = owner;
                dialog.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            }

            return dialog.ShowDialog();
        }
    }
}
