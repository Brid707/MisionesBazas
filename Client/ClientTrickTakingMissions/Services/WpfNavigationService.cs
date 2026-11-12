using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using TrickTakingMissions.Logging.Abstractions.Ports;
using View.Views;
using ViewModel.Constants;
using ViewModel.Services;

namespace View.Services
{
    /// <summary>
    /// WPF implementation of <see cref="INavigationService"/> utilizing integer view identifiers.
    /// Manages both MainFrame navigation and modal dialog lifecycles cleanly.
    /// </summary>
    public sealed class WpfNavigationService : INavigationService
    {
        private const string LogUnrecognizedViewId = "Unrecognized ViewId={ViewId} requested for navigation.";
        private const string LogUnrecognizedDialogId =
            "Unrecognized DialogId={DialogId} requested for modal presentation.";

        private static readonly Dictionary<int, Func<Page>> s_pageFactories = new Dictionary<int, Func<Page>>
        {
            { ViewId.HomeScreen, () => new HomeScreen() },
            { ViewId.LoginPage, () => new LoginPage() },
            { ViewId.RegisterPage, () => new RegisterPage() },
            { ViewId.GameMenu, () => new GameMenu() },
            { ViewId.Lobby, () => new Lobby() },
            { ViewId.Profile, () => new Profile() },
            { ViewId.RecoverPassword, () => new RecoverPassword() },
            { ViewId.SendFriendRequest, () => new SendFriendRequestPage() },
            { ViewId.GameMatch, () => new GameMatch() }
        };

        private static readonly Dictionary<int, Func<Window>> s_dialogFactories = new Dictionary<int, Func<Window>>
        {
            { ViewId.ForgotPasswordDialog, () => new ForgotPassword() },
            { ViewId.ChangePasswordDialog, () => new ChangePassword() },
            { ViewId.EnterGameCodeDialog, () => new EnterGameCode() },
            { ViewId.GameSettingsDialog, () => new GameSettings() },
            { ViewId.HowToPlayDialog, () => new HowToPlay() },
            { ViewId.ManageFriendRequestDialog, () => new ManageFriendRequestWindow() },
            { ViewId.ScoreBoardDialog, () => new ScoreBoard() },
            { ViewId.SelectLanguageDialog, () => new SelectLanguageWindow() }
        };

        private readonly ILoggerService _logger;

        public WpfNavigationService()
            : this(ClientLoggingRuntime.CreateLogger<WpfNavigationService>())
        {
        }

        public WpfNavigationService(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Navigates the main application frame to a page identified by its integer constant.
        /// </summary>
        /// <param name="viewId">The integer identifier from <see cref="ViewId"/>.</param>
        public void NavigateTo(int viewId)
        {
            Application.Current?.Dispatcher?.Invoke(() =>
            {
                if (s_pageFactories.TryGetValue(viewId, out var factory))
                {
                    MainWindow mainWindow = FindMainWindow();
                    if (mainWindow != null)
                    {
                        mainWindow.MainFrame.Navigate(factory());
                    }
                }
                else
                {
                    _logger.Warning(LogUnrecognizedViewId, viewId);
                }
            });
        }

        /// <summary>
        /// Navigates the main frame back in history, or to the home screen when there is no history.
        /// Never inspects or closes other application windows.
        /// </summary>
        public void GoBack()
        {
            Application.Current?.Dispatcher?.Invoke(() =>
            {
                MainWindow mainWindow = FindMainWindow();
                if (mainWindow != null)
                {
                    if (mainWindow.MainFrame.CanGoBack)
                    {
                        mainWindow.MainFrame.GoBack();
                    }
                    else
                    {
                        NavigateTo(ViewId.HomeScreen);
                    }
                }
            });
        }

        /// <summary>
        /// Opens a registered dialog window modally identified by its integer constant.
        /// </summary>
        /// <param name="dialogId">The integer identifier from <see cref="ViewId"/>.</param>
        public void ShowDialog(int dialogId)
        {
            Application.Current?.Dispatcher?.Invoke(() =>
            {
                if (s_dialogFactories.TryGetValue(dialogId, out var factory))
                {
                    Window dialog = factory();
                    Window owner = ResolveDialogOwner(dialog);
                    if (owner != null)
                    {
                        dialog.Owner = owner;
                    }

                    dialog.ShowDialog();
                }
                else
                {
                    _logger.Warning(LogUnrecognizedDialogId, dialogId);
                }
            });
        }

        private static MainWindow FindMainWindow()
        {
            MainWindow found = null;

            foreach (Window candidate in Application.Current.Windows)
            {
                if (candidate is MainWindow)
                {
                    found = (MainWindow)candidate;
                }
            }

            return found;
        }

        private static Window ResolveDialogOwner(Window dialog)
        {
            Window owner = null;

            foreach (Window candidate in Application.Current.Windows)
            {
                bool isValidOwner = candidate != dialog && candidate.IsVisible && candidate is MainWindow;
                if (isValidOwner)
                {
                    owner = candidate;
                }
            }

            return owner;
        }
    }
}
