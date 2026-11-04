using System;
using System.ComponentModel;
using System.Diagnostics;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Windows;
using Model.Session;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the main desktop host application window.
    /// </summary>
    public partial class MainWindow : Window
    {
        private const int GracefulDisconnectTimeoutMs = 500;

        /// <summary>
        /// Initializes a new instance of the <see cref="MainWindow"/> class.
        /// </summary>
        public MainWindow()
        {
            InitializeComponent();
            Closing += OnMainWindowClosing;

            try
            {
                HomeScreen homePage = new HomeScreen();
                MainFrame.Navigate(homePage);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[MainWindow] Failed to navigate to HomeScreen: {ex.Message}");
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
                        catch (CommunicationException)
                        {
                            // Network failure during shutdown is expected and suppressed.
                        }
                        catch (TimeoutException)
                        {
                            // Timeout during shutdown is expected and suppressed.
                        }
                    }).Wait(TimeSpan.FromMilliseconds(GracefulDisconnectTimeoutMs));
                }

                LobbySession.Current.ClearLobby();
            }
        }
    }
}
