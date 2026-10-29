namespace ViewModel.Constants
{
    /// <summary>
    /// Defines integer constants representing each view and modal dialog in the application.
    /// Avoids magic strings when requesting navigation from ViewModels.
    /// </summary>
    public static class ViewId
    {
        public const int None = 0;

        // Pages / Primary Views (1 - 99)
        public const int HomeScreen = 1;
        public const int LoginPage = 2;
        public const int RegisterPage = 3;
        public const int GameMenu = 4;
        public const int Lobby = 5;
        public const int Profile = 6;
        public const int RecoverPassword = 7;
        public const int SendFriendRequest = 8;

        // Modal Dialogs / Windows (100+)
        public const int ForgotPasswordDialog = 101;
        public const int ChangePasswordDialog = 102;
        public const int EnterGameCodeDialog = 103;
        public const int GameSettingsDialog = 104;
        public const int HowToPlayDialog = 105;
        public const int ManageFriendRequestDialog = 106;
        public const int ScoreBoardDialog = 107;
        public const int SelectLanguageDialog = 108;
    }
}
