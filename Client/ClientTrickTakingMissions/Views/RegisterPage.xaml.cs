using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for user account registration.
    /// </summary>
    public partial class RegisterPage : Page
    {
        private const int MinimumPasswordLength = 8;
        private const string SpecialCharacterPattern = @"[^a-zA-Z0-9]";
        private const string NumberPattern = @"[0-9]";

        /// <summary>
        /// Initializes a new instance of the <see cref="RegisterPage"/> class.
        /// </summary>
        public RegisterPage()
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

        private void Register_Submit_Click(object sender, RoutedEventArgs e)
        {
            if (IsLocalDataValid())
            {
                // TODO: Implement the call to the backend service for registration and handle the response accordingly.
            }
        }

        private bool IsLocalDataValid()
        {
            bool isDataValid = true;

            if (AreFieldsEmpty())
            {
                isDataValid = false;
            }
            else if (!IsValidEmailFormat(Register_Email.Text))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Register_InvalidEmail);
                Register_Email.Focus();
                isDataValid = false;
            }
            else if (!IsPasswordValid(Register_Password.Password))
            {
                isDataValid = false;
            }
            else if (!ArePasswordsMatching(Register_Password.Password, Register_PasswordConfirm.Password))
            {
                isDataValid = false;
            }

            return isDataValid;
        }

        private bool AreFieldsEmpty()
        {
            bool areFieldsEmpty = true;

            if (string.IsNullOrWhiteSpace(Register_Email.Text))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Register_EmptyEmail);
                Register_Email.Focus();
            }
            else if (string.IsNullOrWhiteSpace(Register_Username.Text))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Register_EmptyUsername);
                Register_Username.Focus();
            }
            else if (string.IsNullOrEmpty(Register_Password.Password))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Register_EmptyPassword);
                Register_Password.Focus();
            }
            else if (string.IsNullOrEmpty(Register_PasswordConfirm.Password))
            {
                MessageBox.Show(View.Properties.Langs.Resources.Register_EmptyPasswordConfirmation);
                Register_PasswordConfirm.Focus();
            }
            else
            {
                areFieldsEmpty = false;
            }

            return areFieldsEmpty;
        }

        private bool IsValidEmailFormat(string email)
        {
            bool isEmailValid = false;

            if (!string.IsNullOrWhiteSpace(email))
            {
                string sanitizedEmail = email.Trim();
                int atIndex = sanitizedEmail.IndexOf('@');
                int dotIndex = sanitizedEmail.LastIndexOf('.');

                isEmailValid = atIndex > 0
                    && dotIndex > atIndex + 1
                    && dotIndex < sanitizedEmail.Length - 1
                    && !sanitizedEmail.Contains(" ")
                    && sanitizedEmail.IndexOf('@') == sanitizedEmail.LastIndexOf('@');
            }

            return isEmailValid;
        }

        private bool IsPasswordValid(string password)
        {
            bool isPasswordValid = true;
            List<string> passwordErrors = new List<string>();

            if (password.Length < MinimumPasswordLength)
            {
                passwordErrors.Add(View.Properties.Langs.Resources.Register_PasswordRuleLength);
            }

            if (!Regex.IsMatch(password, SpecialCharacterPattern))
            {
                passwordErrors.Add(View.Properties.Langs.Resources.Register_PasswordRuleSpecialChar);
            }

            if (!Regex.IsMatch(password, NumberPattern))
            {
                passwordErrors.Add(View.Properties.Langs.Resources.Register_PasswordRuleNumber);
            }

            if (passwordErrors.Count > 0)
            {
                MessageBox.Show(string.Join("\n", passwordErrors));
                Register_Password.Focus();
                isPasswordValid = false;
            }

            return isPasswordValid;
        }

        private bool ArePasswordsMatching(string password, string passwordConfirm)
        {
            bool areMatching = password.Equals(passwordConfirm, StringComparison.Ordinal);

            if (!areMatching)
            {
                MessageBox.Show(View.Properties.Langs.Resources.Register_PasswordMismatch);
                Register_PasswordConfirm.Focus();
            }

            return areMatching;
        }
    }
}
