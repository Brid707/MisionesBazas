using System.Windows.Input;
using Model.Session;
using TrickTakingMissions.Rules.Rules;
using ViewModel.Base;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>Shares profile-opening commands and limits guest entry points to the active lobby.</summary>
    public sealed class PlayerProfileCommands
    {
        private readonly IPlayerProfileNavigation _profileNavigation;
        private readonly bool _allowsGuestLobbyAccess;

        public PlayerProfileCommands(IPlayerProfileNavigation profileNavigation, bool allowsGuestLobbyAccess)
        {
            _profileNavigation = profileNavigation;
            _allowsGuestLobbyAccess = allowsGuestLobbyAccess;
            OpenByUserIdCommand = new RelayCommand(OpenByUserId, CanOpenByUserId);
            OpenByUsernameCommand = new RelayCommand(OpenByUsername, CanOpenByUsername);
        }

        public bool CanUseSocialFeatures => HasRegisteredAccount();

        public ICommand OpenByUserIdCommand { get; }

        public ICommand OpenByUsernameCommand { get; }

        private bool CanOpenByUserId(object parameter)
        {
            bool hasActiveGuestLobby = _allowsGuestLobbyAccess && LobbySession.Current.HasActiveLobby &&
                !string.IsNullOrEmpty(UserSession.Current.CurrentUser?.GuestSessionToken);
            return _profileNavigation != null && parameter is int profileOwnerUserId && profileOwnerUserId != 0 &&
                (HasRegisteredAccount() || hasActiveGuestLobby);
        }

        private bool CanOpenByUsername(object parameter)
        {
            return _profileNavigation != null && HasRegisteredAccount() && parameter is string username &&
                PlayerProfileLookupRules.IsProfileLookupValid(0, username.Trim());
        }

        private void OpenByUserId(object parameter)
        {
            if (CanOpenByUserId(parameter))
            {
                _profileNavigation.OpenProfileByUserId((int)parameter);
            }
        }

        private void OpenByUsername(object parameter)
        {
            if (CanOpenByUsername(parameter))
            {
                _profileNavigation.OpenProfileByUsername(((string)parameter).Trim());
            }
        }

        private static bool HasRegisteredAccount()
        {
            return UserSession.Current.CurrentUser?.IdUser > 0 &&
                !string.IsNullOrEmpty(UserSession.Current.CurrentUser.AccountSessionToken);
        }
    }
}
