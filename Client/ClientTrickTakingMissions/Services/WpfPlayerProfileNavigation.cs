using System.Linq;
using System.Windows;
using Model.Services;
using Model.Session;
using Model.PlayerProfileService;
using View.Views;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Services
{
    /// <summary>Opens a profile window without replacing or unloading the current lobby page.</summary>
    internal sealed class WpfPlayerProfileNavigation : IPlayerProfileNavigation
    {
        public void OpenProfileByUserId(int profileOwnerUserId)
        {
            OpenProfile(new PublicPlayerProfileLookup { ProfileOwnerUserId = profileOwnerUserId });
        }

        public void OpenProfileByUsername(string profileOwnerUsername)
        {
            OpenProfile(new PublicPlayerProfileLookup { ProfileOwnerUsername = profileOwnerUsername });
        }

        private static void OpenProfile(PublicPlayerProfileLookup profileLookup)
        {
            UserSessionData viewer = UserSession.Current.CurrentUser;
            profileLookup.AccountSessionToken = viewer?.AccountSessionToken;
            profileLookup.GuestViewerUserId = viewer?.IdUser ?? 0;
            profileLookup.GuestSessionToken = viewer?.GuestSessionToken;
            profileLookup.LobbyCode = LobbySession.Current.CurrentLobby?.LobbyCode;
            var profileClient = new PlayerProfileClient(ClientLoggingRuntime.CreateLogger<PlayerProfileClient>());
            var viewModel = new PlayerProfileViewModel(profileClient, ((App)Application.Current).ProfileImages,
                profileLookup);
            var profileWindow = new PlayerProfileWindow(viewModel)
            {
                Owner = Application.Current.Windows.OfType<Window>().FirstOrDefault(window => window.IsActive)
                    ?? Application.Current.MainWindow
            };
            profileWindow.ShowDialog();
        }
    }
}
