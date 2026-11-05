namespace ViewModel.Constants
{
    /// <summary>
    /// Defines integer constants representing user feedback, validation warnings, and network error messages.
    /// Avoids magic strings and decouples ViewModels from localized resource files.
    /// </summary>
    public static class MessageCode
    {
        public const int None = 0;

        // Login validation codes (1000 - 1009)
        public const int EmptyEmail = 1001;
        public const int EmptyPassword = 1002;
        public const int InvalidCredentials = 1003;
        public const int ChatAccountBanned = 1004;
        public const int ChatStorageUnavailable = 1005;

        // Register validation codes (1010 - 1029)
        public const int RegisterInvalidEmail = 1010;
        public const int RegisterEmptyEmail = 1011;
        public const int RegisterEmptyUsername = 1012;
        public const int RegisterEmptyPassword = 1013;
        public const int RegisterEmptyPasswordConfirmation = 1014;
        public const int RegisterPasswordMismatch = 1015;
        public const int RegisterPasswordRuleLength = 1016;
        public const int RegisterPasswordRuleSpecialChar = 1017;
        public const int RegisterPasswordRuleNumber = 1018;
        public const int RegisterEmailAlreadyRegistered = 1019;
        public const int RegisterUsernameAlreadyRegistered = 1020;
        public const int RegisterSuccess = 1021;
        public const int RegisterEmailPermanentlyBlocked = 1022;
        public const int AccountStorageUnavailable = 201;

        // Match codes (1030 - 1049)
        public const int EnterGameCodeEmptyCode = 1030;
        public const int EnterGameCodeInvalidCode = 1031;
        public const int EnterGameCodeLobbyAlreadyFull = 1032;
        public const int LobbyHostRequired = 1033;
        public const int LobbyConfigurationInvalid = 1034;
        public const int LobbyMatchInProgress = 1035;
        public const int LobbyKickedParticipantReentryDenied = 1036;

        // Social and friend request codes (1050 - 1069)
        public const int EmptyFriendUsername = 1050;

        // Network and communication codes (2000 - 2999)
        public const int ConnectionFailed = 2001;
        public const int RequestTimeout = 2002;
        public const int CommunicationError = 2003;
        public const int UnexpectedError = 2004;
    }
}
