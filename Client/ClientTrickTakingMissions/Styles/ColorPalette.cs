using System.Windows.Media;

namespace View.Styles
{
    /// <summary>
    /// Centralizes semantic and component-based color definitions for the application user interface.
    /// Uses functional naming to decouple visual component roles from specific color tones.
    /// </summary>
    public static class ColorPalette
    {
        // Hexadecimal base constants.
        private const string WindowDarkRedHex = "#4A0003";
        private const string WindowMediumRedHex = "#700006";
        private const string WindowCrimsonRedHex = "#8A0B0B";
        private const string WindowBrightRedHex = "#910000";

        private const string AuthDarkRedHex = "#7A0006";
        private const string AuthMediumRedHex = "#B90A0A";
        private const string AuthBrightRedHex = "#C60B0B";

        private const string DialogDarkRedHex = "#540003";
        private const string DialogMediumRedHex = "#6E0005";
        private const string DialogCrimsonRedHex = "#7C0107";
        private const string DialogBrightRedHex = "#8A0B0B";

        private const string ModalDarkRedHex = "#8B0000";
        private const string ModalLightRedHex = "#D22020";

        private const string AccentYellowHex = "#FFF36B";
        private const string AccentCoralHex = "#FF6B6B";
        private const string DangerRedHex = "#D22020";
        private const string DeleteRedHex = "#EA4444";
        private const string SubmitAmberHex = "#D49B2A";
        private const string SuccessGreenHex = "#1A8A2B";
        private const string SuccessBrightGreenHex = "#127A20";
        private const string InviteGreenHex = "#2ECC71";
        private const string OnlineGreenHex = "#66FF66";
        private const string DarkButtonHex = "#2A0000";

        private const string SidebarBackgroundHex = "#8A0000";
        private const string LobbyContainerHex = "#7A0000";
        private const string DialogHeaderHex = "#5A0002";
        private const string FriendCardBackgroundHex = "#680000";
        private const string RequestCardBackgroundHex = "#6F0004";
        private const string CompactDialogBackgroundHex = "#6A0B0B";
        private const string TableRowHex = "#8A0B0B";
        private const string TableAlternateRowHex = "#94040D";

        private const string SecondaryTitleHex = "#F23A23";
        private const string DarkTextHex = "#0B0B0B";
        private const string OptionLabelTextHex = "#140000";
        private const string PureBlackHex = "#000000";
        private const string PureWhiteHex = "#FFFFFF";
        private const string LightBodyTextHex = "#ECECEC";
        private const string EmptyStateTextHex = "#FFDDDD";
        private const string AccentLinkTextHex = "#FF0099";
        private const string InputFieldLightRedHex = "#F04A4A";

        // Window background gradient stop colors.
        public static Color WindowBackgroundGradientStartColor { get; } =
            (Color)ColorConverter.ConvertFromString(WindowDarkRedHex);

        public static Color WindowBackgroundGradientStep1Color { get; } =
            (Color)ColorConverter.ConvertFromString(WindowMediumRedHex);

        public static Color WindowBackgroundGradientStep2Color { get; } =
            (Color)ColorConverter.ConvertFromString(WindowCrimsonRedHex);

        public static Color WindowBackgroundGradientEndColor { get; } =
            (Color)ColorConverter.ConvertFromString(WindowBrightRedHex);

        // Authentication view background gradient stop colors.
        public static Color AuthBackgroundGradientStartColor { get; } =
            (Color)ColorConverter.ConvertFromString(AuthDarkRedHex);

        public static Color AuthBackgroundGradientStepColor { get; } =
            (Color)ColorConverter.ConvertFromString(AuthMediumRedHex);

        public static Color AuthBackgroundGradientEndColor { get; } =
            (Color)ColorConverter.ConvertFromString(AuthBrightRedHex);

        // Modal and dialog background gradient stop colors.
        public static Color DialogBackgroundGradientStartColor { get; } =
            (Color)ColorConverter.ConvertFromString(DialogDarkRedHex);

        public static Color DialogBackgroundGradientStep1Color { get; } =
            (Color)ColorConverter.ConvertFromString(DialogMediumRedHex);

        public static Color DialogBackgroundGradientStep2Color { get; } =
            (Color)ColorConverter.ConvertFromString(DialogCrimsonRedHex);

        public static Color DialogBackgroundGradientEndColor { get; } =
            (Color)ColorConverter.ConvertFromString(DialogBrightRedHex);

        public static Color ModalAccentGradientStartColor { get; } =
            (Color)ColorConverter.ConvertFromString(ModalDarkRedHex);

