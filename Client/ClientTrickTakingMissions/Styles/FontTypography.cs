using System.Windows.Media;

namespace View.Styles
{
    /// <summary>
    /// Centralizes typography definitions, font families, and standard font sizes for the client application.
    /// Eliminates hardcoded magic font strings and numeric sizes across views.
    /// </summary>
    public static class FontTypography
    {
        // Standard font families.
        public static FontFamily TitleFontFamily { get; } =
            new FontFamily("Impact, Arial Black, Segoe UI");

        public static FontFamily BodyFontFamily { get; } =
            new FontFamily("Segoe UI");

        // Display and hero title font sizes.
        public const double HeroTitleFontSize = 80.0;
        public const double DisplayTitleFontSize = 64.0;
        public const double ProfileTitleFontSize = 42.0;

        // Modal and window header font sizes.
        public const double LargeTitleFontSize = 32.0;
        public const double SectionTitleFontSize = 28.0;
        public const double MediumTitleFontSize = 26.0;
        public const double SubtitleFontSize = 24.0;

        // Interactive control and action button font sizes.
        public const double PrimaryActionFontSize = 22.0;
        public const double ActionButtonFontSize = 20.0;
        public const double SecondaryButtonFontSize = 18.0;

        // Content, label, and input font sizes.
        public const double FormLabelFontSize = 16.0;
        public const double BodyFontSize = 15.0;
        public const double CaptionFontSize = 14.0;
        public const double SmallFontSize = 12.0;
        public const double MicroFontSize = 10.0;
    }
}
