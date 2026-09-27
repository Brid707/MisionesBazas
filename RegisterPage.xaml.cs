using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;

namespace MisionesBazas
{
    public partial class RegisterPage : Page
    {
        private static readonly HashSet<string> _registeredEmails = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "correo@ejemplo.com",
            "usuario@ejemplo.com",
            "test@test.com"
        };

        private static readonly HashSet<string> _registeredUsernames = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "TheFatBv",
            "admin",
            "usuario1"
        };

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
            var request = new RegistrationRequest(
                Register_Email.Text?.Trim() ?? string.Empty,
                Register_Username.Text?.Trim() ?? string.Empty,
                Register_Password.Password ?? string.Empty,
                Register_PasswordConfirm.Password ?? string.Empty
            );

            if (ValidateData(request))
            {
                RegisterUser(request.Email, request.Username);
            }
        }

        private bool ValidateData(RegistrationRequest request)
        {
            bool isDataValid = false;

            if (!AreFieldsEmpty(request)
                && ValidateEmail(request.Email)
                && ValidateUsername(request.Username)
                && ValidatePassword(request.Password)
                && ArePasswordsMatching(request.Password, request.PasswordConfirm))
            {
                isDataValid = true;
            }

            return isDataValid;
        }

        private bool AreFieldsEmpty(RegistrationRequest request)
        {
            bool areEmpty = true;

            if (string.IsNullOrWhiteSpace(request.Email))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.EmptyEmail"]);
                Register_Email.Focus();
            }
            else if (string.IsNullOrWhiteSpace(request.Username))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.EmptyUsername"]);
                Register_Username.Focus();
            }
            else if (string.IsNullOrEmpty(request.Password))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.EmptyPassword"]);
                Register_Password.Focus();
            }
            else if (string.IsNullOrEmpty(request.PasswordConfirm))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.EmptyPasswordConfirmation"]);
                Register_PasswordConfirm.Focus();
            }
            else
            {
                areEmpty = false;
            }

            return areEmpty;
        }

        private bool ValidateEmail(string email)
        {
            bool isEmailValid = false;

            if (!IsValidEmailFormat(email))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.InvalidEmail"]);
                Register_Email.Focus();
            }
            else if (HasRegisteredEmail(email))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.EmailAlreadyRegistered"]);
                Register_Email.Focus();
            }
            else
            {
                isEmailValid = true;
            }

            return isEmailValid;
        }

        private bool IsValidEmailFormat(string email)
        {
            bool isValid = false;

            if (!string.IsNullOrWhiteSpace(email))
            {
                isValid = Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,}$");
            }

            return isValid;
        }

        private bool HasRegisteredEmail(string email)
        {
            bool hasEmail = _registeredEmails.Contains(email);
            return hasEmail;
        }

        private bool ValidateUsername(string username)
        {
            bool isUsernameValid = true;

            if (HasRegisteredUsername(username))
            {
                MessageBox.Show(LocalizationManager.Instance["Register.UsernameAlreadyRegistered"]);
                Register_Username.Focus();
                isUsernameValid = false;
            }

            return isUsernameValid;
        }

        private bool HasRegisteredUsername(string username)
        {
            bool hasUsername = _registeredUsernames.Contains(username);
            return hasUsername;
        }

        private bool ValidatePassword(string password)
        {
            bool isPasswordValid = true;
            var passwordErrors = new List<string>();

            if (password.Length < 8)
            {
                passwordErrors.Add(LocalizationManager.Instance["Register.PasswordRuleLength"]);
            }

            if (!Regex.IsMatch(password, @"[^a-zA-Z0-9]"))
            {
                passwordErrors.Add(LocalizationManager.Instance["Register.PasswordRuleSpecialChar"]);
            }

            if (!Regex.IsMatch(password, @"[0-9]"))
            {
                passwordErrors.Add(LocalizationManager.Instance["Register.PasswordRuleNumber"]);
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
            bool areMatching = password.Equals(passwordConfirm);

            if (!areMatching)
            {
                MessageBox.Show(LocalizationManager.Instance["Register.PasswordMismatch"]);
                Register_PasswordConfirm.Focus();
            }

            return areMatching;
        }

        private void RegisterUser(string email, string username)
        {
            _registeredEmails.Add(email);
            _registeredUsernames.Add(username);

            MessageBox.Show(LocalizationManager.Instance["Register.Success"]);

            if (NavigationService != null && NavigationService.CanGoBack)
            {
                NavigationService.GoBack();
            }
            else
            {
                Window.GetWindow(this)?.Close();
            }
        }

        private sealed class RegistrationRequest
        {
            public string Email { get; }

            public string Username { get; }

            public string Password { get; }

            public string PasswordConfirm { get; }

            public RegistrationRequest(string email, string username, string password, string passwordConfirm)
            {
                Email = email;
                Username = username;
                Password = password;
                PasswordConfirm = passwordConfirm;
            }
        }
    }
}
