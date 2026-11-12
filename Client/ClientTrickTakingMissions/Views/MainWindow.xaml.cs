using System;
using System.ComponentModel;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using View.Services;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the main desktop host application window.
    /// </summary>
    public partial class MainWindow : Window
    {
        private const int GracefulDisconnectTimeoutMs = 500;
        private const string LogHomeNavigationFailure = "Failed to navigate to initial HomeScreen view.";
        private const string LogLeaveLobbyCommunicationFailure =
            "Communication error leaving LobbyCode={LobbyCode} during window close ({ExceptionType}).";
        private const string LogLeaveLobbyTimeout =
            "Timed out leaving LobbyCode={LobbyCode} during window close ({ExceptionType}).";

        private readonly ILoggerService _logger;

        /// <summary>
        /// Initializes a new instance of the <see cref="MainWindow"/> class.
        /// </summary>
        public MainWindow()
        {
            InitializeComponent();
            _logger = ClientLoggingRuntime.CreateLogger<MainWindow>();
            Closing += OnMainWindowClosing;

            try
            {
                HomeScreen homePage = new HomeScreen();
                MainFrame.Navigate(homePage);
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, LogHomeNavigationFailure);
            }
        }

        private void OnMainWindowClosing(object sender, CancelEventArgs e)
        {
            if (LobbySession.Current.HasActiveLobby)
            {
                string lobbyCode = LobbySession.Current.CurrentLobby?.LobbyCode;
                int userId = UserSession.Current.EnsureActiveUserId();

                if (!string.IsNullOrWhiteSpace(lobbyCode))
                {
                    Task.Run(async () =>
                    {
                        try
                        {
                            await LobbySession.Current.Client.LeaveLobbyAsync(lobbyCode, userId);
                        }
                        catch (CommunicationException ex)
                        {
                            _logger.Warning(LogLeaveLobbyCommunicationFailure, lobbyCode, ex.GetType().Name);
                        }
                        catch (TimeoutException ex)
                        {
                            _logger.Warning(LogLeaveLobbyTimeout, lobbyCode, ex.GetType().Name);
                        }
                    }).Wait(TimeSpan.FromMilliseconds(GracefulDisconnectTimeoutMs));
                }

                LobbySession.Current.ClearLobby();
            }
        }
    }
}
