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
        public static FontFamily TitleFontFamily { get; } = new FontFamily("Impact, Arial Black, Segoe UI");

        public static FontFamily BodyFontFamily { get; } = new FontFamily("Segoe UI");

        // Display and title font sizes.
        public const double HeroTitleFontSize = 80.0;
        public const double DisplayTitleFontSize = 66.0;
        public const double LargeTitleFontSize = 32.0;
        public const double SectionTitleFontSize = 28.0;
        public const double SubtitleFontSize = 24.0;

        // Interactive control and button font sizes.
        public const double PrimaryButtonFontSize = 22.0;
        public const double SecondaryButtonFontSize = 18.0;

        // Content and label font sizes.
        public const double HeaderFontSize = 20.0;
        public const double BodyFontSize = 16.0;
        public const double CardTitleFontSize = 14.0;
        public const double CaptionFontSize = 12.0;
        public const double SmallFontSize = 10.0;
    }
}