        public static Color ModalAccentGradientEndColor { get; } =
            (Color)ColorConverter.ConvertFromString(ModalLightRedHex);

        // Action button background brushes.
        public static SolidColorBrush PrimaryButtonBackgroundBrush { get; } =
            CreateFrozenBrush(AccentYellowHex);

        public static SolidColorBrush SecondaryButtonBackgroundBrush { get; } =
            CreateFrozenBrush(AccentCoralHex);

        public static SolidColorBrush DangerButtonBackgroundBrush { get; } =
            CreateFrozenBrush(DangerRedHex);

        public static SolidColorBrush DeleteButtonBackgroundBrush { get; } =
            CreateFrozenBrush(DeleteRedHex);

        public static SolidColorBrush SubmitButtonBackgroundBrush { get; } =
            CreateFrozenBrush(SubmitAmberHex);

        public static SolidColorBrush SuccessButtonBackgroundBrush { get; } =
            CreateFrozenBrush(SuccessGreenHex);

        public static SolidColorBrush SuccessAlternativeButtonBackgroundBrush { get; } =
            CreateFrozenBrush(SuccessBrightGreenHex);

        public static SolidColorBrush InviteButtonBackgroundBrush { get; } =
            CreateFrozenBrush(InviteGreenHex);

        public static SolidColorBrush DarkButtonBackgroundBrush { get; } =
            CreateFrozenBrush(DarkButtonHex);

        // Panel and container background brushes.
        public static SolidColorBrush SidebarBackgroundBrush { get; } =
            CreateFrozenBrush(SidebarBackgroundHex);

        public static SolidColorBrush LobbyContainerBackgroundBrush { get; } =
            CreateFrozenBrush(LobbyContainerHex);

        public static SolidColorBrush CompactDialogBackgroundBrush { get; } =
            CreateFrozenBrush(CompactDialogBackgroundHex);

        public static SolidColorBrush DialogHeaderBackgroundBrush { get; } =
            CreateFrozenBrush(DialogHeaderHex);

        public static SolidColorBrush DialogContainerBackgroundBrush { get; } =
            CreateFrozenBrush(DialogDarkRedHex);

        public static SolidColorBrush FriendCardBackgroundBrush { get; } =
            CreateFrozenBrush(FriendCardBackgroundHex);

        public static SolidColorBrush RequestCardBackgroundBrush { get; } =
            CreateFrozenBrush(RequestCardBackgroundHex);

        public static SolidColorBrush PlayerSlotBackgroundBrush { get; } =
            CreateFrozenBrush(SidebarBackgroundHex);

        public static SolidColorBrush TableRowBackgroundBrush { get; } =
            CreateFrozenBrush(TableRowHex);

        public static SolidColorBrush TableAlternateRowBackgroundBrush { get; } =
            CreateFrozenBrush(TableAlternateRowHex);

        // Text and typography brushes.
        public static SolidColorBrush MainTitleTextBrush { get; } =
            CreateFrozenBrush(AccentYellowHex);

        public static SolidColorBrush SecondaryTitleTextBrush { get; } =
            CreateFrozenBrush(SecondaryTitleHex);

        public static SolidColorBrush OnlineStatusTextBrush { get; } =
            CreateFrozenBrush(OnlineGreenHex);

        public static SolidColorBrush DarkTextBrush { get; } =
            CreateFrozenBrush(DarkTextHex);

        public static SolidColorBrush OptionLabelTextBrush { get; } =
            CreateFrozenBrush(OptionLabelTextHex);

        public static SolidColorBrush PureBlackBrush { get; } =
            CreateFrozenBrush(PureBlackHex);

        public static SolidColorBrush PureWhiteBrush { get; } =
            CreateFrozenBrush(PureWhiteHex);

        public static SolidColorBrush LightBodyTextBrush { get; } =
            CreateFrozenBrush(LightBodyTextHex);

        public static SolidColorBrush EmptyStateTextBrush { get; } =
            CreateFrozenBrush(EmptyStateTextHex);

        public static SolidColorBrush AccentLinkTextBrush { get; } =
            CreateFrozenBrush(AccentLinkTextHex);

        // Input field brushes.
        public static SolidColorBrush InputFieldBackgroundBrush { get; } =
            CreateFrozenBrush(InputFieldLightRedHex);

        public static SolidColorBrush InputFieldBorderBrush { get; } =
            CreateFrozenBrush(ModalDarkRedHex);

        private static SolidColorBrush CreateFrozenBrush(string hexCode)
        {
            Color color = (Color)ColorConverter.ConvertFromString(hexCode);
            SolidColorBrush brush = new SolidColorBrush(color);
            brush.Freeze();
            return brush;
        }
    }
}
