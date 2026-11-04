using System.Collections.Generic;
using System.Windows;
using ViewModel.Constants;
using ViewModel.Services;

namespace View.Services
{
    /// <summary>
    /// WPF implementation of <see cref="IDialogService"/> that maps integer message codes to localized strings.
    /// </summary>
    public sealed class WpfDialogService : IDialogService
    {
        private static readonly Dictionary<int, string> s_resourceKeys = new Dictionary<int, string>
        {
            { MessageCode.EmptyEmail, nameof(View.Properties.Langs.Resources.Login_EmptyEmail) },
            { MessageCode.EmptyPassword, nameof(View.Properties.Langs.Resources.Login_EmptyPassword) },
            { MessageCode.InvalidCredentials, nameof(View.Properties.Langs.Resources.Login_InvalidCredentials) },
            { MessageCode.RegisterInvalidEmail, nameof(View.Properties.Langs.Resources.Register_InvalidEmail) },
            { MessageCode.RegisterEmptyEmail, nameof(View.Properties.Langs.Resources.Register_EmptyEmail) },
            { MessageCode.RegisterEmptyUsername, nameof(View.Properties.Langs.Resources.Register_EmptyUsername) },
            { MessageCode.RegisterEmptyPassword, nameof(View.Properties.Langs.Resources.Register_EmptyPassword) },
            {
                MessageCode.RegisterEmptyPasswordConfirmation,
                nameof(View.Properties.Langs.Resources.Register_EmptyPasswordConfirmation)
            },
            {
                MessageCode.RegisterPasswordMismatch,
                nameof(View.Properties.Langs.Resources.Register_PasswordMismatch)
            },
            {
                MessageCode.RegisterPasswordRuleLength,
                nameof(View.Properties.Langs.Resources.Register_PasswordRuleLength)
            },
            {
                MessageCode.RegisterPasswordRuleSpecialChar,
                nameof(View.Properties.Langs.Resources.Register_PasswordRuleSpecialChar)
            },
            {
                MessageCode.RegisterPasswordRuleNumber,
                nameof(View.Properties.Langs.Resources.Register_PasswordRuleNumber)
            },
            {
                MessageCode.RegisterEmailAlreadyRegistered,
                nameof(View.Properties.Langs.Resources.Register_EmailAlreadyRegistered)
            },
            {
                MessageCode.RegisterUsernameAlreadyRegistered,
                nameof(View.Properties.Langs.Resources.Register_UsernameAlreadyRegistered)
            },
            { MessageCode.RegisterSuccess, nameof(View.Properties.Langs.Resources.Register_Success) },
            { MessageCode.EnterGameCodeEmptyCode, nameof(View.Properties.Langs.Resources.EnterGameCode_EmptyCode) },
            { MessageCode.EnterGameCodeInvalidCode, nameof(View.Properties.Langs.Resources.EnterGameCode_InvalidCode) },
            {
                MessageCode.EnterGameCodeLobbyAlreadyFull,
                nameof(View.Properties.Langs.Resources.EnterGameCode_LobbyAlreadyFull)
            },
            { MessageCode.EmptyFriendUsername, nameof(View.Properties.Langs.Resources.Register_EmptyUsername) },
            { MessageCode.ConnectionFailed, nameof(View.Properties.Langs.Resources.Common_Error_ConnectionFailed) },
            { MessageCode.RequestTimeout, nameof(View.Properties.Langs.Resources.Common_Error_Timeout) },
            { MessageCode.CommunicationError, nameof(View.Properties.Langs.Resources.Common_Error_Communication) },
            { MessageCode.UnexpectedError, nameof(View.Properties.Langs.Resources.Common_Error_Unexpected) }
        };

        /// <summary>
        /// Displays an informational alert box mapped from an integer message code.
        /// </summary>
        /// <param name="messageCode">The integer identifier from <see cref="MessageCode"/>.</param>
        public void ShowInformation(int messageCode)
        {
            string message = ResolveMessage(messageCode);
            Application.Current?.Dispatcher?.Invoke(() =>
            {
                MessageBox.Show(message,
                    View.Properties.Langs.Resources.MainWindow_Title,
                    MessageBoxButton.OK, MessageBoxImage.Information);
            });
        }

        /// <summary>
        /// Displays a warning alert box mapped from an integer message code.
        /// </summary>
        /// <param name="messageCode">The integer identifier from <see cref="MessageCode"/>.</param>
        public void ShowWarning(int messageCode)
        {
            string message = ResolveMessage(messageCode);
            Application.Current?.Dispatcher?.Invoke(() =>
            {
                MessageBox.Show(message,
                    View.Properties.Langs.Resources.MainWindow_Title,
                    MessageBoxButton.OK, MessageBoxImage.Warning);
            });
        }

        /// <summary>
        /// Displays an error alert box mapped from an integer message code.
        /// </summary>
        /// <param name="messageCode">The integer identifier from <see cref="MessageCode"/>.</param>
        public void ShowError(int messageCode)
        {
            string message = ResolveMessage(messageCode);
            Application.Current?.Dispatcher?.Invoke(() =>
            {
                MessageBox.Show(message,
                    View.Properties.Langs.Resources.MainWindow_Title,
                    MessageBoxButton.OK, MessageBoxImage.Error);
            });
        }

        private string ResolveMessage(int messageCode)
        {
            string resolvedText;

            if (s_resourceKeys.TryGetValue(messageCode, out var resourceKey))
            {
                string text = View.Properties.Langs.Resources.ResourceManager.GetString(resourceKey);
                if (!string.IsNullOrEmpty(text))
                {
                    resolvedText = text;
                }
                else
                {
                    resolvedText = resourceKey;
                }
            }
            else
            {
                resolvedText = View.Properties.Langs.Resources.Common_Error_Communication;
            }

            return resolvedText;
        }
    }
}
